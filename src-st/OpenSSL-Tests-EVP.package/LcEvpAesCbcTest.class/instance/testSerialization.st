tests
testSerialization
	| encryptedContent serialized deserialized decryptedBuffer |

	encryptedContent := LcAesCbc256EncryptedContent initializationVector: initializationVector.
	encryptedContent encrypt: plainText withKey: key.

	serialized := encryptedContent asByteArray.
	deserialized := LcAesCbc256EncryptedContent fromStream: serialized readStream.

	decryptedBuffer := deserialized decryptWith: key.

	"Confirm that the decrypted content matches the original"
	self
		assert: decryptedBuffer
		equals: plainText.
