private - API - EVP
apiEvpSealFinal: ctx with: out with: outl
	"int EVP_SealFinal(EVP_CIPHER_CTX *ctx, unsigned char *out,
         int *outl);"

	^ self ffiCall: #(int EVP_SealFinal(EVP_CIPHER_CTX *ctx, char *out,
         int *outl))
		module: self library