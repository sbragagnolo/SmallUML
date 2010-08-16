Class {
	#name : #AssociationRelationship,
	#superclass : #InstanceRelationship,
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #accessing }
AssociationRelationship >> arrow [
	^UMLConnection newInstanceAssociation
]

{ #category : #'as yet unclassified' }
AssociationRelationship >> selector [
	^self oneToMany ifTrue:['hasLotsOf:'] ifFalse:['hasA:']
]
