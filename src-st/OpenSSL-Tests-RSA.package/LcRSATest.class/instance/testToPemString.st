tests
testToPemString
	| r |
	
	rsa fromPemString: LcRSATest rsaPemString1024.
	r := rsa asPemRSAString.
	self assert: r equals: LcRSATest rsaPemString1024.