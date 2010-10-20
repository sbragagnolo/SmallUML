Class {
	#name : #InterfaceAndTraitBoxUpdater,
	#superclass : #InterfaceBox,
	#traits : 'TDiagramNodeUpdater',
	#classTraits : 'TDiagramNodeUpdater classTrait',
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

{ #category : #'as yet unclassified' }
InterfaceAndTraitBoxUpdater >> printString [ 
	^self realDiagramNode printString 
]

{ #category : #accessing }
InterfaceAndTraitBoxUpdater >> realDiagramNode [
	^ realBox
]

{ #category : #'as yet unclassified' }
InterfaceAndTraitBoxUpdater >> realDiagramNode: anObject [
	realBox := anObject.
	self initializeFrom: anObject 
]

{ #category : #'as yet unclassified' }
InterfaceAndTraitBoxUpdater >> relationBetweenRealClassBoxes: aRelation [
	^(aRelation  from: aRelation originDiagramNode realDiagramNode to: aRelation destinationDiagramNode realDiagramNode )
]

{ #category : #'as yet unclassified' }
InterfaceAndTraitBoxUpdater >> relationBetweenRealDiagramNodes: aRelation [
	^(aRelation  from: aRelation origin realDiagramNode to: aRelation destinationDiagramNode realDiagramNode )
]

{ #category : #'as yet unclassified' }
InterfaceAndTraitBoxUpdater >> relations: aCollection [
	relations := aCollection 
]

{ #category : #'as yet unclassified' }
InterfaceAndTraitBoxUpdater >> update [
	"The real class box isn't updated directly because the relations have to be administrated'"
	self updateDefinition.

	(self realRelationships difference: self realDiagramNode relations) do: [:relation | self realDiagramNode addRelationship: (self relationBetweenRealDiagramNodes: relation)].
	(self realDiagramNode relations difference: self realRelationships) do: [:relation | self realDiagramNode removeRelationship: relation].

	
]

{ #category : #'as yet unclassified' }
InterfaceAndTraitBoxUpdater >> updateDefinition [
	self realDiagramNode instanceMethods: self instanceMethods.
	self realDiagramNode classMethods: self classMethods.
	self realDiagramNode position: self position.
]
