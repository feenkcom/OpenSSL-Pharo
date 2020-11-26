initialization
initialize

	super initialize.
	initializationVector := ByteArray new: 12.
	LcLibCrypto uniqueInstance randomBytes: initializationVector.
