tests
testEncrypt
	| tag1 ctx outlen outbuf libCrypto status null |

	libCrypto := LcLibCrypto uniqueInstance.
	outbuf := ByteArray new: 1024.
	outlen := ByteArray new: 8.
	tag1 := ByteArray new: 16.
	null := ExternalAddress null.

	ctx := libCrypto newEvpCipherContext.
	self deny: ctx isNull.
	"Set cipher type and mode"
	status := libCrypto apiEvpEncryptInit: ctx type: libCrypto evpAes256Gcm engine: LcEngineForeign null key: null iv: null.
	self assert: status equals: 1.
	"Set IV length if default 96 bits is not appropriate"
	"This has an int return type, but no return value documented"
	status := libCrypto apiEvpCipherCtxCtrl: ctx 
					type: LcEvpConstants EVP_CTRL_AEAD_SET_IVLEN value
					len: initializationVector size 
					void: null.
	self assert: status equals: 1.
	"Initialise key and IV"
	status := libCrypto apiEvpEncryptInit: ctx 
					type: libCrypto evpAes256Gcm 
					engine: LcEngineForeign null 
					key: key 
					iv: initializationVector.
	self assert: status equals: 1.
	"Zero or more calls to specify any AAD"
	status := libCrypto apiEvpEncryptUpdate: ctx out: null outlen: outlen in: aditionalAutneticatedData inlen: aditionalAutneticatedData size.
	self assert: status equals: 1.
	"Encrypt plaintext"
	status := libCrypto apiEvpEncryptUpdate: ctx out: outbuf outlen: outlen in: plainText inlen: plainText size.
	self assert: status equals: 1.
	"Finalise: note get no output for GCM"
	status := libCrypto apiEvpEncryptFinal: ctx out: outbuf outlen: outlen.
	self assert: status equals: 1.
	"Get the tag"
	status := libCrypto apiEvpCipherCtxCtrl: ctx 
					type: LcEvpConstants EVP_CTRL_AEAD_GET_TAG value
					len: tag1 size
					void: tag1.
	self assert: status equals: 1.

	"Free the context"
	libCrypto apiEvpCipherCtxFree: ctx.

	"Confirm that the text is correctly encrypted"
	self
		assert: (outbuf copyFrom: 1 to: cipherText size)
		equals: cipherText.

	"Confirm that the tag matches"
	self assert: tag equals: tag1.
