encryption
decryptWith: anRsaPrivateKey
	| ctx evpPrivateKey 
	  outputBuffer outputBufferLength outputLength 
	  finalBuffer finalBufferLength finalLength
	  result libCrypto status |
	
	libCrypto := LcLibCrypto uniqueInstance.
	
	evpPrivateKey := LcEvpPublicKey setRSA: anRsaPrivateKey.
	
	ctx := libCrypto newEvpCipherContext.
	self assert: ctx isNull not.
	
	"Initialise the decryption operation. The asymmetric private key is
	 provided and priv_key, whilst the encrypted session key is held in
	 encrypted_key".
	status := libCrypto 
		apiEvpOpenInit: ctx 
		type: libCrypto evpAes256Cbc 
		ek: encryptedSecret 
		eklen: encryptedSecret size 
		iv: initializationVector 
		priv: evpPrivateKey handle.
	self assert: status equals: 1.
	
	outputBuffer := ByteArray new: content size + 1 + LcEvpConstants EVP_MAX_IV_LENGTH value.
	outputBufferLength := ByteArray new: 8.
	finalBuffer := ByteArray new: content size + 1 + LcEvpConstants EVP_MAX_IV_LENGTH value.
	finalBufferLength := ByteArray new: 8.
	
	"Provide the message to be decrypted, and obtain the plaintext output."
	status := libCrypto 
		apiEvpDecryptUpdate: ctx 
		out: outputBuffer outlen: outputBufferLength
		in: content inlen: content size.
	self assert: status equals: 1.
	outputLength := outputBufferLength unsignedLongLongAt: 1.
	self assert: outputLength < outputBuffer size.
	
	"Finalise the decryption. Further plaintext bytes may be written at this stage."
	status := libCrypto 
		apiEvpOpenFinal: ctx 
		out: finalBuffer 
		outlen: finalBufferLength.
	self assert: status equals: 1.
	finalLength := finalBufferLength unsignedLongLongAt: 1.
	
	"Free the context"
	libCrypto apiEvpCipherCtxFree: ctx.

	result := ByteArray new: outputLength + finalLength.
	result
		replaceFrom: 1
		to: outputLength
		with: outputBuffer
		startingAt: 1.
	result
		replaceFrom: outputLength + 1
		to: outputLength + finalLength
		with: finalBuffer
		startingAt: 1.

	^ result