Class {
	#name : #Relationship,
	#superclass : #Object,
	#instVars : [
		'classBoxOrigin',
		'classBoxDestination',
		'label'
	],
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #creation }
Relationship class >> associationRelationshipFrom: aClassBox to: anotherClassBox labeledAs: aLabel [
	^(AssociationRelationship from: aClassBox to: anotherClassBox) label: aLabel  
]

{ #category : #creation }
Relationship class >> from: aClassBox to: aClassBox2 [ 
	^self new from: aClassBox to: aClassBox2 
]

{ #category : #creation }
Relationship class >> implementationRelationshipFrom: aClassBox to: anotherClassBox [
	^ImplementationRelationship  from: aClassBox to: anotherClassBox
]

{ #category : #creation }
Relationship class >> inheritanceRelationshipFrom: aClassBox to: anotherClassBox [
	^InheritanceRelationship from: aClassBox to: anotherClassBox
]

{ #category : #creation }
Relationship class >> useRelationshipFrom: aClassBox to: anotherClassBox labeledAs: aLabel [
	^(UseRelationship from: aClassBox to: anotherClassBox) label: aLabel  
]

{ #category : #creation }
Relationship class >> useTraitRelationshipFrom: aClassBox to: anotherClassBox [
	^UseTraitRelationship  from: aClassBox to: anotherClassBox
]

{ #category : #'as yet unclassified' }
Relationship >> = anotherRelation [
	^(self class = anotherRelation class) and:[self originDiagramNode = anotherRelation originDiagramNode and:[self destinationDiagramNode = anotherRelation destinationDiagramNode  and:[self label = anotherRelation label and:[self oneToMany = anotherRelation oneToMany ]] ]]
]

{ #category : #'as yet unclassified' }
Relationship >> arrow [
	^self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
Relationship >> connects: aBox [
	^self destinationDiagramNode = aBox or:[self originDiagramNode = aBox ]
]

{ #category : #accessing }
Relationship >> destinationDiagramNode [
	^ classBoxDestination
]

{ #category : #accessing }
Relationship >> from: aClassBox to: aClassBox2 [ 
	classBoxOrigin := aClassBox.
	classBoxDestination := aClassBox2 
]

{ #category : #'as yet unclassified' }
Relationship >> hash [
	^(self class hash bitXor: ((self originDiagramNode hash bitXor: (self destinationDiagramNode hash bitXor: self oneToMany hash)) bitXor: self label hash))
]

{ #category : #accessing }
Relationship >> label [
	^ label
]

{ #category : #accessing }
Relationship >> label: anObject [
	label := anObject
]

{ #category : #associating }
Relationship >> oneToMany [
	^false
]

{ #category : #accessing }
Relationship >> originDiagramNode [
	^ classBoxOrigin
]

{ #category : #'as yet unclassified' }
Relationship >> view [
	^self arrow lineWidth: 2; target: self
]

{ #category : #'as yet unclassified' }
Relationship >> writeDescriptionOn: aStream [
	aStream nextPutAll: self originDiagramNode variableNameForDescriptionCode , ' ', self selector , self destinationDiagramNode variableNameForDescriptionCode, '.'.
]
