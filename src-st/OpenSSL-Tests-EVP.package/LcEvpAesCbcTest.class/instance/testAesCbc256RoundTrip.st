tests
testAesCbc256RoundTrip
	| encryptedContent decryptedBuffer |

	encryptedContent := (LcAesCbc256EncryptedContent initializationVector: initializationVector)
								encrypt: plainText withKey: key;
								yourself.

	decryptedBuffer := encryptedContent decryptWith: key.

	"Confirm that the decrypted content matches the original"
	self
		assert: decryptedBuffer
		equals: plainText.
