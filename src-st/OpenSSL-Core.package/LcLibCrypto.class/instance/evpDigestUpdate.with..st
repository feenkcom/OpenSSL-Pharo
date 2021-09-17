private - API - EVP
evpDigestUpdate: aByteArray with: mdCtx
	aByteArray pinInMemory.
	[ self errorIfZero: 
		(LcLibCrypto current 
			apiEvpDigestUpdate: mdCtx 
			with: aByteArray
			with: aByteArray size) ] ensure: [
		aByteArray unpinInMemory ]