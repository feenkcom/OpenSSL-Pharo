tests
testRsaSealedEnvelopeRoundTrip
	| encryptedContent decryptedBuffer |

	encryptedContent := (LcRSASealedEnvelope new)
								encrypt: plainText withKey: publicKey;
								yourself.

	decryptedBuffer := encryptedContent decryptWith: privateKey.

	"Confirm that the decrypted content matches the original"
	self
		assert: decryptedBuffer
		equals: plainText.
