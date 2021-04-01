private - API - PEM
apiPemWriteBioRSAPublicKey: bio with: rsa 
	^ self ffiCall: #(int PEM_write_bio_RSAPublicKey (BIO *bio, RSA *rsa))
		module: self library