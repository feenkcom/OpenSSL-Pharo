private - API - EVP
apiEvpAes256Cbc

	^ self ffiCall: #(EVP_CIPHER* EVP_aes_256_cbc ())
		module: self library

