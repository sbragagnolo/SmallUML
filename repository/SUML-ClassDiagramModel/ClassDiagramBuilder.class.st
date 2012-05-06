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

	| instVarForAssociation sender anyElementClass |
	sender := aProcess sender receiver.

	(self ignoresMessageIn: aProcess) not
		ifTrue: [ 
			
			self addAssociationIfPossibleFromInstVarsUsedIn: aProcess.
			
			instVarForAssociation :=  sender class instVarNames
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
					(self diagramNodeForClass: (self desiredClassFrom: sender) name asString) hasA: (self diagramNodeForClass: (self desiredClassFrom: aProcess receiver) name asString) labeledAs: instVarForAssociation 
							 ]
						ifFalse:[
							aProcess receiver notEmpty ifTrue:[
							self flag: #todo. "habría que fijarse si los elementos de la colección son de distinta clase, poner una superclase o extraer una interfaz"
							anyElementClass := (self diagramNodeForClass: (self desiredClassFrom: aProcess receiver anyOne)).
							(self ignoresClass: (self desiredClassFrom: anyElementClass)) ifFalse:[
							(self diagramNodeForClass: (self desiredClassFrom: sender)  name asString) hasLotsOf: anyElementClass  name asString labeledAs: instVarForAssociation ]
						
							] ]]]
]

{ #category : #'as yet unclassified' }
ClassDiagramBuilder >> addAssociationIfPossibleFromInstVarsUsedIn: aProcess [
	aProcess  method referredInstVars do:[:instVarName | 
		(self ignoresClass: (self desiredClassFrom: (aProcess receiver instVarNamed: instVarName))) 
			ifTrue:[
				(aProcess receiver instVarNamed: instVarName) isCollection 
				ifTrue:[((aProcess receiver instVarNamed: instVarName) notEmpty)
				ifTrue:[
					(self diagramNodeForClass: (self desiredClassFrom: aProcess receiver) name asString) 
				hasLotsOf: (self diagramNodeForClass: (self desiredClassFrom:  (aProcess receiver instVarNamed: instVarName) anyOne) name asString) labeledAs: instVarName ]]
				ifFalse:[(aProcess receiver instVarNamed: instVarName) ifNotNil:[(self diagramNodeForClass: (self desiredClassFrom: aProcess receiver) name asString) addInstVar: instVarName ]]
			]
				ifFalse:[	
			(self diagramNodeForClass: (self desiredClassFrom: aProcess receiver) name asString) 
				hasA: (self diagramNodeForClass: (self desiredClassFrom:  (aProcess receiver instVarNamed: instVarName)) name asString) labeledAs: instVarName ]] .
]

{ #category : #adding }
ClassDiagramBuilder >> addClassesBetween: aClass and: aSuperClass [

aClass class ~= aSuperClass ifTrue:[									
	(aClass class allSuperclasses copyUpTo: aSuperClass superclass) 
		do:[:receiverSuperclass |
			(self ignoresClass: (self desiredClassFrom: aClass)) 
				ifTrue:["if this class is ignored, it doesn't make sense to add it's superclasses" ^self]
				ifFalse:[
					self addDiagramNodeForClass: (self desiredClassFrom: receiverSuperclass) ]]]
]

{ #category : #adding }
ClassDiagramBuilder >> addDiagramNodeForClass: aClass [
	diagramNodes at: aClass name asString ifAbsentPut:[ClassBox named: aClass name asString ]
]

{ #category : #adding }
ClassDiagramBuilder >> addMethod: aSelector toClass: aClass [
	 (aClass class includesSelector: aSelector)
				ifTrue: [(self diagramNodeForClass: aClass name) addClassMethod: aSelector ]
				ifFalse: [ (self diagramNodeForClass: aClass name) addMethod: aSelector ]
]

{ #category : #adding }
ClassDiagramBuilder >> addMethodIfPossibleInContext: context [
	"Adds the method to the class box of the class where it's defined. If the method is defined in a superclass of the object that receives the message, and that superclass is ignored, it's not showed in the diagram. If that superclass is not ignored, every class between the receiver's and  that supeclass are included in the diagram, even if they don't have methods of interest to show"
	| desiredClass |
	desiredClass := (self desiredClassFrom: context contextClass  ).
	"(self classIsInDesiredScope: desiredClass)
		ifTrue: [ "
	(self ignoresClass: desiredClass ) ifFalse:[
			self addDiagramNodeForClass: desiredClass.
			self addMethod: context method selector toClass: desiredClass.
			self addClassesBetween: context receiver and: context contextClass.]	
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
	^(aClass isBehavior
			ifTrue: [ aClass isMeta ifTrue:[aClass theNonMetaClass ] ifFalse:[aClass]]
			ifFalse: [aClass class ]).
]

{ #category : #adding }
ClassDiagramBuilder >> diagramNodeForClass: aClassName [
	^diagramNodes at: aClassName ifAbsentPut:[ClassBox named: aClassName]
]

{ #category : #'as yet unclassified' }
ClassDiagramBuilder >> fromBlock: aBlock [
	| block |
	block := aBlock asContext .
	thisContext
		runSimulated: aBlock
		contextAtEachStep: [ :context | 
							(block sender notNil and:[(self ignoredSelectors includes: block method selector) not])
								ifTrue: [ 
									self addMethodIfPossibleInContext: block.
									self addAssociationIfPossibleFrom: block ]"].".
					block := context  ].	
	^ self buildClassDiagram
]

{ #category : #testing }
ClassDiagramBuilder >> ignoredCategories [
	"This shoudn't be hardcoded"
	^ Smalltalk kernelPackageNames , (SystemOrganization categoriesMatching: 'Kernel*')
]

{ #category : #testing }
ClassDiagramBuilder >> ignoredCategoriesIncludeClass: aClass [
	^self ignoredCategories anySatisfy:[:cat | aClass category = cat]
]

{ #category : #'as yet unclassified' }
ClassDiagramBuilder >> ignoredSelectors [ 
	^#(#new #initialize)
]

{ #category : #testing }
ClassDiagramBuilder >> ignoresClass: aClass [
	"^( (((((self namesOfIgnoredClasses includes: aClass name asString) or: [ aClass isCollection ])
		or: [ aClass isBehavior and: [ aClass inheritsFrom: Collection ] ]) or: [ aClass isNumber ])
		or: [ aClass inheritsFrom: Boolean ])
		or:[ aClass inheritsFrom: Number])
		or:[aClass inheritsFrom:  Magnitude]"
	^self ignoredCategoriesIncludeClass: aClass
]

{ #category : #'as yet unclassified' }
ClassDiagramBuilder >> ignoresMessageIn: context [
	^((self ignoresClass: (self desiredClassFrom: context receiver)) or:[self ignoresClass: (self desiredClassFrom: context contextClass)]) or:[context sender receiver notNil and:[self ignoresClass: (self desiredClassFrom: context sender receiver )]]
					
]

{ #category : #'as yet unclassified' }
ClassDiagramBuilder >> initialize [ 
	associations := Set new.
	methodsInClasses := Dictionary new.
	diagram := ClassDiagram new.
	diagramNodes := Dictionary new.
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
