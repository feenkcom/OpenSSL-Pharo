private - API - EVP
apiEvpEncryptUpdate: ctx out: out outlen: outl in: in inlen: inl

	^ self ffiCall: #(int EVP_EncryptUpdate (EVP_CIPHER_CTX *ctx, unsigned char *out,
         int *outl, const unsigned char *in, int inl))
		module: self library