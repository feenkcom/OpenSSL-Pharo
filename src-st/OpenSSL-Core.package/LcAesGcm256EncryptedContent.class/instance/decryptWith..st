decryption
decryptWith: aKey
	"Decrypt the receiver's content with the supplied key"
	| ctx outlen outbuf outlenbuf libCrypto status null finalbuf finallenbuf finallen  |

	libCrypto := LcLibCrypto uniqueInstance.
	outbuf := ByteArray new: content size + 512.
	outlenbuf := ByteArray new: 8.
	finalbuf := ByteArray new: 1024.
	finallenbuf := ByteArray new: 8.
	null := ExternalAddress null.

	ctx := libCrypto newEvpCipherContext.
	self assert: ctx isNull not.
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
					key: aKey 
					iv: initializationVector.
	self assert: status equals: 1.
	"Set the AAD"
	status := libCrypto apiEvpDecryptUpdate: ctx 
					out: null outlen: outlenbuf 
					in: additionalAuthenticatedData inlen: additionalAuthenticatedData size.
	self assert: status equals: 1.
	"Decrypt the content"
	status := libCrypto apiEvpDecryptUpdate: ctx 
					out: outbuf outlen: outlenbuf
					in: content inlen: content size.
	self assert: status equals: 1.
	outlen := outlenbuf unsignedLongLongAt: 1.
	"Set the tag"
	status := libCrypto apiEvpCipherCtxCtrl: ctx 
					type: LcEvpConstants EVP_CTRL_AEAD_SET_TAG value
					len: tag size
					void: tag.
	self assert: status equals: 1.
	"Finalise: note get no output for GCM"
	status := libCrypto apiEvpDecryptFinal: ctx out: finalbuf outlen: finallenbuf.
	self assert: status equals: 1.
	finallen := finallenbuf unsignedLongLongAt: 1.
	self assert: finallen equals: 0.

	"Free the context"
	libCrypto apiEvpCipherCtxFree: ctx.

	^ outlen = outbuf size 
		ifTrue: [ outbuf ]
		ifFalse: [ outbuf copyFrom: 1 to: outlen ]