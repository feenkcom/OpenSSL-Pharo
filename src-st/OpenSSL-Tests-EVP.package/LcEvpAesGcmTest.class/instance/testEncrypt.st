tests
testEncrypt
	| content outbuf |

	content := LcAesGcm256EncryptedContent 
					initializationVector: initializationVector
					additionalAuthenticatedData: additionalAuthenticatedData
					tag: tag.
	outbuf := content encrypt: plainText withKey: key.

	"Confirm that the text is correctly encrypted"
	self
		assert: outbuf
		equals: cipherText.
