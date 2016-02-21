def getelements(n, line, horizontal=True):
	for i, token in enumerate(line.strip(), start = 1):
		if token != "<" and token != ">":
			raise Exception("Invalid input: must be < or >")
			
		if horizontal:
			yield "Board[{0},{1}] #{4} Board[{2},{3}]".format(n, i, n, i+1, token)
		else:
			yield "Board[{0},{1}] #{4} Board[{2},{3}]".format(i, n, i+1, n, token)

		

with open('output.txt', 'w') as out:

	with open('data_horizontal.txt', 'r') as f:
		for counter, line in enumerate(f, start=1):
			for el in getelements(counter, line):
				out.write(el)
				out.write(",\n")
		
	with open('data_vertical.txt', 'r') as f:
		for counter, line in enumerate(f, start=1):	
			for el in getelements(counter, line, False):
				out.write(el)
				out.write(",\n")