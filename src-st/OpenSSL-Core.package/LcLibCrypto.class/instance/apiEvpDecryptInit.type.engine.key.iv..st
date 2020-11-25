private - API - EVP
apiEvpDecryptInit: ctx type: type engine: impl key: key iv: iv

	^ self ffiCall: #(int EVP_DecryptInit_ex (EVP_CIPHER_CTX *ctx, const EVP_CIPHER *type, ENGINE *impl, char *key, char *iv))
		module: self library
