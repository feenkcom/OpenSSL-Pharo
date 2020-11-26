API - Encryption
aesCbc256Encrypt: aByteArray withKey: aKey initializationVector: anIv
	"Encrypt the supplied buffer and answer the encrypted content"
	| ctx status outbuf outlenbuf outlen finalbuf finallenbuf finallen result |

	"The output buffer has to be >= input buffer + block size.  512 is conservative."
	outbuf := ByteArray new: aByteArray size + 512.
	outlenbuf := ByteArray new: 8.
	finalbuf := ByteArray new: 1024.
	finallenbuf := ByteArray new: 8.
	result := LcAesCbc256EncryptedContent new.
	result initializationVector: anIv.

	ctx := self newEvpCipherContext.
	self assert: ctx isNull not.
	"Set cipher type and mode"
	status := self apiEvpEncryptInit: ctx 
					type: self evpAes256Cbc 
					engine: LcEngineForeign null 
					key: aKey 
					iv: result initializationVector.
	self assert: status equals: 1.
	"Encrypt plaintext"
	status := self apiEvpEncryptUpdate: ctx 
					out: outbuf outlen: outlenbuf 
					in: aByteArray inlen: aByteArray size.
	self assert: status equals: 1.
	outlen := outlenbuf unsignedLongLongAt: 1.
	self assert: outlen < outbuf size.
	"Finalise"
	status := self apiEvpEncryptFinal: ctx out: finalbuf outlen: finallenbuf.
	self assert: status equals: 1.
	finallen := finallenbuf unsignedLongLongAt: 1.

	"Free the context"
	self apiEvpCipherCtxFree: ctx.

	result content: (ByteArray new: outlen + finallen).
	result content
		replaceFrom: 1
		to: outlen
		with: outbuf
		startingAt: 1.
	result content
		replaceFrom: outlen + 1
		to: outlen + finallen
		with: finalbuf
		startingAt: 1.
	^ result