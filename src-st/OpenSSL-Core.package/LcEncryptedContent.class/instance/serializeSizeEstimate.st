private
serializeSizeEstimate
	"Answer an estimate of how long the stream will be when the receiver is serialised.
	Slightly over is better than slightly under."

	^ self subclassResponsibility