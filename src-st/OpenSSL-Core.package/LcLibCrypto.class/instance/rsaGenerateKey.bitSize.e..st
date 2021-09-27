private - API - RSA
rsaGenerateKey: anRSA bitSize: bits e: e

	| anAddress |
	anAddress := ExternalAddress new.
	anAddress pinInMemory.

	^ [ 
	  self
		  apiRsaGenerateKey: anRSA
		  with: bits
		  with: e
		  with: anAddress ] ensure: [ anAddress unpinInMemory ]