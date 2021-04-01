tests
testToPemString
	| r |
	
	rsa fromPemString: LcRSATest rsaPemString1024.
	r := rsa asRsaPemString copyReplaceAll: String lf with: String cr.
	self assert: r trimBoth equals: LcRSATest rsaPemString1024.