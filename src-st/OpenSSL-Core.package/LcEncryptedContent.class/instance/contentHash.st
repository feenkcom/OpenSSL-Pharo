accessing
contentHash 
	"Answer a unique identifier of the receiver's encrypted content.
	By default this is the SHA256 hash, but may be a tag / Mac if the cipher supports it."

	^ (SHA256 hashStream: content readStream) hex