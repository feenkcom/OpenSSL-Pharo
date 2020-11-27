tests
testDecrypt
	| content outbuf |

	content := LcAesCbc256EncryptedContent initializationVector: initializationVector.
	content content: cipherText.
	outbuf := content decryptWith: key.

	"Confirm that the text is correctly encrypted"
	self
		assert: outbuf
		equals: plainText.
