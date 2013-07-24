packnaturals
============

##### because numbers don't need that many bytes


This python module packs/encodes a collection of natural numbers to a string
somewhat space efficiently.

The alphabet consists of A-z, 0-9, ~ and _ which makes a total of 64 URL-safe
characters. While 6 bits fit in to each character, the high bit of each
character is used as a number delimiter. The space requirements are as follows:

* 0-31:          1 character.
* 32-1023:       2 characters.
* 1024-32767:    3 characters.
* 32768-1048575: 4 characters, etc...

This method typically achieves a 35-50% compression ratio over a
digit-and-delimiter approach, i.e. ','.join(list_of_natural_numbers).


Examples
--------

Pack some primes

```
% python packnaturals_ordered.py 2 3 5 7 11 13 17 19 23 29
packed   : 7QfjcDmSn5
unpacked : 2 3 5 7 11 13 17 19 23 29
```

Order-preserving vs. non-order-preserving

```
% python packnaturals.py 12 13 87 99 111 104 102 100 1337 42
packed   : XZ5xZXZ77j98Z
unpacked : 12 13 42 87 99 100 102 104 111 1337

% python packnaturals_ordered.py 12 13 87 99 111 104 102 100 1337 42
packed   : XDE7BQWQzQ8QCQ3~Z9Z
unpacked : 12 13 87 99 111 104 102 100 1337 42
```
