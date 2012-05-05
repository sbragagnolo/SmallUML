Class {
	#name : #ClassDiagramBuilder,
	#superclass : #Object,
	#instVars : [
		'diagram',
		'associations',
		'methodsInClasses',
		'diagramNodes'
	],
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #adding }
ClassDiagramBuilder >> addAssociation: aRelationship [ 
	associations add: aRelationship 
]

{ #category : #'as yet unclassified' }
ClassDiagramBuilder >> addAssociationIfPossibleFrom: aProcess [
	"If the sender has an instance variable that points to the receiver, this adds an association between the sender and receiver classes.
	If not, and if there isn't already a relationship between them, it adds a use relationship."

	| instVarForAssociation sender |
	sender := aProcess sender receiver.

	(self namesOfIgnoredClasses includes: sender className) not 
		ifTrue: [ 
			instVarForAssociation :=sender class instVarNames
				detect: [ :instVarName | (sender instVarNamed: instVarName )== aProcess receiver ]
				ifNone: [  ].
			instVarForAssociation
				"ifNil: [ 
					(self associations
						noneSatisfy: [ :asoc | 
							(asoc originDiagramNode name = sender className
								& (asoc destinationDiagramNode name = aProcess receiver className) & asoc label) = instVarForAssociation ])
						ifTrue: [ 
							self
								addAssociation:
									((UseRelationship from:  sender className to: aProcess receiver className) label: instVarForAssociation) ] ]"
				ifNotNil: [ 
					( aProcess receiver isCollection not) ifTrue:[
					(self diagramNodeForClass: sender className) hasA: (self diagramNodeForClass: aProcess receiver className) labeledAs: instVarForAssociation 
							 ]
						ifFalse:[
							aProcess receiver notEmpty ifTrue:[
							self flag: #todo. "habría que fijarse si los elementos de la colección son de distinta clase, poner una superclase o extraer una interfaz"
							(self diagramNodeForClass: sender className) hasLotsOf: (self diagramNodeForClass: aProcess receiver anyOne className) labeledAs: instVarForAssociation 
						
							] ]]]
]

{ #category : #adding }
ClassDiagramBuilder >> addDiagramNodeForClass: aClass [
	diagramNodes at: aClass name asString ifAbsentPut:[ClassBox named: aClass name asString ]
]

{ #category : #adding }
ClassDiagramBuilder >> addMethod: aSelector toClass: anObject [
	| desiredClass |
	desiredClass := anObject isBehavior
		ifTrue: [ anObject ]
		ifFalse: [ anObject class ].
	(self classIsInDesiredScope: desiredClass)
		ifTrue: [ 
			self addDiagramNodeForClass: desiredClass.
			desiredClass := anObject isBehavior
				ifTrue: [ (self diagramNodeForClass: desiredClass name) addClassMethod: aSelector ]
				ifFalse: [ (self diagramNodeForClass: desiredClass name) addMethod: aSelector ] ]
]

{ #category : #accessing }
ClassDiagramBuilder >> associations [
	^ associations
]

{ #category : #'as yet unclassified' }
ClassDiagramBuilder >> associationsFromClass: aClass [
	^self associations select:[:asoc | asoc originDiagramNode  = aClass]
]

{ #category : #'as yet unclassified' }
ClassDiagramBuilder >> buildClassDiagram [
	diagramNodes do:[:aDiagramNode |
		diagram addDiagramNode: aDiagramNode.].
	^diagram
]

{ #category : #adding }
ClassDiagramBuilder >> classIsInDesiredScope: aClass [
	^ self scopeCategories anySatisfy: [:category | (SystemOrganization classesInCategory: category) includes: aClass]
]

{ #category : #'as yet unclassified' }
ClassDiagramBuilder >> classMethodsOfClass: aClass [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
ClassDiagramBuilder >> classNames [
	^ methodsInClasses keys 
]

{ #category : #'as yet unclassified' }
ClassDiagramBuilder >> classes [
	^ methodsInClasses keys 
]

{ #category : #'as yet unclassified' }
ClassDiagramBuilder >> desiredClassFrom: aClass [ 
	^aClass isBehavior
										ifTrue: [ aClass ]
										ifFalse: [aClass class ].
]

{ #category : #adding }
ClassDiagramBuilder >> diagramNodeForClass: aClassName [
	^diagramNodes at: aClassName ifAbsentPut:[ClassBox named: aClassName]
]

{ #category : #'as yet unclassified' }
ClassDiagramBuilder >> fromBlock: aBlock [
	| block desiredClass |
	block := aBlock.
	thisContext
		runSimulated: aBlock
		contextAtEachStep: [ :context | 
			context == block
				ifFalse: [ 
					((self ignoresClass: (self desiredClassFrom: context receiver)) or:[(self ignoresClass: (self desiredClassFrom: context contextClass))])
						ifFalse: [ 
							
							(block sender notNil and:[(self ignoredSelectors includes: context method selector) not])
								ifTrue: [ 
									self addMethod: context method selector toClass: context contextClass.
									( (context receiver class ~= context contextClass) ) ifTrue:[
									
										(context receiver class allSuperclasses copyUpTo: context contextClass superclass) do:[:receiverSuperclass |
									
									(self ignoresClass: (self desiredClassFrom: context receiver)) ifFalse:[
									self addDiagramNodeForClass: (self desiredClassFrom: receiverSuperclass) ].
									]].
									self addAssociationIfPossibleFrom: block ].
							]
						ifTrue:[
							"an object other than a collection is sending a message with arguments to a collection. It's a way to guess messages like do:, collect:, select:..."
							"(context receiver ) isCollection & context sender receiver isCollection not ifTrue:[
								context numArgs > 0 ifTrue:[
									(context tempAt: 1) isBlock ifTrue: [self halt.]] ]."
							block sender notNil ifTrue:[self addAssociationIfPossibleFrom: block]].
					block := context  ] ].
			
	^ self buildClassDiagram
]

{ #category : #'as yet unclassified' }
ClassDiagramBuilder >> ignoredSelectors [ 
	^#(#new #initialize)
]

{ #category : #testing }
ClassDiagramBuilder >> ignoresClass: aClass [
	^( (((((self namesOfIgnoredClasses includes: aClass name asString) or: [ aClass isCollection ])
		or: [ aClass isBehavior and: [ aClass inheritsFrom: Collection ] ]) or: [ aClass isNumber ])
		or: [ aClass = true or: [ aClass = false ] ])
		or:[ aClass inheritsFrom: Number])
		or:[aClass inheritsFrom:  Magnitude]
]

{ #category : #'as yet unclassified' }
ClassDiagramBuilder >> initialize [ 
	associations := Set new.
	methodsInClasses := Dictionary new.
	diagram := ClassDiagram new.
	diagramNodes := Dictionary new.
]

{ #category : #adding }
ClassDiagramBuilder >> methodsOfClass: aClass [ 
	^self methodsOfClassName: aClass name
]

{ #category : #'as yet unclassified' }
ClassDiagramBuilder >> methodsOfClassName: aString [ 
	methodsInClasses at: aString ifAbsentPut: [Set new].
	^methodsInClasses at: aString
]

{ #category : #'as yet unclassified' }
ClassDiagramBuilder >> namesOfIgnoredClasses [ 
	^#('MethodContext' 'BlockClosure' 'UndefinedObject' 'HashTableSizes' 'Behavior' 'Metaclass' 'ClassDescription' 'Object' 'ProtoObject' 'Compiler')
]

{ #category : #'as yet unclassified' }
ClassDiagramBuilder >> scopeCategories [
	"esto es solo para una prueba, debería ser una variable de instancia"
	^#('Sueldos-model' 'Sueldos-stack')
]
