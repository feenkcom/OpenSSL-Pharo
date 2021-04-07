tests
testSerialization
	| encryptedContent serialized deserialized decryptedBuffer |

	encryptedContent := LcRSASealedEnvelope new.
	encryptedContent encrypt: plainText withKey: publicKey.

	serialized := encryptedContent asByteArray.
	deserialized := LcRSASealedEnvelope fromStream: serialized readStream.

	decryptedBuffer := deserialized decryptWith: privateKey.

	"Confirm that the decrypted content matches the original"
	self
		assert: decryptedBuffer
		equals: plainText.
