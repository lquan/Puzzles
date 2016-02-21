with open("mordred_data3.txt", "r") as f:
	with open("mordred_data5.txt", "w") as f2:
		output_lines = []
		for line in f:
			newline = [x for x in line.strip() if x.strip()]
			newline = ",".join(newline) 
			output_lines.append(newline)
			
		f2.write("[\n")
		f2.write(",\n".join(output_lines))
		f2.write("\n]")