private - API - EVP
apiEvpOpenFinal: ctx out: out outlen: outl
	"int EVP_OpenFinal(EVP_CIPHER_CTX *ctx, unsigned char *out, int *outl);"
	
	^ self ffiCall: #(int EVP_OpenFinal (EVP_CIPHER_CTX *ctx, char *out, int *outl))
		module: self library