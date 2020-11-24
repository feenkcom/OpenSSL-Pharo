private - API - EVP
apiNewEvpCipherContext
	^ self ffiCall: #(EVP_CIPHER_CTX* EVP_CIPHER_CTX_new ())
		module: self library