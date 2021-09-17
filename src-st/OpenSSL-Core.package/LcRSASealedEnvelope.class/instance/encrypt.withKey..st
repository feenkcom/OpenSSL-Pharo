encryption
encrypt: aByteArray withKey: anRsaPublicKey
	| ctx evpPublicKey maxEncryptedKeySize 
	  encryptedKeyBuffer encryptedKeyBufferLength encryptedKeyLength
	  outputBuffer outputBufferLength outputLength
	  finalBuffer finalBufferLength finalLength
	  status libCrypto |
	
	self assert: [ aByteArray notNil ].
	self assert: [ anRsaPublicKey  notNil ].
	self assert: [ content isNil ].
	
	libCrypto := LcLibCrypto uniqueInstance.
	
	evpPublicKey := LcEvpPublicKey setRSA: anRsaPublicKey.
	
	ctx := libCrypto newEvpCipherContext.
	self assert: ctx isNull not.
	
	maxEncryptedKeySize := libCrypto apiEvpPkeySize: evpPublicKey handle.
	encryptedKeyBuffer := ExternalAddress allocate: maxEncryptedKeySize.
	encryptedKeyBufferLength := ByteArray new: 8.
	
	"Initialise the envelope seal operation. This operation generates
	 a key for the provided cipher, and then encrypts that key a number
	 of times (one for each public key provided in the pub_key array). In
	 this example the array size is just one. This operation also
	 generates an IV and places it in iv. "
	status := libCrypto 
		apiEvpSealInit: ctx 
		with: libCrypto evpAes256Cbc 
		with: encryptedKeyBuffer 
		with: encryptedKeyBufferLength 
		with: initializationVector 
		with: evpPublicKey handle
		with: 1.
	self assert: status equals: 1.
	
	encryptedKeyLength := encryptedKeyBufferLength unsignedLongLongAt: 1.
	encryptedSecret := (FFIExternalArray fromHandle: encryptedKeyBuffer type: 'uchar' size: encryptedKeyLength) asByteArray.
	encryptedKeyBuffer free.
	
	outputBuffer := ByteArray new: aByteArray size + 1 + LcEvpConstants EVP_MAX_IV_LENGTH value.
	outputBufferLength := ByteArray new: 8.
	finalBuffer := ByteArray new: aByteArray size + 1 + LcEvpConstants EVP_MAX_IV_LENGTH value.
	finalBufferLength := ByteArray new: 8.
	
	"Provide the message to be encrypted, and obtain the encrypted output."
	status := libCrypto 
		apiEvpEncryptUpdate: ctx 
		out: outputBuffer 
		outlen: outputBufferLength 
		in: aByteArray 
		inlen: aByteArray size.
	self assert: status equals: 1.
	outputLength := outputBufferLength unsignedLongLongAt: 1.
	self assert: outputLength < outputBuffer size.
	
	"Finalise the encryption. Further ciphertext bytes may be written at this stage."
	status := libCrypto 
		apiEvpSealFinal: ctx 
		with: finalBuffer 
		with: finalBufferLength.
	self assert: status equals: 1.
	finalLength := finalBufferLength unsignedLongLongAt: 1.
	
	"Free the context"
	libCrypto apiEvpCipherCtxFree: ctx.
	
	content := ByteArray new: outputLength + finalLength.
	content
		replaceFrom: 1
		to: outputLength
		with: outputBuffer
		startingAt: 1.
	content
		replaceFrom: outputLength + 1
		to: outputLength + finalLength
		with: finalBuffer
		startingAt: 1.
	
	^ content