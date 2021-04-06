private - API - EVP
apiEvpPkeySize: anEvpPkey
	^ self ffiCall: #(int EVP_PKEY_size (EVP_PKEY *anEvpPkey))
		module: self library