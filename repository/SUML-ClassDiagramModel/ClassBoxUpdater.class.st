Class {
	#name : #ClassBoxUpdater,
	#superclass : #ClassBox,
	#traits : 'TBoxUpdater',
	#classTraits : 'TBoxUpdater classTrait',
	#instVars : [
		'realBox'
	],
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #accessing }
ClassBoxUpdater >> initializeFrom: anObject [ 
	self boxTitle: anObject boxTitle.
	self instanceMethods: anObject instanceMethods.
	self instanceVariables: anObject instanceVariables.
	self classInstanceVariables: anObject classInstanceVariables.
	self classVariables: anObject classVariables.
	self classMethods: anObject classMethods.
	self position: anObject position.
]

{ #category : #accessing }
ClassBoxUpdater >> realBox [
	^ realBox
]

{ #category : #'as yet unclassified' }
ClassBoxUpdater >> relationBetweenRealClassBoxes: aRelation [
	^(aRelation  from: aRelation originBox realBox to: aRelation destinationBox realBox )
]

{ #category : #'as yet unclassified' }
ClassBoxUpdater >> updateBoxDefinition [ 
	self realBox instanceMethods: self instanceMethods.
	self realBox classMethods: self classMethods.
	self realBox instanceVariables: self instanceVariables.
	self realBox classInstanceVariables: self classInstanceVariables.
	self realBox classVariables: self classVariables.
	self realBox position: self position.

]
