accessing
contentHash 
	"Answer a unique identifier of the receiver's encrypted content.
	AES GCM has a tag which is effectively unique for each key / aad / content combination."

	^ tag hex