#!/usr/bin/env python3
from prueba.kbhit import KBHit 
kb = KBHit()
while True:
    c = kb.getch()
    c_ord = ord(c)
    if (c_ord != 27):
        print(c)
    else:
        break