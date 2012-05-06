Class {
	#name : #InheritanceDiagramBuilder,
	#superclass : #Object,
	#instVars : [
		'diagram',
		'levels',
		'classesPerLevel'
	],
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #'as yet unclassified' }
InheritanceDiagramBuilder >> addDiagramNodesForClassAndSubclasses: aClass atLevel: aLevel [
	diagram addDiagramNode: (self newDiagramNodeForClass: aClass atLevel: aLevel).
	
	aClass subclasses do:[:aSubclass |
		self addDiagramNodesForClassAndSubclasses: aSubclass atLevel: aLevel + 1]
	
]

{ #category : #'as yet unclassified' }
InheritanceDiagramBuilder >> availablePositionAtLevel: aLevel [
	^levels at: aLevel ifAbsentPut: (10@(self yPositionForLevel: aLevel))
]

{ #category : #'as yet unclassified' }
InheritanceDiagramBuilder >> buildForClass: aClass [
	classesPerLevel at: 0 put: {aClass}.
	self completeLevel: 1 fromClass: aClass.
	self addDiagramNodesForClassAndSubclasses: aClass atLevel: 0.
	self completeRelationshipsFor: aClass.
	^diagram 
]

{ #category : #'as yet unclassified' }
InheritanceDiagramBuilder >> completeLevel: aLevel fromClass: aClass [
	classesPerLevel at: aLevel put: aClass subclasses.
	aClass subclasses do:[:subclass | self completeLevel: (aLevel + 1) fromClass: subclass].
]

{ #category : #'as yet unclassified' }
InheritanceDiagramBuilder >> completeRelationshipsFor: aClass [
	aClass subclasses do:[:subclass | (diagram diagramNodeFor: subclass ) inheritsFromClass: (diagram diagramNodeFor: aClass).
		self completeRelationshipsFor: subclass]
]

{ #category : #'as yet unclassified' }
InheritanceDiagramBuilder >> initialize [ 
	diagram := ClassDiagram new.
	levels := Dictionary new.
	classesPerLevel := Dictionary new.
]

{ #category : #'as yet unclassified' }
InheritanceDiagramBuilder >> newDiagramNodeForClass: aClass atLevel: aLevel [
	|box|
	box := (ClassBox fromClass: aClass).
	box position: (self availablePositionAtLevel: aLevel ).
	self nextPositionAtLevel: aLevel willBe: (self availablePositionAtLevel: aLevel ) + ((box view width + 20) @ 0).
	
^box
]

{ #category : #'as yet unclassified' }
InheritanceDiagramBuilder >> nextPositionAtLevel: aLevel willBe: aPosition [
	levels at: aLevel put: aPosition 
]

{ #category : #'as yet unclassified' }
InheritanceDiagramBuilder >> yPositionForLevel: aLevel [
	(aLevel = 0) ifTrue:[^10].
	 ^((classesPerLevel at: aLevel - 1) inject: 0 into:[:maxHeight :aClass | maxHeight max: (ClassBox fromClass: aClass) view fullBounds height]) + 30 + (self yPositionForLevel: aLevel - 1).
]
