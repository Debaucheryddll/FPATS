# This file is part of Linien and based on redpid.
#
# Copyright (C) 2016-2024 Linien Authors (https://github.com/linien-org/linien#license)
#
# Linien is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Linien is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Linien.  If not, see <http://www.gnu.org/licenses/>.


from . import csrmap
from .iir_coeffs import get_params


class PythonCSR:
    map = csrmap.csr
    constants = csrmap.csr_constants
    offset = 0x40300000

    def __init__(self, rp) -> None:
        self.rp = rp

    def set_one(self, addr: int, value: int) -> None:
        self.rp.write(addr, value)

    def get_one(self, addr: int):
        return int(self.rp.read(addr))

    def set(self, name: str, value: int) -> None:
        map, addr, width, wr = self.map[name]
        assert wr, name

        ma = 1 << width
        bit_mask = ma - 1
        val = value & bit_mask
        assert value == val or ma + value == val, (
            f"Value for {name} out of range",
            (value, val, ma),
        )

        b = (width + 8 - 1) // 8
        for i in range(b):
            v = (val >> (8 * (b - i - 1))) & 0xFF
            self.set_one(self.offset + (map << 11) + ((addr + i) << 2), v)

    def get(self, name: str) -> int:
        if name in self.constants:
            return self.constants[name]

        map, addr, nr, wr = self.map[name]
        b = (nr + 8 - 1) // 8
        base_addr = self.offset + (map << 11) + (addr << 2)
        if b == 1:
            return self.get_one(base_addr)

        values = self.rp.reads(base_addr, b)
        v = 0
        for i, word in enumerate(values):
            v |= (int(word) & 0xFF) << (8 * (b - i - 1))
        return v

    def get_many(self, names: list[str]) -> dict[str, int]:
        """Read multiple CSRs with batched MMIO transactions."""
        if not names:
            return {}

        results: dict[str, int] = {}
        requests: list[tuple[str, int, int]] = []

        for name in names:
            if name in self.constants:
                results[name] = self.constants[name]
                continue

            map, addr, nr, _ = self.map[name]
            n_bytes = (nr + 8 - 1) // 8
            base_addr = self.offset + (map << 11) + (addr << 2)
            requests.append((name, base_addr, n_bytes))

        if not requests:
            return results

        requests.sort(key=lambda item: item[1])

        request_idx = 0
        n_requests = len(requests)
        while request_idx < n_requests:
            _, range_start, _ = requests[request_idx]
            range_end = range_start
            range_requests: list[tuple[str, int, int]] = []

            while request_idx < n_requests:
                name, base_addr, n_bytes = requests[request_idx]
                end_addr = base_addr + ((n_bytes - 1) * 4)
                if range_requests and (base_addr >> 11) != (range_start >> 11):
                    break

                range_end = max(range_end, end_addr)
                range_requests.append((name, base_addr, n_bytes))
                request_idx += 1

            read_len = ((range_end - range_start) // 4) + 1
            range_words = [
                int(value) & 0xFF
                for value in self.rp.reads(range_start, read_len)
            ]

            for name, base_addr, n_bytes in range_requests:
                start_idx = (base_addr - range_start) // 4
                value = 0
                for i in range(n_bytes):
                    value |= range_words[start_idx + i] << (8 * (n_bytes - i - 1))
                results[name] = value

        return results

    def set_iir(self, prefix: str, b: list[float], a: list[float]) -> None:
        shift = self.get(prefix + "_shift") or 16
        width = self.get(prefix + "_width") or 18
        bb, _, params = get_params(b, a, shift, width)

        for k in sorted(params):
            self.set(prefix + "_" + k, params[k])
        self.set(prefix + "_z0", 0)
        for i in range(len(bb), 3):
            n = prefix + f"_b{i}"
            if n in self.map:
                self.set(n, 0)
                self.set(prefix + f"_a{i}", 0)

    def states(self, *names):
        return sum(1 << csrmap.states.index(name) for name in names)
