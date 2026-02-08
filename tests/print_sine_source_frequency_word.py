#!/usr/bin/env python3
"""Convert DDS frequency tuning words (FTW) and print expected output frequency.

Usage examples:
  python tests/print_sine_source_frequency_word.py --am-ftw 343597384
  python tests/print_sine_source_frequency_word.py --target-freq-hz 10000000
"""

from __future__ import annotations

import argparse

CLK_FREQ_HZ = 125_000_000
PHASE_BITS = 32


def ftw_to_hz(ftw: int, clk_freq_hz: int = CLK_FREQ_HZ, phase_bits: int = PHASE_BITS) -> float:
    return ftw * clk_freq_hz / float(1 << phase_bits)


def hz_to_ftw(freq_hz: float, clk_freq_hz: int = CLK_FREQ_HZ, phase_bits: int = PHASE_BITS) -> int:
    return int(round(freq_hz * (1 << phase_bits) / clk_freq_hz))


def main() -> None:
    parser = argparse.ArgumentParser(
        description=(
            "Use AM frequency FTW directly as sine_source FTW and print the resulting frequency."
        )
    )
    parser.add_argument(
        "--am-ftw",
        type=int,
        help="AM modulation frequency tuning word (32-bit).",
    )
    parser.add_argument(
        "--target-freq-hz",
        type=float,
        help="Target frequency in Hz to generate a FTW.",
    )
    args = parser.parse_args()

    if args.am_ftw is None and args.target_freq_hz is None:
        print("No arguments provided. Showing usage and a quick example:\n")
        parser.print_help()
        print(
            "\nExample:\n"
            "  python tests/print_sine_source_frequency_word.py "
            "--target-freq-hz 10000000 --am-ftw 343597384"
        )
        return

    if args.target_freq_hz is not None:
        target_ftw = hz_to_ftw(args.target_freq_hz)
        recovered_freq_hz = ftw_to_hz(target_ftw)
        print(f"Target frequency: {args.target_freq_hz:.6f} Hz")
        print(f"Computed FTW  : {target_ftw} (0x{target_ftw:08X})")
        print(f"Recovered freq: {recovered_freq_hz:.6f} Hz")
        print(f"Error         : {recovered_freq_hz - args.target_freq_hz:+.6f} Hz")
        print()

    if args.am_ftw is not None:
        sine_source_ftw = args.am_ftw
        output_freq_hz = ftw_to_hz(sine_source_ftw)
        print(f"AM FTW             : {args.am_ftw} (0x{args.am_ftw:08X})")
        print(f"sine_source FTW    : {sine_source_ftw} (directly reused)")
        print(f"Expected sine freq : {output_freq_hz:.6f} Hz")


if __name__ == "__main__":
    main()