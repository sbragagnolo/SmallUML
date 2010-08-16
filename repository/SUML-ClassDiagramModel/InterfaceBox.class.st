Class {
	#name : #InterfaceBox,
	#superclass : #Object,
	#instVars : [
		'classMethods',
		'position',
		'instanceMethods',
		'relations',
		'boxTitle'
	],
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #creation }
InterfaceBox class >> named: aClassName [ 
	^self new boxTitle: aClassName  
]

{ #category : #creation }
InterfaceBox class >> newNamed: aByteString [ 
	^self new boxTitle: aByteString 
]

{ #category : #'as yet unclassified' }
InterfaceBox class >> selectorsAsStrings: selectors [
	^selectors collect:[:selector | selector asString]
]

{ #category : #accessing }
InterfaceBox >> addDependent: aDependent [
	"should always have one and only one dependent"
	self breakDependents.
	super addDependent: aDependent 
	
]

{ #category : #relations }
InterfaceBox >> addRelationship: aRelationship [ 
	self relations add: aRelationship.
]

{ #category : #accessing }
InterfaceBox >> boxTitle [
	^ boxTitle
]

{ #category : #accessing }
InterfaceBox >> boxTitle: aBoxTitle [
	boxTitle := aBoxTitle.
	self changed: #title
]

{ #category : #accessing }
InterfaceBox >> classMethods [
	^ classMethods  ifNil:[Array empty.]
]

{ #category : #accessing }
InterfaceBox >> classMethods: anObject [
	classMethods := anObject.
	self changed: #methods
]

{ #category : #'description code' }
InterfaceBox >> creationAndDefinitionCode [ 
	^self creationCode , self definitionCode 
]

{ #category : #'description code' }
InterfaceBox >> creationCode [
	|descriptionCode|
	descriptionCode := WriteStream with: (self variableNameForDescriptionCode, ':= ', self className, ' named: ''', self boxTitle,'''.').
	descriptionCode nextPut: Character cr.
	^descriptionCode contents
	
]

{ #category : #'description code' }
InterfaceBox >> definitionCode [ 
	|descriptionCode|
	descriptionCode := WriteStream with: ''.
	self writeDefinitionDescriptionOn: descriptionCode.
	descriptionCode nextPut: Character cr.
	self writePositioningDescriptionOn: descriptionCode.
	^descriptionCode contents
	
]

{ #category : #'description code' }
InterfaceBox >> descriptionCode [
	^self creationAndDefinitionCode
	
]

{ #category : #'description code' }
InterfaceBox >> descriptionCodeForBoxEdition [ 
	^self definitionCode
]

{ #category : #drawing }
InterfaceBox >> height [
	^self view fullBounds height
]

{ #category : #relations }
InterfaceBox >> inheritsFrom: anotherClassBox [
	self addRelationship: (Relationship inheritanceRelationshipFrom: self to: anotherClassBox )
]

{ #category : #accessing }
InterfaceBox >> instanceMethods [
	^instanceMethods  ifNil:[Array empty.]
]

{ #category : #accessing }
InterfaceBox >> instanceMethods: anArray [ 
	instanceMethods:= anArray .
	self changed: #methods
]

{ #category : #relations }
InterfaceBox >> isATypeOf: aTypeBox [
	self implements: aTypeBox 
]

{ #category : #drawing }
InterfaceBox >> methods [
	^ self instanceMethods asOrderedCollection 
		addAllLast: (self classMethods collect:[:selector | '(Class) ', selector]);
		yourself
]

{ #category : #'description code' }
InterfaceBox >> openDescriptionCode [
	SHWorkspace new contents: self descriptionCode; open
]

{ #category : #drawing }
InterfaceBox >> position [
	^position ifNil:[0@0]
]

{ #category : #drawing }
InterfaceBox >> position: aPoint [ 
	position:= aPoint.
	self changed: #position
]

{ #category : #'as yet unclassified' }
InterfaceBox >> printString [ 
	^self boxTitle 
]

{ #category : #accessing }
InterfaceBox >> realBox [
	^self
]

{ #category : #accessing }
InterfaceBox >> relations [
	^relations ifNil:[relations := OrderedCollection new]
]

{ #category : #accessing }
InterfaceBox >> relations: aCollection [
	relations := aCollection 
]

{ #category : #'description code' }
InterfaceBox >> relationshipsCode [ 
	|descriptionCode|
	descriptionCode := WriteStream with: ''.
	self writeRelationshipsDescriptionOn: descriptionCode.
	^descriptionCode contents
	
]

{ #category : #relations }
InterfaceBox >> removeRelationship: aRelationship [ 
	self relations remove: aRelationship 
]

{ #category : #'as yet unclassified' }
InterfaceBox >> removeRelationshipsWith: aBox [
	^self relations removeAllSuchThat: [:rel | rel connects: aBox]
]

{ #category : #'as yet unclassified' }
InterfaceBox >> updaterClass [
	^InterfaceAndTraitBoxUpdater 
]

{ #category : #relations }
InterfaceBox >> usesTrait: aTraitBox [
	self addRelationship: (Relationship useTraitRelationshipFrom: self to: aTraitBox )
]

{ #category : #'description code' }
InterfaceBox >> variableNameForDescriptionCode [
	^self boxTitle withFirstCharacterDownshifted.
]

{ #category : #drawing }
InterfaceBox >> view [
	^(InterfaceBoxMorph forBox: self)
]

{ #category : #'description code' }
InterfaceBox >> writeDefinitionDescriptionOn: aStream [
	
	self writeDescription: 'instanceMethods:' withValue: self instanceMethods on: aStream .
	self writeDescription: 'classMethods:' withValue: self classMethods on: aStream .
	

]

{ #category : #'description code' }
InterfaceBox >> writeDescription: aSelector  withValue: aCollection on: aStream [
	aCollection ifNotEmpty:[
			aStream nextPutAll: self variableNameForDescriptionCode, ' ', aSelector, aCollection asArray asString,'.'.
			aStream nextPut: Character cr ]
]

{ #category : #'description code' }
InterfaceBox >> writePositioningDescriptionOn: aStream [
	self position ifNotNil:[
		aStream nextPutAll: '"Positioning"'.
		aStream nextPut: Character cr.
		aStream nextPutAll: self variableNameForDescriptionCode, ' position: ', self position asString, '.']
]

{ #category : #'description code' }
InterfaceBox >> writeRelationshipsDescriptionOn: aStream [
	self relations ifNotEmpty:[
		aStream nextPut: Character cr; cr.
		aStream nextPutAll: '"Relationships"'.
		self relations ifEmpty: [aStream nextPut: Character cr].
		self relations do:[:relation | aStream nextPut: Character cr. relation writeDescriptionOn: aStream ]
		]
]
