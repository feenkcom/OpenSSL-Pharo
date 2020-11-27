instance creation
initializationVector: ivByteArray additionalAuthenticatedData: aadByteArray tag: tagByteArray

	^ self new 
		initializationVector: ivByteArray;
		additionalAuthenticatedData: aadByteArray;
		tag: tagByteArray 