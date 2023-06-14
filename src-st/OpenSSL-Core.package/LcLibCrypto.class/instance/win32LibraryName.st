private - accessing
win32LibraryName
	"Technically this should be win64LibraryName..."
	^ FFIWindowsLibraryFinder findLibrary: 'crypto.dll'