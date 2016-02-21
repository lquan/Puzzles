#!/usr/bin/env python3
#
# reghex.py -- checker for reghex puzzle
#
# Input on stdin in the following format:
#     
#   XXXXXXX
#   XXXXXXXX
#   XXXXXXXXX
#   XXXXXXXXXX
#   XXXXXXXXXXX
#   XXXXXXXXXXXX
#   XXXXXXXXXXXXX
#   XXXXXXXXXXXX
#   XXXXXXXXXXX
#   XXXXXXXXXX
#   XXXXXXXXX
#   XXXXXXXX
#   XXXXXXX
 
from itertools import count
import re
import sys
 
patterns = r'''
    .*H.*H.*
    (DI|NS|TH|OM)*
    F.*[AO].*[AO].*
    (O|RHH|MM)*
    .*
    C*MC(CCC|MM)*
    [^C]*[^R]*III.*
    (...?)\1*
    ([^X]|XCC)*
    (RR|HHH)*.?
    N.*X.X.X.*E
    R*D*M*
    .(C|HH)*
 
    .*G.*V.*H.*
    [CR]*
    .*XEXM*
    .*DD.*CCM.*
    .*XHCR.*X.*
    .*(.)(.)(.)(.)\4\3\2\1.*
    .*(IN|SE|HI)
    [^C]*MMM[^C]*
    .*(.)C\1X\1.*
    [CEIMU]*OH[AEMOR]*
    (RX|[^R])*
    [^M]*M[^M]*
    (S|MM|HHH)*
 
    .*SE.*UE.*
    .*LR.*RL.*
    .*OXR.*
    ([^EMC]|EM)*
    (HHX|[^HX])*
    .*PRR.*DDC.*
    .*
    [AM]*CM(RC)*R?
    ([^MC]|MM|CC)*
    (E|CR|MN)*
    P+(..)\1.*
    [CHMNOR]*I[CHMNOR]*
    (ND|ET|IN)[^X]*
    '''.split()
 
def rotate(grid):
    grid = [
        '{:>13}'.format(s) if i < 6 else '{:<13}'.format(s)
        for i, s in enumerate(grid)
        ]
    grid = [
        ''.join(grid[12-j][i] for j in range(13)).strip()
        for i in range(13)
        ]
    return grid
 
grid = [s.strip() for s in sys.stdin.read().split()]
 
west = grid
southeast = grid = rotate(grid)
northeast = grid = rotate(grid)
assert west == rotate(grid)
 
fails = 0
for i, patt, line in zip(count(1), patterns, west + southeast + northeast):
    matched = re.match(patt + '$', line)
    print("{}. {} {} {}".format(i, line,
        "matches" if matched else "does NOT match", patt))
    if not matched:
        fails += 1
 
if fails:
    print("\n{} failed matches".format(fails))
else:
    print("\nPerfect!")