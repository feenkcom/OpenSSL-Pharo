tests
testDecrypt
	| ctx outlen outbuf libCrypto status null |

	libCrypto := LcLibCrypto uniqueInstance.
	outbuf := ByteArray new: 1024.
	outlen := ByteArray new: 8.
	null := ExternalAddress null.

	ctx := libCrypto newEvpCipherContext.
	self deny: ctx isNull.
	"Set cipher type and mode"
	status := libCrypto apiEvpDecryptInit: ctx 
					type: libCrypto evpAes256Gcm 
					engine: LcEngineForeign null 
					key: null 
					iv: null.
	self assert: status equals: 1.
	"Set IV length if default 96 bits is not appropriate"
	"This has an int return type, but no return value documented"
	status := libCrypto apiEvpCipherCtxCtrl: ctx 
					type: LcEvpConstants EVP_CTRL_AEAD_SET_IVLEN value
					len: initializationVector size 
					void: null.
	self assert: status equals: 1.
	"Initialise key and IV"
	status := libCrypto apiEvpDecryptInit: ctx 
					type: LcEvpCipherForeign null
					engine: LcEngineForeign null 
					key: key 
					iv: initializationVector.
	self assert: status equals: 1.
	"Zero or more calls to specify any AAD"
	status := libCrypto apiEvpDecryptUpdate: ctx 
					out: null outlen: outlen 
					in: additionalAuthenticatedData inlen: additionalAuthenticatedData size.
	self assert: status equals: 1.
	"Decrypt to plain text"
	status := libCrypto apiEvpDecryptUpdate: ctx 
					out: outbuf outlen: outlen 
					in: cipherText inlen: cipherText size.
	self assert: status equals: 1.
	"Set the tag"
	status := libCrypto apiEvpCipherCtxCtrl: ctx 
					type: LcEvpConstants EVP_CTRL_AEAD_SET_TAG value
					len: tag size
					void: tag.
	self assert: status equals: 1.
	"Finalise: note get no output for GCM"
	status := libCrypto apiEvpDecryptFinal: ctx out: outbuf outlen: outlen.
	self assert: status equals: 1.

	"Free the context"
	libCrypto apiEvpCipherCtxFree: ctx.

	"Confirm that the text is correctly encrypted"
	self
		assert: (outbuf copyFrom: 1 to: plainText size)
		equals: plainText.
