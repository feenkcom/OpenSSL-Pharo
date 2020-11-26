tests
testAesCbc256RoundTrip
	| encryptedContent decryptedBuffer |

	encryptedContent := LcLibCrypto uniqueInstance
		aesCbc256Encrypt: plainText withKey: key.

	decryptedBuffer := encryptedContent decryptWith: key.

	"Confirm that the decrypted content matches the original"
	self
		assert: decryptedBuffer
		equals: plainText.
