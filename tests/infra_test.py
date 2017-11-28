# pylint: disable=missing-docstring, line-too-long, protected-access
import unittest
from runner import Runner


class TestE2E(unittest.TestCase):
    def test_nothing(self):
        self.assertEqual(False, False)


if __name__ == '__main__':
    unittest.main()
