with open("kolommen.txt", "r") as f:
	with open("kolommen2.txt", "w") as f2:
		output_lines = []
		for line in f:
			newline = "[" + line.strip().replace(".", ",") + "]"
			output_lines.append(newline)
			
		f2.write("[")
		f2.write(",\n".join(output_lines))
		f2.write("]")
		
		
with open("rijen.txt", "r") as f:
	with open("rijen2.txt", "w") as f2:
		output_lines = []
		for line in f:
			newline = "[" + line.strip().replace(".", ",") + "]"
			output_lines.append(newline)
			
		f2.write("[")
		f2.write(",\n".join(output_lines))
		f2.write("]")