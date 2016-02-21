import itertools

def solve(resistors):
	result = set()
	for permuted in itertools.permutations(resistors):
		r1 = permuted[0]
		r2 = permuted[1]
		r3 = permuted[2]
		r4 = permuted[3]
		
		parallel = (r1 * r2) / float(r1+r2)
		series = r3 * r4 / float(r3 + r4)
		
		total = parallel + series
		result.add(total)
	
	return result

	

if __name__ == "__main__":
	n = solve([30, 100, 300, 700])
	e = solve([3,200,300,400])

	result = [(x,y) for x in n for y in e]
	print(result)