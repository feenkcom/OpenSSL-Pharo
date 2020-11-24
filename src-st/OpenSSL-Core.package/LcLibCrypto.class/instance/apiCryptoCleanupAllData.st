private - API - library
apiCryptoCleanupAllData
	"This is deprecated and defined as a null macro in openssl 1.1.1."
	"^ self ffiCall: #(void CRYPTO_cleanup_all_ex_data (void))
		module: self library"
	self flag: 'TODO: clealy shutdown openssl'.
