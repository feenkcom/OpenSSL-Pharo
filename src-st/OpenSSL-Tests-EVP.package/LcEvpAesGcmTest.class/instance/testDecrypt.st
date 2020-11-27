tests
testDecrypt
	| content outbuf |

	content := LcAesGcm256EncryptedContent 
		initializationVector: initializationVector
		additionalAuthenticatedData: additionalAuthenticatedData
		tag: tag.
	content content: cipherText.
	outbuf := content decryptWith: key.

	"Confirm that the text is correctly encrypted"
	self
		assert: outbuf
		equals: plainText.
