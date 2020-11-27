decryption
decryptWith: aKey
	"Decrypt the receiver's content with the supplied key"
	| ctx outlenbuf outbuf outlen finalbuf finallenbuf finallen status libCrypto result |

	libCrypto := LcLibCrypto uniqueInstance.
	outbuf := ByteArray new: content size + 512.
	outlenbuf := ByteArray new: 8.
	finalbuf := ByteArray new: 1024.
	finallenbuf := ByteArray new: 8.

	ctx := libCrypto newEvpCipherContext.
	self assert: ctx isNull not.
	"Set cipher type and mode"
	status := libCrypto apiEvpDecryptInit: ctx 
					type: libCrypto evpAes256Cbc 
					engine: LcEngineForeign null 
					key: aKey 
					iv: initializationVector.
	self assert: status equals: 1.
	"Decrypt cipher text"
	status := libCrypto apiEvpDecryptUpdate: ctx 
					out: outbuf outlen: outlenbuf
					in: content inlen: content size.
	self assert: status equals: 1.
	outlen := outlenbuf unsignedLongLongAt: 1.
	"Finalise"
	status := libCrypto apiEvpDecryptFinal: ctx out: finalbuf outlen: finallenbuf.
	self assert: status equals: 1.
	finallen := finallenbuf unsignedLongLongAt: 1.

	"Free the context"
	libCrypto apiEvpCipherCtxFree: ctx.

	result := ByteArray new: outlen + finallen.
	result
		replaceFrom: 1
		to: outlen
		with: outbuf
		startingAt: 1.
	result
		replaceFrom: outlen + 1
		to: outlen + finallen
		with: finalbuf
		startingAt: 1.

	^ result