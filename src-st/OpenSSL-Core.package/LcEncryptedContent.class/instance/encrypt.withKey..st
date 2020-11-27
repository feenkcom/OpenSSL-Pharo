encryption
encrypt: aByteArray withKey: aKey
	"Encrypt the supplied buffer with aKey"

	^ self subclassResponsibility 