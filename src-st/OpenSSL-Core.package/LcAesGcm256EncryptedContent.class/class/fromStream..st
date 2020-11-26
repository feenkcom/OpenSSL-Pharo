instance creation
fromStream: aReadStream
	"Answer an instance of the receiver read from the supplied stream"
	| iv aad tag contentSize |

	iv := aReadStream next: 12.
	aad := aReadStream next: 16.
	tag := aReadStream next: 16.
	contentSize := (aReadStream next: 8) unsignedLongLongAt: 1.
	^ self new 
		initializationVector: iv;
		additionalAuthenticatedData: aad;
		tag: tag;
		content: (aReadStream next: contentSize).
	