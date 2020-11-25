tests
testEncrypt
	| ctx outlenbuf outbuf outlen finalbuf finallenbuf finallen libCrypto status null |

	libCrypto := LcLibCrypto uniqueInstance.
	outbuf := ByteArray new: 1024.
	outlenbuf := ByteArray new: 8.
	finalbuf := ByteArray new: 1024.
	finallenbuf := ByteArray new: 8.
	null := ExternalAddress null.

	ctx := libCrypto newEvpCipherContext.
	self deny: ctx isNull.
	"Set cipher type and mode"
	status := libCrypto apiEvpEncryptInit: ctx 
					type: libCrypto evpAes256Cbc 
					engine: LcEngineForeign null 
					key: key 
					iv: initializationVector.
	self assert: status equals: 1.
	"Encrypt plaintext"
	status := libCrypto apiEvpEncryptUpdate: ctx 
					out: outbuf outlen: outlenbuf 
					in: plainText inlen: plainText size.
	self assert: status equals: 1.
	outlen := outlenbuf unsignedLongLongAt: 1.
	"Finalise"
	status := libCrypto apiEvpEncryptFinal: ctx out: finalbuf outlen: finallenbuf.
	self assert: status equals: 1.
	finallen := finallenbuf unsignedLongLongAt: 1.

	"Free the context"
	libCrypto apiEvpCipherCtxFree: ctx.

	"Append the final buffer to the cipher text"
	"outbuf is much larger than the plain text, so there's room in outbuf"
	self assert: (outlen + finallen) <= outbuf size.
	outbuf
		replaceFrom: outlen + 1
		to: outlen + finallen + 1
		with: finalbuf
		startingAt: 1.

	"Confirm that the text is correctly encrypted"
	self
		assert: (outbuf copyFrom: 1 to: cipherText size)
		equals: cipherText.
