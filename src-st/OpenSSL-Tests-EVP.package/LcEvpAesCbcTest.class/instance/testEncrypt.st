tests
testEncrypt
	| content outbuf |

	content := LcAesCbc256EncryptedContent initializationVector: initializationVector.
	outbuf := content encrypt: plainText withKey: key.

	"Confirm that the text is correctly encrypted"
	self
		assert: outbuf
		equals: cipherText.
