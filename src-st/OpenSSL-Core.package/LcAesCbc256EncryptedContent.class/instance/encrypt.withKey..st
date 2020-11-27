encryption
encrypt: aByteArray withKey: aKey
	"Encrypt the supplied buffer and answer the encrypted content"
	| ctx status outbuf outlenbuf outlen finalbuf finallenbuf finallen libCrypto |

	self assert: [ aKey size = 32 ].
	self assert: [ content isNil ].
	"The output buffer has to be >= input buffer + block size.  512 is conservative."
	libCrypto := LcLibCrypto uniqueInstance.
	outbuf := ByteArray new: aByteArray size + 512.
	outlenbuf := ByteArray new: 8.
	finalbuf := ByteArray new: 1024.
	finallenbuf := ByteArray new: 8.

	ctx := libCrypto newEvpCipherContext.
	self assert: ctx isNull not.
	"Set cipher type and mode"
	status := libCrypto apiEvpEncryptInit: ctx 
					type: libCrypto evpAes256Cbc 
					engine: LcEngineForeign null 
					key: aKey 
					iv: initializationVector.
	self assert: status equals: 1.
	"Encrypt plaintext"
	status := libCrypto apiEvpEncryptUpdate: ctx 
					out: outbuf outlen: outlenbuf 
					in: aByteArray inlen: aByteArray size.
	self assert: status equals: 1.
	outlen := outlenbuf unsignedLongLongAt: 1.
	self assert: outlen < outbuf size.
	"Finalise"
	status := libCrypto apiEvpEncryptFinal: ctx out: finalbuf outlen: finallenbuf.
	self assert: status equals: 1.
	finallen := finallenbuf unsignedLongLongAt: 1.

	"Free the context"
	libCrypto apiEvpCipherCtxFree: ctx.

	content := ByteArray new: outlen + finallen.
	content
		replaceFrom: 1
		to: outlen
		with: outbuf
		startingAt: 1.
	content
		replaceFrom: outlen + 1
		to: outlen + finallen
		with: finalbuf
		startingAt: 1.
	^ content