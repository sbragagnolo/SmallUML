Class {
	#name : #UseTraitRelationship,
	#superclass : #Relationship,
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #'as yet unclassified' }
UseTraitRelationship >> arrow [
	^UMLConnection newTraitsUse 
]

{ #category : #'as yet unclassified' }
UseTraitRelationship >> selector [
	^'usesTrait:'
]
