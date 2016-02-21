#!/usr/bin/env python

import re

def verify_file(file):
	count_total = 0
	count_correct = 0
	re_file = re.compile(r'(?P<count>\d+)\s+"(?P<regex>.*)"\s+(?P<word>\w+)')
	for line in file:
		result = re_file.match(line)
		if result:
			count_total += 1
			regex = result.group("regex")
			word = result.group("word")
			if len(word) == int(result.group("count")) and re.match(regex, word) is not None:
				#print 'verified regex %s for word %s' % (regex, word) 
				count_correct += 1
			else:
				print 'check regex "%s" for word "%s"' % (regex, word)
	
	print "#######################################################################"
	print "correct number of regex-words:", count_correct
	print "total number of regex-words (should be 3x13=39):", count_total
	print "#######################################################################"
		

if __name__ == "__main__":
	with open("data.txt", 'r') as f:
		verify_file(f)