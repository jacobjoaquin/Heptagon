sr = 44100
kr = 735
ksmps = 60
nchnls = 1
0dbfs = 1.0

; Test
instr 1
	idur = p3
	iamp = p4
	ifreq = p5
	k1 line 1, idur, 0
	a1 oscils iamp, ifreq, 1
	out a1 * k1
endin

; Classic Computer S&H
instr 2
	idur = p3
	iamp = p4
	ifreq1 = p5
	ifreq2 = p6

	krand randh 0.5, 8
	krand = krand + 0.5

	a1 oscil iamp, ifreq1 + (ifreq2 - ifreq1) * krand, 1
	out a1
endin


; Modem
instr 3
    iamp = p4   ; Amplitude
    ibps = p5   ; Bits per second
    ifreq = p6  ; Frequency of carrier
    imod = p7   ; Modulation amount

    itable = 1
    amod randh 1.0, ibps
    amod limit ceil(amod), 0.0, 1.0
    amod = amod * imod
    a1 oscil iamp, ifreq + amod, itable
    out a1
endin

; Bit Shift Register Synth
instr 4
    idiv = int(p4)  ; Integer division of clock. Range 1 - 32.
    itab = p5       ; Selects the waveform

    ; Limit clock division to a range between 1 and 32
    idiv limit idiv, 1, 32

    ; Convert clock division to frequency
    ifreq = sr / 16 / idiv
    print ifreq

    ; Oscillator
    a1 oscil 0.1, ifreq, itab

    ; Output audio
    out a1
endin


; DTMF
instr 5
    ifreq1 = p4
    ifreq2 = p5

    a1 oscils 0.4, ifreq1, 0
    a2 oscils 0.4, ifreq2, 0

    out a1 + a2
endin

; Do nothing
instr 1000
endin