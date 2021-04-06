private - API - EVP
apiEvpSealInit: ctx with: type with: ek with: ekl with: iv with: pubk with: npubk
	"int EVP_SealInit(EVP_CIPHER_CTX *ctx, const EVP_CIPHER *type,
                  unsigned char **ek, int *ekl, unsigned char *iv,
                  EVP_PKEY **pubk, int npubk);"

	^ self ffiCall: #(int EVP_SealInit(EVP_CIPHER_CTX *ctx, EVP_CIPHER *type,
                  char **ek, int *ekl, char *iv,
                  EVP_PKEY **pubk, int npubk))
		module: self library