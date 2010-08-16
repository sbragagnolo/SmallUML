Class {
	#name : #InterfaceAndTraitBoxUpdater,
	#superclass : #InterfaceBox,
	#traits : 'TBoxUpdater',
	#classTraits : 'TBoxUpdater classTrait',
	#instVars : [
		'realBox'
	],
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #initializing }
InterfaceAndTraitBoxUpdater >> initializeFrom: anObject [ 
	self boxTitle: anObject boxTitle.
	self instanceMethods: anObject instanceMethods.
	self classMethods: anObject classMethods.
	self position: anObject position.
]

{ #category : #accessing }
InterfaceAndTraitBoxUpdater >> realBox [
	^ realBox
]

{ #category : #'as yet unclassified' }
InterfaceAndTraitBoxUpdater >> relationBetweenRealClassBoxes: aRelation [
	^(aRelation  from: aRelation originBox realBox to: aRelation destinationBox realBox )
]

{ #category : #'as yet unclassified' }
InterfaceAndTraitBoxUpdater >> relations: aCollection [
	relations := aCollection 
]

{ #category : #'as yet unclassified' }
InterfaceAndTraitBoxUpdater >> updateBoxDefinition [
	self realBox instanceMethods: self instanceMethods.
	self realBox classMethods: self classMethods.
	self realBox position: self position.
]
