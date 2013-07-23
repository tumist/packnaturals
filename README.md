This python module packs/encodes a collection of natural numbers to a string
somewhat space efficiently.

The alphabet consists of A-z, 0-9, ~ and _ which makes a total of 64 URL-safe
characters. While 6 bits fit in to each character, the high bit of each
character is used as a number delimiter. The space requirements are as follows:

 0-31:          1 character.
 32-1023:       2 characters.
 1024-32767:    3 characters.
 32768-1048575: 4 characters, etc...

This method typically achieves a 35-50% compression ratio over a
digit-and-delimiter approach, i.e. ','.join(list_of_natural_numbers).