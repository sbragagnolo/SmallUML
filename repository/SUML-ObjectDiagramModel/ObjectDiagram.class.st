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

{ #category : #drawing }
ObjectDiagram >> openView [
	^self objectNodesMorphs do:[:objectNodeMorph | objectNodeMorph openInWorld ]
]
