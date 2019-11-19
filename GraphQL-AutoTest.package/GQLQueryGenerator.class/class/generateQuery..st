as yet unclassified
generateQuery: document
	| schema documentNode stream fieldsMutator argumentsMutator |
	schema := GQLSchemaGrammarEvaluator parse: document.
	documentNode := GQLDocumentNode build: schema.
	stream := FileStream forceNewFileNamed: 'test.txt'.
	stream nextPutAll: '#----------Main Template------------' , String cr.
	stream nextPutAll: documentNode decompile.
	stream nextPutAll: '#----------Possible queries: field mutations------------' , String cr.
	fieldsMutator := NonNullArgumentsMutator new
		documentNode: documentNode;
		yourself.
	"[ fieldsMutator hasNextMutation ] whileTrue: [ stream nextPutAll: fieldsMutator getNextMutation decompile ]."
	[ fieldsMutator hasNextMutation ] whileTrue: [ Transcript show: fieldsMutator getNextMutation decompile ].
	"stream nextPutAll: '#----------Possible queries: argument mutations------------' , String cr.
	argumentsMutator := ArgumentsMutator new
		documentNode: documentNode;
		yourself.
	[ argumentsMutator hasNextMutation ] whileTrue: [ stream nextPutAll: argumentsMutator getNextMutation decompile ]."
	stream close