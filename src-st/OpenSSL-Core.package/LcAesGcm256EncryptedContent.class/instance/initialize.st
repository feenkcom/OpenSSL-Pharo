initialization
initialize

	super initialize.
	initializationVector := ByteArray new: 12.
	LcLibCrypto uniqueInstance randomBytes: initializationVector.
	additionalAuthenticatedData := ByteArray new: 16.
	LcLibCrypto uniqueInstance randomBytes: additionalAuthenticatedData.
	tag := ByteArray new: 16.