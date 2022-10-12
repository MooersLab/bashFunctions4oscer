#!/usr/bin/python
# -*- coding: utf-8 -*-
from __future__ import print_function
import argparse
import os
import fnmatch
import sys
import shutil
import re


"""

Replace all occurences of 'foo' with 'bar'
    "foo-foo.txt" >> "bar-bar.txt"

rename.py . 'foo' 'bar' -s

Only replace 'foo' at the beginning of the filename
    "foo-foo.txt" >> "bar-foo.txt"
    ren.py . '^foo' 'bar' -s

Rename "spam.txt" to "spam.py"
    ren.py . '(.+)\.txt' '\1.py' -s 

Rename "12-lovely-spam.txt" to "lovely-spam-12.txt"
# (assuming two digits at the beginning and a 3 character extension 
ren.py . '^(\d{2})-(.+)\.(.{3})' '\2-\1.\3' -s

NOTE: don't forget to add -w when you tested the results and want to actually write the changes.
"""

    pattern_old = re.compile(args.search_for)

    for path, dirs, files in os.walk(os.path.abspath(args.root_folder)):

        for filename in fnmatch.filter(files, "*.*"):

            if pattern_old.findall(filename):
                new_name = pattern_old.sub(args.replace_with, filename)

                filepath_old = os.path.join(path, filename)
                filepath_new = os.path.join(path, new_name)

                if not new_name:
                    print('Replacement regex {} returns empty value! Skipping'.format(args.replace_with))
                    continue

                print(new_name)

                if args.write_changes:
                    shutil.move(filepath_old, filepath_new)
            else:
                if not args.suppress_non_matching:
                    print('Name [{}] does not match search regex [{}]'.format(filename, args.search_for))


if __name__ == '__main__':

    parser = argparse.ArgumentParser(description='Recursive file name renaming with regex support')

    parser.add_argument('root_folder',
                        help='Top folder for the replacement operation',
                        nargs='?',
                        action='store',
                        default='.')
    parser.add_argument('search_for',
                        help='string to search for',
                        action='store')
    parser.add_argument('replace_with',
                        help='string to replace with',
                        action='store')
    parser.add_argument('-w', '--write-changes',
                        action='store_true',
                        help='Write changes to files (otherwise just simulate the operation)',
                        default=False)
    parser.add_argument('-s', '--suppress-non-matching',
                        action='store_true',
                        help='Hide files that do not match',
                        default=False)

    args = parser.parse_args(sys.argv[1:])

    print(args)
    rename_files(args)
