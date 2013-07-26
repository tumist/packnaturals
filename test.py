#!/usr/bin/env python
# -*- coding: utf-8 -*-
import random
import unittest
import packnaturals
import packnaturals_ordered

def random_list(size, min=0, max=10**6):
    return [random.randint(min, max) for n in range(size)]


class TestOrdered(unittest.TestCase):
    module = packnaturals_ordered

    @staticmethod
    def eq(a, b):
        return a == b

    def test_huge_list_small_numbers(self):
        my_list = random_list(256, max=10)
        self.assertTrue(
            self.eq(
                self.module.unpack(self.module.pack(my_list)),
                my_list))

    def test_small_list_huge_numbers(self):
        my_list = random_list(32, max=10**100)
        self.assertTrue(
            self.eq(
                self.module.unpack(self.module.pack(my_list)),
                my_list))

    def test_cardinality(self):
        my_list = [8, 8, 8] + random_list(10, max=2**6)
        self.assertEquals(len(self.module.unpack(
            self.module.pack(my_list))), len(my_list))


class TestUnordered(TestOrdered):
    module = packnaturals

    @staticmethod
    def eq(a, b):
        try:
            for val in a:
                b.remove(val)
        except ValueError:
            return False
        return b == []




if __name__ == '__main__':
    unittest.main()
