#! /usr/local/bin/python

# Import sys for access to argv, import glob for wildcard
# file path matching
import sys,glob

# For each sent path (regardless of no)
for path in sys.argv[1:]:
  # For all files matching the pattern *.txt
  for filepath in glob.glob(path+"*.txt"):
    # Get a filehandle with read
    file = open(filepath, 'r')
    # Run readline() twice
    print file.name
    for _ in xrange(2): print file.readline()

