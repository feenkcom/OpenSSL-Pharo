serialize/materialize
serializeOn: aStream
	"Write the receiver on the supplied stream"

	aStream
		nextPutAll: initializationVector;
		nextPutAll: additionalAuthenticatedData;
		nextPutAll: tag;
		nextPutAll: ((ByteArray new: 8) unsignedLongLongAt: 1 put: content size; yourself);
		nextPutAll: content