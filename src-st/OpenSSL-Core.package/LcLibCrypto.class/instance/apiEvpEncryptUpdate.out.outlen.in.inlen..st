private - API - EVP
apiEvpEncryptUpdate: ctx out: out outlen: outl in: in inlen: inl

	^ self ffiCall: #(int EVP_EncryptUpdate (EVP_CIPHER_CTX *ctx, char *out,
         int *outl, char *in, int inl))
		module: self library