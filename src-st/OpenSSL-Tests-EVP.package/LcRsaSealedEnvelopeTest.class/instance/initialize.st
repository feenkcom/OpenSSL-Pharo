initialization
initialize 

	super initialize.
	publicKey := LcRSA new fromRsaPublicKeyPemString: LcRSATest rsaPemPubKeyString1024.
	privateKey := LcRSA new fromPemString: LcRSATest rsaPemString1024.
	plainText := ByteArray readHexFrom: 'f56e87055bc32d0eeb31b2eacc2bf2a5'.
