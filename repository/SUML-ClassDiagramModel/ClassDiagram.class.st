Class {
	#name : #ClassDiagram,
	#superclass : #Object,
	#instVars : [
		'category',
		'name',
		'description',
		'boxesDescriptions'
	],
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #adding }
ClassDiagram >> addBoxDescription: aBoxDescription [
	self boxes add: aBoxDescription.
	self changed: #view
]

{ #category : #adding }
ClassDiagram >> addNewClassDescriptionNamed: aClassName [
	self addBoxDescription: (ClassBox new boxTitle: aClassName )
]

{ #category : #accessing }
ClassDiagram >> boxes [
	^boxesDescriptions ifNil:[boxesDescriptions := OrderedCollection new]
]

{ #category : #accessing }
ClassDiagram >> category [
	^ category
]

{ #category : #accessing }
ClassDiagram >> category: anObject [
	category := anObject
]

{ #category : #'as yet unclassified' }
ClassDiagram >> changed [
	self changed: #view.
	super changed.
]

{ #category : #saving }
ClassDiagram >> deleteDescriptionIn: aDiagramHolderClass [
	aDiagramHolderClass removeSelector: self name onlyLetters withFirstCharacterDownshifted asSymbol 
	
]

{ #category : #accessing }
ClassDiagram >> description [
	^ description
]

{ #category : #accessing }
ClassDiagram >> description: anObject [
	description := anObject
]

{ #category : #accessing }
ClassDiagram >> descriptionCode [ 
	|descriptionCode|
	descriptionCode :=  WriteStream on: ''.
	descriptionCode nextPutAll: '| d '.
	(self boxes collect:[:classBox | classBox variableNameForDescriptionCode ]) asStringOn: descriptionCode delimiter: String space.
	descriptionCode nextPutAll: '|'.
	(self boxes collect:[:classBox | classBox creationAndDefinitionCode ]) asStringOn: descriptionCode delimiter: String cr, String cr.
	
	(self boxes collect:[:classBox | classBox relationshipsCode ]) asStringOn: descriptionCode delimiter: String cr, String cr.
	
	descriptionCode nextPutAll: ' d := (ClassDiagram new name: ''', self name, ''' ) '.
	(self boxes collect:[:classBox | 'addBoxDescription: ', classBox variableNameForDescriptionCode ]) asStringOn: descriptionCode delimiter: $; asString.
	descriptionCode nextPutAll: '.^ d'.
	^descriptionCode contents
]

{ #category : #accessing }
ClassDiagram >> descriptionCodeOf: aClassBox [ 
	^aClassBox descriptionCodeForBoxEdition 
]

{ #category : #accessing }
ClassDiagram >> displayString [
	^self name
]

{ #category : #accessing }
ClassDiagram >> name [
	^ name
]

{ #category : #accessing }
ClassDiagram >> name: anObject [
	name := anObject
]

{ #category : #'user interface' }
ClassDiagram >> openDescriptionCodeinWorkspace [
	SHWorkspace new contents: self descriptionCode; open
]

{ #category : #accessing }
ClassDiagram >> printString [
	^self displayString 
]

{ #category : #accessing }
ClassDiagram >> removeBoxDescription: aBoxDescription [
	self boxes remove: aBoxDescription.
	self boxes do:[:box | box removeRelationshipsWith: aBoxDescription ].
	self changed: #view
]

{ #category : #saving }
ClassDiagram >> saveDescriptionIn: aDiagramHolderClass [
	|descriptionCodeAsMethod|
	descriptionCodeAsMethod := aDiagramHolderClass prettyPrinterClass new 
		format: ((self name onlyLetters withFirstCharacterDownshifted), String cr, self descriptionCode) 
		in: aDiagramHolderClass 
		notifying: self.
	aDiagramHolderClass compile: descriptionCodeAsMethod classified: 'diagrams'
	
]
