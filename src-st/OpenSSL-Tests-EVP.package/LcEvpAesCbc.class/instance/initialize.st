initialization
initialize 

	super initialize.
	key := ByteArray readHexFrom: 'eebc1f57487f51921c0465665f8ae6d1658bb26de6f8a069a3520293a572078f'.
	initializationVector := ByteArray readHexFrom: '99aa3e68ed8173a0eed06684'.
	plainText := ByteArray readHexFrom: 'f56e87055bc32d0eeb31b2eacc2bf2a5'.
	cipherText := ByteArray readHexFrom: '25AEB6F4C119159307696D1F37185D117094A5082001250E026E82503B0C6521'.
