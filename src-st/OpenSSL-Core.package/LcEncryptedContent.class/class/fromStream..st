instance creation
fromStream: aReadStream
	"Answer an instance of the receiver read from the supplied stream"

	^ self subclassResponsibility 