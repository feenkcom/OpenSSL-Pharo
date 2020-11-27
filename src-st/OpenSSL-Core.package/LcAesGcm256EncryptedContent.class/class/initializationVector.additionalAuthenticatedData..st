instance creation
initializationVector: ivByteArray additionalAuthenticatedData: aadByteArray 

	^ self new 
		initializationVector: ivByteArray;
		additionalAuthenticatedData: aadByteArray