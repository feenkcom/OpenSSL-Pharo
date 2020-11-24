private - API - Random
apiRandomBytes: aByteArray size: len
	"Populate the supplied byte array with random public bytes.
	For private bytes, use #apiRandPrivBytes:"

	^ self ffiCall: #(int RAND_bytes (void *aByteArray, int len))
		module: self library