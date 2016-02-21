import re, string

n = 22
matrix = [[0 for x in xrange(n)] for x in xrange(n)] 

with open("wordsearch_stage1.txt", 'r') as txt:
	for line in txt:
		m = re.search("row (\d+), column (\d+) --> row (\d+), column (\d+)", line)
		if m:
			r1, c1, r2, c2 = int(m.group(1)), int(m.group(2)), int(m.group(3)), int(m.group(4))
			#print r1, c1, r2, c2
			
			length = max(abs(r2-r1), abs(c2-c1))+1

			if r1 < r2:
				rs = range(r1,r2+1)
			elif r2 < r1:
				rs = range(r1,r2-1, -1)
			else:
				rs = [r1] * length
				
			if c1 < c2:
				cs = range(c1,c2+1)
			elif c2 < c1:
				cs = range(c1,c2-1, -1)
			else:
				cs = [c1] * length
			
			#print zip(rs,cs)

			for r,c in zip(rs, cs):
				#print r,c
				matrix[r-1][c-1] = 1
			
	
matrix2 = []
with open('data.txt', 'r') as gridfile:
	for line in gridfile:
		row = [char for char in line.strip().replace(" ", "")]
		matrix2.append(row)
print matrix2


result = []
for x in xrange(n):
	for y in xrange(n):
		if matrix[x][y] == 0: #not yet used
			result.append(matrix2[x][y])
			
text = ''.join(result)
print text
		
			
