#!/usr/bin/env python3

# Compare versions extracted from two files.
#	Exit code is zero if they are the same.
#	Exit code is non-zero if they are different, or if an error occurs.

# This script was written for use by .git/hooks/pre-commit.

def get_version_from_py_file(path):
	file = open(path, 'r')
	exec(file.read())
	file.close()
	# Variables from a script executed inside a function using exec()
	# need to be accessed using the locals() namespace.
	# https://realpython.com/python-namespaces-scope/#the-local-and-enclosing-namespaces
	a = locals()['major']
	b = locals()['minor']
	c = locals()['patch']
	# Use the modulo operator for string interpolation rather than an f-string,
	# so if Python 2 is used to run this script, the sys.version_info check
	# will report an error, instead of a syntax error occuring.
	return '%d.%d.%d' % (a, b, c)

def get_version_from_cfg_file(path):
	file = open(path, 'r')
	import configparser
	config = configparser.ConfigParser()
	config.read(path)
	file.close()
	return config['plugin']['version'].strip('"')

def get_version_from_file(path):
	if path.endswith('.py'):
		v = get_version_from_py_file(path)
	elif path.endswith('.cfg'):
		v = get_version_from_cfg_file(path)
	else:
		v = ''
	return v

import sys

if sys.version_info[0] < 3:
	print('This script requires Python 3.')
	sys.exit(1)

if len(sys.argv) < 2:
	print('Two paths must be specified.')
	sys.exit(1)

v1 = get_version_from_file(sys.argv[1])
v2 = get_version_from_file(sys.argv[2])

sys.exit(0 if (v1 == v2) else 1)
