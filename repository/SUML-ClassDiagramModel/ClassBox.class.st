Class {
	#name : #ClassBox,
	#superclass : #InterfaceBox,
	#instVars : [
		'instanceVariables',
		'classInstanceVariables',
		'classVariables'
	],
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #'as yet unclassified' }
ClassBox class >> fromClass: aClass [
	aClass isBehavior ifFalse:[self error: aClass name asString , ' is not a Class'].
	^(self 
		newNamed: aClass name asString )
			instanceVariables: (aClass instVarNames);
			instanceMethods: (self selectorsAsStrings: aClass selectors);
			classInstanceVariables: (aClass class instVarNames);
			classVariables: (aClass class classVarNames);
			classMethods: (self selectorsAsStrings: aClass class selectors)
]

{ #category : #accessing }
ClassBox >> classInstanceVariables [
	^ classInstanceVariables  ifNil:[Array empty.]
]

{ #category : #accessing }
ClassBox >> classInstanceVariables: anObject [
	classInstanceVariables := anObject.
	self changed: #variables
]

{ #category : #accessing }
ClassBox >> classMethods [
	^ classMethods  ifNil:[Array empty.]
]

{ #category : #accessing }
ClassBox >> classMethods: anObject [
	classMethods := anObject.
	self changed: #methods
]

{ #category : #accessing }
ClassBox >> classVariables [
	^ classVariables  ifNil:[Array empty.]
]

{ #category : #accessing }
ClassBox >> classVariables: anObject [
	classVariables := anObject.
	self changed: #variables
]

{ #category : #'description code' }
ClassBox >> descriptionCode [
	^super descriptionCode, self relationshipsCode 
	
]

{ #category : #'description code' }
ClassBox >> descriptionCodeForBoxEdition [ 
	^super descriptionCodeForBoxEdition, self relationshipsCode
]

{ #category : #relations }
ClassBox >> hasA: anotherClassBox labeledAs: aLabel [
	self addRelationship: (Relationship associationRelationshipFrom: self to: anotherClassBox labeledAs: aLabel)
]

{ #category : #relations }
ClassBox >> hasLotsOf: anotherClassBox labeledAs: aLabel [
	self addRelationship: ((Relationship associationRelationshipFrom: self to: anotherClassBox labeledAs: aLabel) oneToMany: true)
]

{ #category : #drawing }
ClassBox >> height [
	^self view fullBounds height
]

{ #category : #relations }
ClassBox >> implements: anInterfaceBox [
	self addRelationship: (Relationship implementationRelationshipFrom: self to: anInterfaceBox )
]

{ #category : #relations }
ClassBox >> inheritsFrom: anotherClassBox [
	self addRelationship: (Relationship inheritanceRelationshipFrom: self to: anotherClassBox )
]

{ #category : #accessing }
ClassBox >> instanceMethods [
	^instanceMethods  ifNil:[Array empty.]
]

{ #category : #accessing }
ClassBox >> instanceMethods: anArray [ 
	instanceMethods:= anArray .
	self changed: #methods
]

{ #category : #accessing }
ClassBox >> instanceVariables [
	^ instanceVariables ifNil:[Array empty.]
]

{ #category : #accessing }
ClassBox >> instanceVariables: anObject [
	instanceVariables := anObject.
	self changed: #variables
]

{ #category : #relations }
ClassBox >> isATypeOf: aTypeBox [
	self implements: aTypeBox 
]

{ #category : #relations }
ClassBox >> updaterClass [
	^ClassBoxUpdater 
]

{ #category : #relations }
ClassBox >> usesA: anotherClassBox labeledAs: aLabel [
	self addRelationship: (Relationship useRelationshipFrom: self to: anotherClassBox labeledAs: aLabel)
]

{ #category : #relations }
ClassBox >> usesLotsOf: anotherClassBox labeledAs: aLabel [
	self addRelationship: ((Relationship useRelationshipFrom: self to: anotherClassBox labeledAs: aLabel) oneToMany: true)
]

{ #category : #drawing }
ClassBox >> variables [
	^ self instanceVariables asOrderedCollection
		addAllLast: (self classInstanceVariables collect:[:variableName | '(Class Instance) ', variableName]);
		addAllLast: (self classVariables collect:[:variableName | '(Class) ', variableName]);
		yourself
]

{ #category : #drawing }
ClassBox >> view [
	^(ClassBoxMorph forBox: self)
]

{ #category : #'description code' }
ClassBox >> writeDefinitionDescriptionOn: aStream [
	self writeDescription: 'instanceVariables:' withValue: self instanceVariables on: aStream.
	self writeDescription: 'classInstanceVariables:' withValue: self classInstanceVariables on: aStream .
	self writeDescription: 'classVariables:' withValue: self classVariables on: aStream .
	super writeDefinitionDescriptionOn: aStream 
]
