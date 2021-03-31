private - API - PEM
apiPemWriteBioRSAPrivateKey: bio with: rsa with: enc with: kstr with: klen with: cb with: uv
	^ self ffiCall: #(int PEM_write_bio_RSAPrivateKey 
									(BIO *bio, RSA *rsa, EVP_CIPHER *enc, char *kstr, int klen, FFIExternalObject cb, FFIExternalObject uv))
		module: self library