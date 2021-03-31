private - API - PEM
apiPemWriteBioPKCS8PrivateKey: bio with: rsa with: enc with: kstr with: klen with: cb with: uv
	^ self ffiCall: #(int PEM_write_bio_PKCS8PrivateKey 
									(BIO *bio, EVP_PKEY *rsa, EVP_CIPHER *enc, char *kstr, int klen, FFIExternalObject cb, FFIExternalObject uv))
		module: self library