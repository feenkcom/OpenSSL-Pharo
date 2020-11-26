API - Encryption
aesGcm256Encrypt: aByteArray withKey: aKey
	"Encrypt the supplied buffer and answer the encrypted content"
	| ctx outlenbuf outlen outbuf finalbuf finallenbuf finallen status null result |

	outbuf := ByteArray new: aByteArray size + 512.
	outlenbuf := ByteArray new: 8.
	finalbuf := ByteArray new: 1024.
	finallenbuf := ByteArray new: 8.
	null := ExternalAddress null.
	result := LcAesGcm256EncryptedContent new.

	ctx := self newEvpCipherContext.
	self assert: ctx isNull not.
	"Set cipher type and mode"
	status := self apiEvpEncryptInit: ctx type: self evpAes256Gcm engine: LcEngineForeign null key: null iv: null.
	self assert: status equals: 1.
	status := self apiEvpCipherCtxCtrl: ctx 
					type: LcEvpConstants EVP_CTRL_AEAD_SET_IVLEN value
					len: result initializationVector size 
					void: null.
	self assert: status equals: 1.
	"Initialise key and IV"
	status := self apiEvpEncryptInit: ctx 
					type: self evpAes256Gcm 
					engine: LcEngineForeign null 
					key: aKey 
					iv: result initializationVector.
	self assert: status equals: 1.
	"Zero or more calls to specify any AAD"
	status := self apiEvpEncryptUpdate: ctx 
			out: null outlen: outlenbuf 
			in: result additionalAuthenticatedData inlen: result additionalAuthenticatedData size.
	self assert: status equals: 1.
	"Encrypt plaintext"
	status := self apiEvpEncryptUpdate: ctx 
			out: outbuf outlen: outlenbuf 
			in: aByteArray inlen: aByteArray size.
	self assert: status equals: 1.
	outlen := outlenbuf unsignedLongLongAt: 1.
	"Finalise: note get no output for GCM"
	status := self apiEvpEncryptFinal: ctx out: finalbuf outlen: finallenbuf.
	self assert: status equals: 1.
	finallen := finallenbuf unsignedLongLongAt: 1.
	self assert: finallen equals: 0.
	"Get the tag"
	status := self apiEvpCipherCtxCtrl: ctx 
					type: LcEvpConstants EVP_CTRL_AEAD_GET_TAG value
					len: result tag size
					void: result tag.
	self assert: status equals: 1.

	"Free the context"
	self apiEvpCipherCtxFree: ctx.

	result content: (outbuf copyFrom: 1 to: outlen).
	^ result