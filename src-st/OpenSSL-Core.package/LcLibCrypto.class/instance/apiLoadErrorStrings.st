private - API - error
apiLoadErrorStrings
	^ self ffiCall: #(void ERR_load_CRYPTO_strings (void))
		module: self library