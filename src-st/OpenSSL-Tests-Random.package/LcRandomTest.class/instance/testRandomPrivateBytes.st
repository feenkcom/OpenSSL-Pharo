tests
testRandomPrivateBytes
	| bytes1 bytes2 status |

	bytes1 := ByteArray new: 16.
	self assert: (bytes1 allSatisfy: [ :byte | byte = 0 ]).
	status := LcLibCrypto uniqueInstance randomPrivateBytes: bytes1.
	self assert: status equals: 1.
	self deny: bytes1 equals: (ByteArray new: 16).

	bytes2 := ByteArray new: 16.
	self assert: (bytes2 allSatisfy: [ :byte | byte = 0 ]).
	status := LcLibCrypto uniqueInstance randomPrivateBytes: bytes2.
	self assert: status equals: 1.
	self deny: bytes2 equals: (ByteArray new: 16).

	self deny: bytes1 equals: bytes2.