tests
aesGcmEncrypt
	| key iv pt aad ct tag ctx outlen tmplen outbuf libCrypto |

	key := ByteArray readHexFrom: 'eebc1f57487f51921c0465665f8ae6d1658bb26de6f8a069a3520293a572078f'.
	iv := ByteArray readHexFrom: '99aa3e68ed8173a0eed06684'.
	pt := ByteArray readHexFrom: 'f56e87055bc32d0eeb31b2eacc2bf2a5'.
	aad := ByteArray readHexFrom: '4d23c3cec334b49bdb370c437fec78de'.
	ct := ByteArray readHexFrom: 'f7264413a84c0e7cd536867eb9f21736'.
	tag := ByteArray readHexFrom: '67ba0510262ae487d737ee6298f77e0c'.
	libCrypto := LcLibCrypto uniqueInstance.
	outbuf := ByteArray new: 1024.

	ctx := libCrypto newEvpCipherContext.
	self deny: ctx isNull.
	"Set cipher type and mode"
	libCrypto apiEvpEncryptInit: ctx type: libCrypto evpAes256Gcm engine: nil key: nil iv: nil.
	"Set IV length if default 96 bits is not appropriate"
	