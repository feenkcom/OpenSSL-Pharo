private - API - error
apiRandomBytes: aByteArray
	"Populate the supplied byte array with random public bytes.
	For private bytes, use #apiRandPrivBytes:"
	| len |

	len := aByteArray size.
	^ self ffiCall: #(int RAND_bytes (void *aByteArray, int len))
		module: self library