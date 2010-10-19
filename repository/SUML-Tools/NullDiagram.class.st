Class {
	#name : #NullDiagram,
	#superclass : #Object,
	#category : #'SUML-Tools'
}

{ #category : #accessing }
NullDiagram >> classBoxes [
	^#()
]

{ #category : #accessing }
NullDiagram >> descriptionCodeOf: aClassDescription [
	^String empty
]

{ #category : #accessing }
NullDiagram >> diagramNodes [
	^#()
]

{ #category : #'as yet unclassified' }
NullDiagram >> name [
	^'(No diagrams)'
]

{ #category : #'as yet unclassified' }
NullDiagram >> update [
]
