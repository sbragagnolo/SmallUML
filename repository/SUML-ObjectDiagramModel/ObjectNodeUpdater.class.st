Class {
	#name : #ObjectNodeUpdater,
	#superclass : #ObjectNode,
	#traits : 'TDiagramNodeUpdater',
	#classTraits : 'TDiagramNodeUpdater classTrait',
	#instVars : [
		'realDiagramNode'
	],
	#category : #'SUML-ObjectDiagramModel'
}

{ #category : #'as yet unclassified' }
ObjectNodeUpdater >> initializeFrom: aDiagramNode [
	self realDiagramNode: aDiagramNode.
	self references: aDiagramNode references.
]

{ #category : #'as yet unclassified' }
ObjectNodeUpdater >> printString [ 
	^self realDiagramNode printString 
]

{ #category : #accessing }
ObjectNodeUpdater >> realDiagramNode [
	^ realDiagramNode
]

{ #category : #accessing }
ObjectNodeUpdater >> realDiagramNode: anObject [
	realDiagramNode := anObject
]

{ #category : #'as yet unclassified' }
ObjectNodeUpdater >> relationBetweenRealDiagramNodes: aRelation [
	^(aRelation  from: aRelation originDiagramNode realDiagramNode to: aRelation destinationDiagramNode realDiagramNode )
]

{ #category : #'as yet unclassified' }
ObjectNodeUpdater >> update [
	"The real class box isn't updated directly because the relations have to be administrated'"
	(self realRelationships difference: self realDiagramNode relations) do: [:relation | self realDiagramNode addRelationship: (self relationBetweenRealDiagramNodes: relation)].
	(self realDiagramNode relations difference: self realRelationships) do: [:relation | self realDiagramNode removeRelationship: relation].

	
]
