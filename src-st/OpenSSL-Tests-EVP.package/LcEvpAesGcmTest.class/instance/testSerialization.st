tests
testSerialization
	| encryptedContent serialized deserialized decryptedBuffer |

	encryptedContent := LcLibCrypto uniqueInstance
		aesGcm256Encrypt: plainText withKey: key.

	serialized := encryptedContent asByteArray.
	deserialized := LcAesGcm256EncryptedContent fromStream: serialized readStream.

	decryptedBuffer := deserialized decryptWith: key.

	"Confirm that the decrypted content matches the original"
	self
		assert: decryptedBuffer
		equals: plainText.
