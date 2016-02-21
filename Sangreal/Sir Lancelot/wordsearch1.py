import string

def make_rot_n(n):
	lc = string.lowercase
	trans = string.maketrans(lc, lc[n:] + lc[:n])
	return lambda s: string.translate(s, trans)

def f(g,W):
	w=g.find("\n")+1
	L=len(W)
	return " --> ".join("row %s, column %s"%(x/w+1,x%w+1) for i in range(len(g)) for j in(-w-1,-w,-w+1,-1,1,w-1,w,w+1) for x in(i,i+(L-1)*j) if g[i::j][:L]==W)

rotshifts = [0,13,25]

with open('data.txt', 'r') as gridfile:
	grid = gridfile.read()
	grid = grid.replace(" ", "").lower()

with open('words.txt', 'r') as f2:
	words = [word.strip().lower() for word in f2]
	
found = []
for rot in rotshifts:
	print "rot", rot
	rot_fun = make_rot_n(rot)
	for word in words:
		word_encrypted = rot_fun(word)
		result = f(grid, word_encrypted)
		if result:
			if word not in found:
				found.append(word)
				
			print word, word_encrypted, result
		else:
			pass
			#print word, word_encrypted
				
not_found = []
print "not found"

for word in words:
	if word not in found:
		encrypted = []
		for rot in rotshifts:
			rot_fun = make_rot_n(rot)
			encrypted.append(rot_fun(word))
			
		print word, encrypted
		not_found.append(word)
					
