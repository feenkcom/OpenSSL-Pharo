private - accessing
unix64LibraryName
	^ FFIUnix64LibraryFinder findLibrary: 'libcrypto.so'