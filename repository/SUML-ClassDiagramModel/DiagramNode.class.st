Class {
	#name : #DiagramNode,
	#superclass : #Object,
	#instVars : [
		'position',
		'relations',
		'name'
	],
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #creation }
DiagramNode class >> named: aName [ 
	^self new name: aName  
]

{ #category : #accessing }
DiagramNode >> addDependent: aDependent [
	"should always have one and only one dependent"
	self breakDependents.
	super addDependent: aDependent 
	
]

{ #category : #relations }
DiagramNode >> addRelationship: aRelationship [ 
	self relations add: aRelationship.
]

{ #category : #'as yet unclassified' }
DiagramNode >> connectTo: anotherNode using: aRelationship [
	self addRelationship: (aRelationship from: self to: anotherNode )
]

{ #category : #'description code' }
DiagramNode >> creationAndDefinitionCode [ 
	^self creationCode , self definitionCode 
]

{ #category : #'description code' }
DiagramNode >> creationCode [
	|descriptionCode|
	descriptionCode := WriteStream with: (self variableNameForDescriptionCode, ':= ', self className, ' named: ''', self name,'''.').
	descriptionCode nextPut: Character cr.
	^descriptionCode contents
	
]

{ #category : #'description code' }
DiagramNode >> definitionCode [ 
	|descriptionCode|
	descriptionCode := WriteStream with: ''.
	self writeDefinitionDescriptionOn: descriptionCode.
	descriptionCode nextPut: Character cr.
	self writePositioningDescriptionOn: descriptionCode.
	^descriptionCode contents
	
]

{ #category : #'description code' }
DiagramNode >> descriptionCodeForEdition [ 
	^self definitionCode
]

{ #category : #accessing }
DiagramNode >> name [
	^name 
]

{ #category : #accessing }
DiagramNode >> name: anObject [
	name := anObject
]

{ #category : #drawing }
DiagramNode >> position [
	^position" ifNil:[0@0]"
]

{ #category : #drawing }
DiagramNode >> position: aPoint [ 
	position:= aPoint.
	self changed: #position
]

{ #category : #'as yet unclassified' }
DiagramNode >> printString [ 
	^self name 
]

{ #category : #accessing }
DiagramNode >> relations [
	^relations ifNil:[relations := OrderedCollection new]
]

{ #category : #accessing }
DiagramNode >> relations: aCollection [
	relations := aCollection 
]

{ #category : #'description code' }
DiagramNode >> relationshipsCode [ 
	|descriptionCode|
	descriptionCode := WriteStream with: ''.
	self writeRelationshipsDescriptionOn: descriptionCode.
	^descriptionCode contents
	
]

{ #category : #relations }
DiagramNode >> removeRelationship: aRelationship [ 
	self relations remove: aRelationship 
]

{ #category : #'as yet unclassified' }
DiagramNode >> removeRelationshipsWith: aBox [
	^self relations removeAllSuchThat: [:rel | rel connects: aBox]
]

{ #category : #'description code' }
DiagramNode >> variableNameForDescriptionCode [
	^self name withFirstCharacterDownshifted.
]

{ #category : #'as yet unclassified' }
DiagramNode >> writeDefinitionDescriptionOn: aStream [
	

]

{ #category : #'description code' }
DiagramNode >> writePositioningDescriptionOn: aStream [
	self position ifNotNil:[
		aStream nextPutAll: '"Positioning"'.
		aStream nextPut: Character cr.
		aStream nextPutAll: self variableNameForDescriptionCode, ' position: ', self position asString, '.']
]

{ #category : #'description code' }
DiagramNode >> writeRelationshipsDescriptionOn: aStream [
	self relations ifNotEmpty:[
		aStream nextPut: Character cr; cr.
		aStream nextPutAll: '"Relationships"'.
		self relations ifEmpty: [aStream nextPut: Character cr].
		self relations do:[:relation | aStream nextPut: Character cr. relation writeDescriptionOn: aStream ]
		]
]
