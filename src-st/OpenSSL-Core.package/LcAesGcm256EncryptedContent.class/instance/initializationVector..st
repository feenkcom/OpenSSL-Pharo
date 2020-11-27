private
initializationVector: aByteArray

	self assert: [ aByteArray size = 12 ].
	super initializationVector: aByteArray.