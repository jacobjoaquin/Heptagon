sr = 44100
kr = 441
ksmps = 100
nchnls = 2
0dbfs = 1.0

giMasterVolume = 0.25
gaFeedBackLeft = 0
gaFeedBackRight = 0

; Tables
gitemp ftgen 1, 0, 8192, 10, 1

; Setup
instr 1
	; Master
	chn_k "masterTune", 1
	chnset 1, "masterTune"
	chn_a "masterLeft", 1
	chn_a "masterRight", 1

	; Sampler
	chn_k "samplerRingModFreq", 1
	chnset 4, "samplerRingModFreq"

	; Delay
	chn_k "delayLeftAmount", 1
	chn_k "delayRightAmount", 1
	chn_k "delayFeedBack", 1
	chnset 0, "delayLeftAmount"
	chnset 0, "delayRightAmount"
	chnset 0, "delayFeedBack"

	; Reverb
	chn_k "reverbSize", 1
	chn_a "reverbLeft", 1
	chn_a "reverbRight", 1

	turnoff
endin

; Clean Chn
instr 2
	azero = 0

	chnset azero, "reverbLeft"
	chnset azero, "reverbRight"
	chnset azero, "masterLeft"
	chnset azero, "masterRight"
endin

; Turn off an instrument
instr 10
	turnoff2 p4, 0, 0
	turnoff
endin

; Test
instr 101
	idur = p3
	iamp = p4
	ifreq = p5
	k1 line 1, idur, 0
	a1 oscils iamp, ifreq, 1
	out a1 * k1
endin

; Classic Computer S&H
instr 102
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
instr 103
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
instr 104
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
instr 105
	ktune chnget "masterTune"
	idur = p3
    ifreq1 = p4
    ifreq2 = p5

    a1 oscil 0.4, ifreq1 * ktune, 1, -1
    a2 oscil 0.4, ifreq2 * ktune, 1, -1
    ae linseg 0, 0.01, 1, idur - 0.02, 1, 0.01, 0
    amix = (a1 + a2) * ae
    chnmix amix, "reverbLeft"
    chnmix amix, "reverbRight"
    chnmix amix, "masterLeft"
    chnmix amix, "masterRight"
endin

; Sampler
instr 106
;	ktune chnget "masterTune"
;	ktune port ktune, 0.025
	kring chnget "samplerRingModFreq"
	kring port kring, 0.025
	idur = p3
	iamp = p4 * 8
	SFile = p5
	ipch = p6

	a1, a2 diskin2 SFile, ipch

	a3 oscil 1, kring, 1
	a1 = a1 * a3
	a2 = a2 * a3
    chnmix a1 * iamp, "reverbLeft"
    chnmix a2 * iamp, "reverbRight"
    chnmix a1 * iamp, "masterLeft"
    chnmix a2 * iamp, "masterRight"
endin

; Reverb
instr 500
	; Input
	aleft chnget "reverbLeft"
	aright chnget "reverbRight"

	; Pre-delay
	kdlamt chnget "delayLeftAmount"
	kdramt chnget "delayRightAmount"
	kdfb chnget "delayFeedBack"
	kdlamt port kdlamt, 1
	kdramt port kdramt, 1
	kdfb port kdfb, 1
	ad1 vdelay aleft + gaFeedBackLeft, kdlamt, 2000
	ad2 vdelay aright + gaFeedBackRight, kdramt, 2000

	; Feedback
	gaFeedBackLeft vdelay (ad1 + gaFeedBackLeft) * kdfb, kdlamt, 2000
	gaFeedBackRight vdelay (ad2 + gaFeedBackRight) * kdfb, kdlamt, 2000

	; Reverb
	ksize chnget "reverbSize"
	ksize port ksize, 0.01

	a1, a2 freeverb ad1, ad2, ksize, ksize

    chnmix a1, "masterLeft"
    chnmix a2, "masterRight"
endin


; Master out
instr 600
	; Wet / Dry

	a1 chnget "masterLeft"
	a2 chnget "masterRight"

	a1 = a1 * giMasterVolume
	a2 = a2 * giMasterVolume
	a1 limit a1, -1, 1
	a2 limit a2, -1, 1
	outs a1, a2
endin