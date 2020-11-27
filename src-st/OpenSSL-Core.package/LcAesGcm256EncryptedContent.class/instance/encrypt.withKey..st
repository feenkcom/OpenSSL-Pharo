encryption
encrypt: aByteArray withKey: aKey
	"Encrypt the supplied buffer and answer the encrypted content"
	| ctx outlenbuf outlen outbuf finalbuf finallenbuf finallen status null libCrypto |

	self assert: [ aKey size = 32 ].
	self assert: [ content isNil ].

	libCrypto := LcLibCrypto uniqueInstance.
	outbuf := ByteArray new: aByteArray size + 512.
	outlenbuf := ByteArray new: 8.
	finalbuf := ByteArray new: 1024.
	finallenbuf := ByteArray new: 8.
	null := ExternalAddress null.

	ctx := libCrypto newEvpCipherContext.
	self assert: ctx isNull not.
	"Set cipher type and mode"
	status := libCrypto apiEvpEncryptInit: ctx 
					type: libCrypto evpAes256Gcm 
					engine: LcEngineForeign null 
					key: null 
					iv: null.
	self assert: status equals: 1.
	status := libCrypto apiEvpCipherCtxCtrl: ctx 
					type: LcEvpConstants EVP_CTRL_AEAD_SET_IVLEN value
					len: initializationVector size 
					void: null.
	self assert: status equals: 1.
	"Initialise key and IV"
	status := libCrypto apiEvpEncryptInit: ctx 
					type: libCrypto evpAes256Gcm 
					engine: LcEngineForeign null 
					key: aKey 
					iv: initializationVector.
	self assert: status equals: 1.
	"Zero or more calls to specify any AAD"
	status := libCrypto apiEvpEncryptUpdate: ctx 
			out: null outlen: outlenbuf 
			in: additionalAuthenticatedData inlen: additionalAuthenticatedData size.
	self assert: status equals: 1.
	"Encrypt plaintext"
	status := libCrypto apiEvpEncryptUpdate: ctx 
			out: outbuf outlen: outlenbuf 
			in: aByteArray inlen: aByteArray size.
	self assert: status equals: 1.
	outlen := outlenbuf unsignedLongLongAt: 1.
	"Finalise: note get no output for GCM"
	status := libCrypto apiEvpEncryptFinal: ctx out: finalbuf outlen: finallenbuf.
	self assert: status equals: 1.
	finallen := finallenbuf unsignedLongLongAt: 1.
	self assert: finallen equals: 0.
	"Get the tag"
	status := libCrypto apiEvpCipherCtxCtrl: ctx 
					type: LcEvpConstants EVP_CTRL_AEAD_GET_TAG value
					len: tag size
					void: tag.
	self assert: status equals: 1.

	"Free the context"
	libCrypto apiEvpCipherCtxFree: ctx.

	content := outbuf copyFrom: 1 to: outlen.
	^ content