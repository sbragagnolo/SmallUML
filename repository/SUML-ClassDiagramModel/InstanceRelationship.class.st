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
	aStream nextPutAll: self originBox variableNameForDescriptionCode , ' ', self selector , self destinationBox variableNameForDescriptionCode , ' labeledAs: ''', self label , '''.'.
]
