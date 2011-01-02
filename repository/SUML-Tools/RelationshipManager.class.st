Class {
	#name : #RelationshipManager,
	#superclass : #ActionsManager,
	#category : #'SUML-Tools'
}

{ #category : #'as yet unclassified' }
RelationshipManager >> delete [
	self model removeFromDiagram.
]
