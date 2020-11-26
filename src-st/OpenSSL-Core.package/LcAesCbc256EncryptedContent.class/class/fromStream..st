instance creation
fromStream: aReadStream
	"Answer an instance of the receiver read from the supplied stream"
	| iv contentSize |

	iv := aReadStream next: 12.
	contentSize := (aReadStream next: 8) unsignedLongLongAt: 1.
	^ self new 
		initializationVector: iv;
		content: (aReadStream next: contentSize).
	