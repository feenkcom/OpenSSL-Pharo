private - API - EVP
apiEvpCipherCtxFree: ctx

	^ self ffiCall: #(void EVP_CIPHER_CTX_free(EVP_CIPHER_CTX *ctx))
		module: self library