blackindex = [3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33]
blackindex += [36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70, 72] 
blackindex += [75,77,79,81,83,85,87,89,91,93,95,97,99]

with open('data.txt', 'r') as f1:
	with open('dataout_N.txt', 'w') as f2:
		with open('dataout_E.txt', 'w') as f3:
			header = "clear;\n" + "A=zeros(7,17);\n"
			f2.write(header)
			f3.write(header)
			for index, line in enumerate(f1,1):
				if index == 1 or index == 2:
					continue #stupid beginning images are skipped
					
				txt = 'A(' + line.strip() + ')=1;' + '\n'
				if index in blackindex:
					f2.write(txt)
				else:
					f3.write(txt)
			
			footer = "spy(A)"
			f2.write(footer)
			f3.write(footer)
		
	

		
		