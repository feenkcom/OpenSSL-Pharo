accessing
newAes256PrivateKey
	"Answer a new AES 256 bit private key"

	^ self uniqueInstance randomPrivateBytesOfSize: 32.