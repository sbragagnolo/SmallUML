Class {
	#name : #ClassBoxUpdater,
	#superclass : #ClassBox,
	#traits : 'TDiagramNodeUpdater',
	#classTraits : 'TDiagramNodeUpdater classTrait',
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

{ #category : #'as yet unclassified' }
ClassBoxUpdater >> printString [ 
	^self realDiagramNode printString 
]

{ #category : #accessing }
ClassBoxUpdater >> realDiagramNode [
	^ realBox
]

{ #category : #'as yet unclassified' }
ClassBoxUpdater >> realDiagramNode: anObject [
	realBox := anObject.
	self initializeFrom: anObject 
]

{ #category : #'as yet unclassified' }
ClassBoxUpdater >> relationBetweenRealClassBoxes: aRelation [
	^(aRelation  from: aRelation originDiagramNode realDiagramNode to: aRelation destinationDiagramNode realDiagramNode )
]

{ #category : #'as yet unclassified' }
ClassBoxUpdater >> relationBetweenRealDiagramNodes: aRelation [
	^(aRelation  from: aRelation originDiagramNode realDiagramNode to: aRelation destinationDiagramNode realDiagramNode )
]

{ #category : #'as yet unclassified' }
ClassBoxUpdater >> update [
	"The real class box isn't updated directly because the relations have to be administrated'"
	self updateDefinition.

	(self realRelationships difference: self realDiagramNode relations) do: [:relation | self realDiagramNode addRelationship: (self relationBetweenRealDiagramNodes: relation)].
	(self realDiagramNode relations difference: self realRelationships) do: [:relation | self realDiagramNode removeRelationship: relation].

	
]

{ #category : #'as yet unclassified' }
ClassBoxUpdater >> updateDefinition [ 
	self realDiagramNode instanceMethods: self instanceMethods.
	self realDiagramNode classMethods: self classMethods.
	self realDiagramNode instanceVariables: self instanceVariables.
	self realDiagramNode classInstanceVariables: self classInstanceVariables.
	self realDiagramNode classVariables: self classVariables.
	self realDiagramNode position: self position.

]
