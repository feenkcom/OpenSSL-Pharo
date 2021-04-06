private - API - EVP
apiEvpSealUpdate: ctx with: out with: outl with: in with: inl
	"int EVP_SealUpdate(EVP_CIPHER_CTX *ctx, unsigned char *out,
         int *outl, unsigned char *in, int inl);"

	^ self ffiCall: #(int EVP_SealUpdate(EVP_CIPHER_CTX *ctx, char *out,
         int *outl, char *in, int inl))
		module: self library