converting
asByteArray 
	| stream |

	stream := (ByteArray new: self serializeSizeEstimate) writeStream.
	self serializeOn: stream.
	^ stream contents