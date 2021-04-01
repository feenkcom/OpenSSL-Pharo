private - API - PEM
pemPsaPublicKeyPrint: anRSA
	| bio out |
	
	bio := self bioNewMemBuf.
	[
		self apiPemWriteBioRSAPublicKey: bio handle with: anRSA.
		out := self bioRead: bio size: 10000
	] ensure: [ self apiBioFree: bio ].
	^ out asString