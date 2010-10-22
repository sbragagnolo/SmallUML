Class {
	#name : #ObjectNode,
	#superclass : #DiagramNode,
	#instVars : [
		'object'
	],
	#category : #'SUML-ObjectDiagramModel'
}

{ #category : #'as yet unclassified' }
ObjectNode class >> for: anObject [
	^self new object: anObject 
]

{ #category : #'as yet unclassified' }
ObjectNode >> descriptionCodeForEdition [ 
	^super descriptionCodeForEdition , self relationshipsCode 
]

{ #category : #'as yet unclassified' }
ObjectNode >> hasA: anotherClassBox labeledAs: aLabel [
	self addRelationship: (Relationship associationRelationshipFrom: self to: anotherClassBox labeledAs: aLabel)
]

{ #category : #'as yet unclassified' }
ObjectNode >> nestedObjectNodes [
	^ self object class instVarNames
		inject: OrderedCollection new
		into: [ :objectNodes :instVarName | 
			| newObjectNode |
			(self object instVarNamed: instVarName)
				ifNotNil:[
					newObjectNode := (ObjectNode for: (self object instVarNamed: instVarName)) name: instVarName.
					  newObjectNode withNestedObjectNodes union: objectNodes ] ]
]

{ #category : #accessing }
ObjectNode >> object [
	^ object
]

{ #category : #accessing }
ObjectNode >> object: anObject [
	object := anObject
]

{ #category : #accessing }
ObjectNode >> realDiagramNode [
	^self
]

{ #category : #accessing }
ObjectNode >> updaterClass [
	^ObjectNodeUpdater 
]

{ #category : #'as yet unclassified' }
ObjectNode >> view [
	^ObjectNodeMorph for: self
]

{ #category : #'as yet unclassified' }
ObjectNode >> withNestedObjectNodes [
	^(OrderedCollection with: self)
		addAll: self nestedObjectNodes;
		yourself 
]
