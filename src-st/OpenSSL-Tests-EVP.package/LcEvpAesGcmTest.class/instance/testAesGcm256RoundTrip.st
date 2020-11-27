tests
testAesGcm256RoundTrip
	| encryptedContent decryptedBuffer |

	encryptedContent := LcAesGcm256EncryptedContent new
								encrypt: plainText withKey: key;
								yourself.

	decryptedBuffer := encryptedContent decryptWith: key.

	"Confirm that the decrypted content matches the original"
	self
		assert: decryptedBuffer
		equals: plainText.
