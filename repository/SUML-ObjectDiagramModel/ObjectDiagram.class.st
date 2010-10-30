Class {
	#name : #ObjectDiagram,
	#superclass : #Diagram,
	#category : #'SUML-ObjectDiagramModel'
}

{ #category : #'as yet unclassified' }
ObjectDiagram >> connectNodes [
	self diagramNodes do:[:node | node connectToReferencesWithin: self]
]

{ #category : #drawing }
ObjectDiagram >> objectNodesMorphs [
	^self objectNodes collect:[:objectNode | ObjectNodeMorph for: objectNode ]
]

{ #category : #'as yet unclassified' }
ObjectDiagram >> objects [
	^self diagramNodes collect:[:diagramNode | diagramNode object]
]

{ #category : #drawing }
ObjectDiagram >> openView [
	^self objectNodesMorphs do:[:objectNodeMorph | objectNodeMorph openInWorld ]
]

{ #category : #'as yet unclassified' }
ObjectDiagram >> resetConnections [
	self diagramNodes do:[:node | node resetConnections]
]

{ #category : #'as yet unclassified' }
ObjectDiagram >> updateDiagramNodesFrom: aCollection [
	(aCollection copyWithoutAll: self objects) do:[:anObject | self addDiagramNode: (ObjectNode for: anObject  )].
	(self objects copyWithoutAll: aCollection) do:[:anObject | self removeDiagramNode: (self diagramNodeFor: anObject)].
	
]
