Class {
	#name : #InstanceRelationship,
	#superclass : #Relationship,
	#instVars : [
		'oneToMany'
	],
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #accessing }
InstanceRelationship >> oneToMany [
	^ oneToMany ifNil:[false]
]

{ #category : #accessing }
InstanceRelationship >> oneToMany: aBoolean [
	oneToMany := aBoolean
]

{ #category : #'as yet unclassified' }
InstanceRelationship >> writeDescriptionOn: aStream [
	aStream nextPutAll: self originDiagramNode variableNameForDescriptionCode , ' ', self selector , self destinationDiagramNode variableNameForDescriptionCode , ' labeledAs: ''', self label , '''.'.
]
