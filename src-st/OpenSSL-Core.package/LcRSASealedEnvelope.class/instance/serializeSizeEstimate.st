private
serializeSizeEstimate
	"Answer an estimate of how long the stream will be when the receiver is serialised.
	Slightly over is better than slightly under."

	^ content size + initializationVector size + encryptedSecret size + (8 + 8 + 8)