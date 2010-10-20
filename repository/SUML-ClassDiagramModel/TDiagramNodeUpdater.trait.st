Trait {
	#name : #TDiagramNodeUpdater,
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #'as yet unclassified' }
TDiagramNodeUpdater >> clearRelationships [
	self relations: OrderedCollection new.
]

{ #category : #'as yet unclassified' }
TDiagramNodeUpdater >> printString [ 
	^self realBox printString 
]

{ #category : #'as yet unclassified' }
TDiagramNodeUpdater >> realRelationships [
	^self relations collect:[:rel | self relationBetweenRealDiagramNodes: rel]
]

{ #category : #'as yet unclassified' }
TDiagramNodeUpdater >> relationBetweenRealDiagramNodes: aRelation [
	^(aRelation  from: aRelation originDiagramNode realBox to: aRelation destinationDiagramNode realBox )
]

{ #category : #'as yet unclassified' }
TDiagramNodeUpdater >> relations: aCollection [
	relations := aCollection 
]

{ #category : #'as yet unclassified' }
TDiagramNodeUpdater >> update [
	"The real class box isn't updated directly because the relations have to be administrated'"
	self updateDefinition.

	(self realRelationships difference: self realDiagramNode relations) do: [:relation | self realDiagramNode addRelationship: (self relationBetweenRealDiagramNodes: relation)].
	(self realDiagramNode  relations difference: self realRelationships) do: [:relation | self realDiagramNode removeRelationship: relation].

	
]
