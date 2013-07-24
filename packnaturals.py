#!/usr/bin/env python
"""URL-safe natural-number packer.

This module extends the packnaturals_ordered implementation to achieve
more compression (especially when you have clusters of numbers)  at the
expense of ordering.
"""
from __future__ import print_function
import packnaturals_ordered

to_list_decor = lambda func: lambda arg: list(func(arg))

def pack(numbers):
    s = sorted(numbers)
    rel = s[:1] + [a-b for a, b in zip(s[1:], s)]
    return packnaturals_ordered.pack(rel)

@to_list_decor
def unpack(string):
    rel = packnaturals_ordered.unpack(string)
    incr = 0
    for n in rel:
        incr += n
        yield incr

if __name__ == "__main__":
    import sys
    try:
        numbers = [int(num) for num in sys.argv[1:]]
        if not numbers or not all([num >= 0 for num in numbers]):
            raise ValueError
    except ValueError:
        print("Usage: {0} <num1> [num2 num3 ...]".format(sys.argv[0]))
        sys.exit(1)
    packed = pack(numbers)
    print("packed   :", packed)
    unpacked = unpack(packed)
    print("unpacked :", ' '.join([str(n) for n in unpacked]))
