private - API - EVP
apiEvpOpenInit: ctx type: type ek: ek eklen: ekl iv: iv priv: priv
	"int EVP_OpenInit(EVP_CIPHER_CTX *ctx, EVP_CIPHER *type, unsigned char *ek,
                  int ekl, unsigned char *iv, EVP_PKEY *priv);"

	^ self ffiCall: #(int EVP_OpenInit (EVP_CIPHER_CTX *ctx, EVP_CIPHER *type, char *ek,
                  int ekl, char *iv, EVP_PKEY *priv))
		module: self library
