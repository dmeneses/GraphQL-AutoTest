*GraphQL-AutoTest
decompile

	value isNil
	ifTrue:[
		^''
		].
	^ '{1}: {2}'
		format:
			{self name.
			self value decompile}