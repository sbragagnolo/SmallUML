Class {
	#name : #ReferenceRelationship,
	#superclass : #AssociationRelationship,
	#category : #'SUML-ObjectDiagramModel'
}

{ #category : #'as yet unclassified' }
ReferenceRelationship >> arrow [
	^ReferenceConnection newReference
]
