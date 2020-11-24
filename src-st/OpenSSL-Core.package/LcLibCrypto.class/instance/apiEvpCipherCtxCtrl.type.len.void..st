private - API - EVP
apiEvpCipherCtxCtrl: ctx type: type len: arg void: ptr

	^ self ffiCall: #(int EVP_CIPHER_CTX_ctrl(EVP_CIPHER_CTX *ctx, int type, int arg, void *ptr))
		module: self library