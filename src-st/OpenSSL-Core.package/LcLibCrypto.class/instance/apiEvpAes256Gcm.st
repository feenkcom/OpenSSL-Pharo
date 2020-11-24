private - API - EVP
apiEvpAes256Gcm

	^ self ffiCall: #(EVP_CIPHER* EVP_aes_256_gcm ())
		module: self library

