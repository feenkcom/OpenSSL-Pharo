private - API - EVP
apiEvpCipherCtxFree: ctx

	^ self ffiCall: #(int EVP_CIPHER_CTX_free(EVP_CIPHER_CTX *ctx))
		module: self library