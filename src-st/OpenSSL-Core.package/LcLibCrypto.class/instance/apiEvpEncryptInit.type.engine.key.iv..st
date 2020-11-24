private - API - EVP
apiEvpEncryptInit: ctx type: type engine: impl key: key iv: iv
	"int EVP_EncryptInit_ex(EVP_CIPHER_CTX *ctx, const EVP_CIPHER *type,
         ENGINE *impl, const unsigned char *key, const unsigned char *iv)"

	^ self ffiCall: #(int EVP_EncryptInit_ex (EVP_CIPHER_CTX *ctx, const EVP_CIPHER *type,
         ENGINE *impl, char *key, char *iv)) 
		module: self library
