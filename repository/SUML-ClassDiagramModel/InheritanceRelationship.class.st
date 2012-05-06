Class {
	#name : #InheritanceRelationship,
	#superclass : #Relationship,
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #'as yet unclassified' }
InheritanceRelationship >> arrow [
	^UMLConnection newInheritanceAssociation
]

{ #category : #'as yet unclassified' }
InheritanceRelationship >> selector [
	^' inheritsFromClass: '
]
