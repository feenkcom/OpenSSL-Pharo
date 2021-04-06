initialization
initialize

	super initialize.
	initializationVector := ByteArray new: LcEvpConstants EVP_MAX_IV_LENGTH value.