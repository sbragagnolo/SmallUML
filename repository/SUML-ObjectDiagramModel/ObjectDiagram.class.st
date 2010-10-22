Class {
	#name : #ObjectDiagram,
	#superclass : #Diagram,
	#category : #'SUML-ObjectDiagramModel'
}

{ #category : #'as yet unclassified' }
ObjectDiagram class >> fromObject: anObject [
	^self new buildGraphFromObject: anObject 
]

{ #category : #'as yet unclassified' }
ObjectDiagram >> buildGraphFromObject: anObject [
	"This doesn't work OK yet'"
	self diagramNodes: ((ObjectNode for: anObject ) name: 'first') withNestedObjectNodes 
]

{ #category : #drawing }
ObjectDiagram >> objectNodesMorphs [
	^self objectNodes collect:[:objectNode | ObjectNodeMorph for: objectNode ]
]

{ #category : #drawing }
ObjectDiagram >> openView [
	^self objectNodesMorphs do:[:objectNodeMorph | objectNodeMorph openInWorld ]
]
