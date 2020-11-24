tests
aesGcmEncrypt
	| key iv pt aad ct tag ctx outlen outbuf libCrypto status null |

	key := ByteArray readHexFrom: 'eebc1f57487f51921c0465665f8ae6d1658bb26de6f8a069a3520293a572078f'.
	iv := ByteArray readHexFrom: '99aa3e68ed8173a0eed06684'.
	pt := ByteArray readHexFrom: 'f56e87055bc32d0eeb31b2eacc2bf2a5'.
	aad := ByteArray readHexFrom: '4d23c3cec334b49bdb370c437fec78de'.
	ct := ByteArray readHexFrom: 'f7264413a84c0e7cd536867eb9f21736'.
	tag := ByteArray new: 16.
	libCrypto := LcLibCrypto uniqueInstance.
	outbuf := ByteArray new: 1024.
	outlen := ByteArray new: 8.
	null := ExternalAddress null.

	ctx := libCrypto newEvpCipherContext.
	self deny: ctx isNull.
self halt.
	"Set cipher type and mode"
	status := libCrypto apiEvpEncryptInit: ctx type: libCrypto evpAes256Gcm engine: LcEngineForeign null key: null iv: null.
	self assert: status equals: 1.
	"Set IV length if default 96 bits is not appropriate"
	"This has an int return type, but no return value documented"
	status := libCrypto apiEvpCipherCtxCtrl: ctx 
					type: LcEvpConstants EVP_CTRL_AEAD_SET_IVLEN 
					len: iv size 
					void: null.
	self assert: status equals: 1.
	"Initialise key and IV"
	status := libCrypto apiEvpEncryptInit: ctx 
					type: libCrypto evpAes256Gcm 
					engine: LcEngineForeign null 
					key: key 
					iv: iv.
	self assert: status equals: 1.
	"Zero or more calls to specify any AAD"
	status := libCrypto apiEvpEncryptUpdate: ctx out: null outlen: outlen in: aad inlen: aad size.
	self assert: status equals: 1.
	"Encrypt plaintext"
	status := libCrypto apiEvpEncryptUpdate: ctx out: outbuf outlen: outlen in: pt inlen: pt size.
	self assert: status equals: 1.
	"Finalise: note get no output for GCM"
	status := libCrypto apiEvpEncryptFinal: ctx out: outbuf outlen: outlen.
	self assert: status equals: 1.
	"Get tag"
	status := libCrypto apiEvpCipherCtxCtrl: ctx 
					type: LcEvpConstants EVP_CTRL_AEAD_GET_TAG 
					len: tag size
					void: tag.
	self assert: status equals: 1.
	"Free the context"
	status := libCrypto apiEvpCipherCtxFree: ctx.
	self assert: status equals: 1.
