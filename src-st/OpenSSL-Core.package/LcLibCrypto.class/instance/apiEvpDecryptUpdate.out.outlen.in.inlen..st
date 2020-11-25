private - API - EVP
apiEvpDecryptUpdate: ctx out: out outlen: outl in: in inlen: inl

	^ self ffiCall: #(int EVP_DecryptUpdate (EVP_CIPHER_CTX *ctx, char *out, int *outl, char *in, int inl))
		module: self library