initialization
initialize 

	super initialize.
	key := ByteArray readHexFrom: 'eebc1f57487f51921c0465665f8ae6d1658bb26de6f8a069a3520293a572078f'.
	initializationVector := ByteArray readHexFrom: '99aa3e68ed8173a0eed06684'.
	plainText := ByteArray readHexFrom: 'f56e87055bc32d0eeb31b2eacc2bf2a5'.
	aditionalAutneticatedData := ByteArray readHexFrom: '4d23c3cec334b49bdb370c437fec78de'.
	cipherText := ByteArray readHexFrom: 'f7264413a84c0e7cd536867eb9f21736'.
	tag := ByteArray readHexFrom: '67ba0510262ae487d737ee6298f77e0c'.
