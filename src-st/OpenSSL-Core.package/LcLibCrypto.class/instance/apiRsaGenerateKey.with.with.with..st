private - API - RSA
apiRsaGenerateKey: anRSA with: bits with: e with: callback
	^ self ffiCall: #(int RSA_generate_key_ex (RSA *anRSA, int bits, BIGNUM *e, void *callback))
		module: self library