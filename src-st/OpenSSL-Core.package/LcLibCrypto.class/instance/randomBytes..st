API - Random
randomBytes: aByteArray
	"Fill the supplied ByteArray with random public bytes.
	If private bytes are requried, use randPrivateBytes:"

	^ self apiRandBytes: aByteArray size: aByteArray size