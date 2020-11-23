private - API - error
apiRandomPrivateBytes: aByteArray size: len
	"Populate the supplied byte array with random public bytes.
	For private bytes, use #apiRandPrivBytes:"

	^ self ffiCall: #(int RAND_priv_bytes (void *aByteArray, int len))
		module: self library