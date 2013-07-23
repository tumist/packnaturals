#!/usr/bin/env python
"""URL-safe order-preserving natural-number packer."""
from __future__ import print_function
ABC = 'hdOBCH8Rz~926xKW_vLABCwl0Ey3aYpUPkqZ7Q4fVjFgJcXDbTumiSteInGr1Ms5oN'

def pack(numbers):
    assert all([isinstance(n, int) and n>=0 for n in numbers])
    segments = []
    for n in numbers:
        if n == 0:
            segments.append(ABC[2**5])
            continue
        bucket = []
        while n:
            i = n % 2**5
            n //= 2**5
            if n:
                bucket.append(i)
            else:
                bucket.append(i + 2**5)
        segments.append(''.join([ABC[x] for x in bucket]))
    return ''.join(segments)

def unpack(string):
    numbers = []
    shift = carry = 0
    for s in string:
        n = ABC.index(s)
        if n < 2**5:
            carry += (n << shift)
            shift += 5
        else:
            n -= 2**5
            numbers.append(carry + (n << shift))
            shift = carry = 0
    return numbers

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