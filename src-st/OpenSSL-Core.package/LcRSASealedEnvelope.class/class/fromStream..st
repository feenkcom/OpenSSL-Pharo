instance creation
fromStream: aReadStream
	"Answer an instance of the receiver read from the supplied stream"
	| ivLength iv encryptedSecretLength encryptedSecret contentSize |

	ivLength := (aReadStream next: 8) unsignedLongLongAt: 1.
	iv := aReadStream next: ivLength.
	
	encryptedSecretLength := (aReadStream next: 8) unsignedLongLongAt: 1.
	encryptedSecret := aReadStream next: encryptedSecretLength.
	
	contentSize := (aReadStream next: 8) unsignedLongLongAt: 1.
	^ self new 
		initializationVector: iv;
		encryptedSecret: encryptedSecret;
		content: (aReadStream next: contentSize).
	