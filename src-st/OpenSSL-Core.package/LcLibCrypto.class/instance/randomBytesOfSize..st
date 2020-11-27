API - Random
randomBytesOfSize: anInteger
	"Answer a ByteArray size anInteger filled with random bytes"
	| byteArray |

	byteArray := ByteArray new: anInteger.
	self randomBytes: byteArray.
	^ byteArray.