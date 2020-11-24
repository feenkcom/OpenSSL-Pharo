class initialization
initialize
	"Auto-generated class initialisation"

	self initializeEnumeration.
	Author
		useAuthor: 'UFFI'
		during: [ self rebuildEnumAccessors ]
