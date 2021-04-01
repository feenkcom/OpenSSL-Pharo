tests
testToRsaPulicKeyPemString
	| r |
	
	rsa fromPemString: LcRSATest rsaPemString1024.
	r := rsa asRsaPublicKeyPemString copyReplaceAll: String lf with: String cr.
	self assert: r trimBoth equals: LcRSATest rsaPemPubKeyString1024.