Class {
	#name : #InterfaceBox,
	#superclass : #DiagramNode,
	#instVars : [
		'classMethods',
		'instanceMethods'
	],
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #creation }
InterfaceBox class >> newNamed: aByteString [ 
	^self new boxTitle: aByteString 
]

{ #category : #accessing }
InterfaceBox >> boxTitle [
	^ self name
]

{ #category : #accessing }
InterfaceBox >> boxTitle: aBoxTitle [
	self name: aBoxTitle .
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
InterfaceBox >> descriptionCode [
	^self creationAndDefinitionCode
	
]

{ #category : #drawing }
InterfaceBox >> height [
	^self view fullBounds height
]

{ #category : #relations }
InterfaceBox >> inheritsFromClass: anotherClassBox [
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

{ #category : #'as yet unclassified' }
InterfaceBox >> mapsToModel [ 
	^false
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

{ #category : #accessing }
InterfaceBox >> realDiagramNode [
	^self
]

{ #category : #'as yet unclassified' }
InterfaceBox >> relateIfPossibleTo: aDiagramNode [
	
	
]

{ #category : #'as yet unclassified' }
InterfaceBox >> selectorsAsStrings: selectors [
	^selectors collect:[:selector | selector asString]
]

{ #category : #'as yet unclassified' }
InterfaceBox >> updaterClass [
	^InterfaceAndTraitBoxUpdater 
]

{ #category : #relations }
InterfaceBox >> usesTrait: aTraitBox [
	self addRelationship: (Relationship useTraitRelationshipFrom: self to: aTraitBox )
]

{ #category : #drawing }
InterfaceBox >> view [
	^InterfaceBoxMorph forBox: self
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
