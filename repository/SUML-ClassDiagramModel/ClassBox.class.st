Class {
	#name : #ClassBox,
	#superclass : #InterfaceBox,
	#instVars : [
		'instanceVariables',
		'classInstanceVariables',
		'classVariables',
		'targetClass'
	],
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #'as yet unclassified' }
ClassBox class >> fromClass: aClass [
	aClass isBehavior ifFalse:[self error: aClass name asString , ' is not a Class'].
	^(self 
		newNamed: aClass name asString )
			targetClass: aClass;
			updateFromModel.
]

{ #category : #'as yet unclassified' }
ClassBox >> addClassMethod: aSelector [ 
	classMethods ifNil:[classMethods := OrderedCollection new].
	(classMethods includes: aSelector) ifFalse:[classMethods  add: aSelector]
]

{ #category : #'as yet unclassified' }
ClassBox >> addMethod: aSelector [ 
	instanceMethods ifNil:[instanceMethods := OrderedCollection new].
	(instanceMethods includes: aSelector) ifFalse:[instanceMethods  add: aSelector]
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
ClassBox >> descriptionCodeForEdition [ 
	^super descriptionCodeForEdition, self relationshipsCode
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

{ #category : #'as yet unclassified' }
ClassBox >> mapsToModel [ 
	^self model notNil
]

{ #category : #'as yet unclassified' }
ClassBox >> model [
	^targetClass ifNil:[Smalltalk at: self name asSymbol ifPresent:[:class | targetClass := class ]]
]

{ #category : #'as yet unclassified' }
ClassBox >> relateIfPossibleTo: aDiagramNode [
	(self mapsToModel and:[aDiagramNode mapsToModel]) ifFalse:[^self].
	aDiagramNode relateIfPossibleToClass: self.
	
]

{ #category : #'as yet unclassified' }
ClassBox >> relateIfPossibleToClass: aClassBox [
	(self model superclass = aClassBox model) ifTrue:[
		self inheritsFrom: aClassBox].
	(aClassBox model superclass = self model) ifTrue:[
		aClassBox inheritsFrom: self].
	
]

{ #category : #'as yet unclassified' }
ClassBox >> relateIfPossibleToTrait: aTraitBox [
	(self model traitCompositionIncludes: aTraitBox model) ifTrue:[
		self usesTrait: aTraitBox].
	
]

{ #category : #accessing }
ClassBox >> subject [
	^targetClass
]

{ #category : #accessing }
ClassBox >> targetClass: anObject [
	targetClass := anObject
]

{ #category : #'as yet unclassified' }
ClassBox >> updateFromModel [
	self
		instanceVariables: self model instVarNames;
		instanceMethods: (self selectorsAsStrings: self model selectors);
		classInstanceVariables: self model class instVarNames;
		classVariables: self model class classVarNames;
		classMethods: (self selectorsAsStrings: self model class selectors)
]

{ #category : #relations }
ClassBox >> updaterClass [
	^ClassBoxUpdater 
]

{ #category : #relations }
ClassBox >> usesA: anotherClassBox [ 
	self addRelationship: (Relationship useRelationshipFrom: self to: anotherClassBox)
]

{ #category : #relations }
ClassBox >> usesLotsOf: anotherClassBox [ 
	self addRelationship: ((Relationship useRelationshipFrom: self to: anotherClassBox) oneToMany: true)
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
