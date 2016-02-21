import re

listN1 = []
listN2 = []
listN3 = []

listE1 = []
listE2 = []
listE3 = []

listN = []
listE = []

with open('data.txt', 'r') as f:
	data = f.read()
	list = re.findall("N(\d{2}).\s+(\d{2})\.(\d{3})\s+E(\d{3}).\s+(\d{2})\.(\d{3})",data)
	
	for N1,N2,N3,E1,E2,E3 in list:
		listN1.append(int(N1))
		listN2.append(int(N2))
		listN3.append(int(N3))
		listE1.append(int(E1))
		listE2.append(int(E2))
		listE3.append(int(E3))
		
		decimalN = int(N2) + int(N3)/1000.0
		decimalE = int(E2) + int(E3)/1000.0
		
		#listN.append(decimalN)
		#listE.append(decimalE)
		listN.append(int(N1) + decimalN/60.0)
		listE.append(int(E1) + decimalE/60.0)
		
	#print "all coordinates"
	#print "\n".join(map(str,list))
	
	#print "gemiddelde"
	#print "N", sum(listN)/float(len(listN))
	#print "E", sum(listE)/float(len(listE))
	#print "N", sum(listN1)/float(len(listN1)), "/", sum(listN2)/float(len(listN2)), "/", sum(listN3)/float(len(listN3))
	#print "E", sum(listE1)/float(len(listE1)), "/", sum(listE2)/float(len(listE2)), "/", sum(listE3)/float(len(listE3))
	
	
	#print "mediaan"
	#print "N", sorted(listN1)[len(listN1)//2], "/", sorted(listN2)[len(listN2)//2], "/", sorted(listN3)[len(listN3)//2]
	#print "E", sorted(listE1)[len(listE1)//2], "/", sorted(listE2)[len(listE2)//2], "/", sorted(listE3)[len(listE3)//2]
	
	
	#print listN1
	#print listN2
	#print listN3
	#print listE1
	#print listE2
	#print listE3
	
	
	for N,E in zip(listN,listE):
		print "%s %s" % (N,E)
		