xstep = abs(54.689 - 55.229)/10
ystep = abs(14.569 - 15.424)/10


houses = [(1,1), (3,3), (7,2), (2,6), (6,6), (8,8), (4,8)]
coordinates = [ (x,y) for x in range(0,11) for y in range(0,11) ]
minsum = float('inf')
searchco = (0,0) 
for (x,y) in coordinates: 
	sum = 0
	for (xx,yy) in houses: 
		sum += abs(x-xx) + abs(y-yy) 
	if sum < minsum: 
		searchco = (x,y) 
		minsum = sum 
		print("found coordinates with minimum sum")
		print(searchco)
		print(minsum)
		print()


print("FINISH: found coordinates with minimum sum")
print(searchco)
print(minsum)
print( "N50", 55.229 - searchco[0] * xstep)
print( "E3",  14.569 + searchco[1] * ystep)	
		
   
