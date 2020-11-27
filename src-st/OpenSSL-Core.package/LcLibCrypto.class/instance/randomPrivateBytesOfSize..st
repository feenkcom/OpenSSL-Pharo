API - Random
randomPrivateBytesOfSize: anInteger
	"Answer a ByteArray size anInteger filled with random private bytes"
	| byteArray |

	byteArray := ByteArray new: anInteger.
	self randomPrivateBytes: byteArray.
	^ byteArray.