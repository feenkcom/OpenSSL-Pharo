private - API - PEM
pemPSAPrint: anRSA
	| nullp bio out |
	
	nullp := FFIExternalObject new.
	bio := self bioNewMemBuf.
	[
		self apiPemWriteBioRSAPrivateKey: bio handle with: anRSA with: LcEvpCipherForeign null with: ByteArray new with: 0 with: nullp with: nullp.
		out := self bioRead: bio size: 10000
	] ensure: [ self apiBioFree: bio ].
	^ out asString