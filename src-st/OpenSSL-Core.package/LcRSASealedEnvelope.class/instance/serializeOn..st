serialize/materialize
serializeOn: aStream
	"Write the receiver on the supplied stream"

	aStream
		nextPutAll: ((ByteArray new: 8) unsignedLongLongAt: 1 put: initializationVector size; yourself);
		nextPutAll: initializationVector;
		nextPutAll: ((ByteArray new: 8) unsignedLongLongAt: 1 put: encryptedSecret size; yourself);
		nextPutAll: encryptedSecret;
		nextPutAll: ((ByteArray new: 8) unsignedLongLongAt: 1 put: content size; yourself);
		nextPutAll: content