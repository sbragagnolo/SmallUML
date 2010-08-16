Class {
	#name : #ImplementationRelationship,
	#superclass : #Relationship,
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #'as yet unclassified' }
ImplementationRelationship >> arrow [
	^UMLConnection newImplementationAssociation 
]

{ #category : #'as yet unclassified' }
ImplementationRelationship >> selector [
	^' implements: '
]
