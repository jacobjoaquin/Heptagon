sr = 44100
kr = 735
ksmps = 60
nchnls = 1
0dbfs = 1.0

instr 1
	idur = p3
	iamp = p4
	ifreq = p5
	k1 line 1, idur, 0
	a1 oscils iamp, ifreq, 1
	out a1 * k1
endin

