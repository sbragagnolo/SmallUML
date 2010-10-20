Class {
	#name : #ObjectNodeMorph,
	#superclass : #DiagramNodeMorph,
	#instVars : [
		'innerReferencesGuide',
		'connectableBounds'
	],
	#category : #'SUML-DiagramDrawing'
}

{ #category : #'as yet unclassified' }
ObjectNodeMorph class >> for: anObjectNode [
	^self new diagramNode: anObjectNode 
]

{ #category : #'as yet unclassified' }
ObjectNodeMorph >> connectableBounds [ 
	^connectableBounds ifNil:[connectableBounds:= ConnectableBoundingCircle new.]
]

{ #category : #accessing }
ObjectNodeMorph >> diagramNode: anObjectNode [ 
	super diagramNode: anObjectNode.
	self updateLayout.
]

{ #category : #'as yet unclassified' }
ObjectNodeMorph >> initialize [ 
	super initialize.
	self color: Color transparent.
	self borderColor: Color transparent.
	self extent: 40+(self connections size* 0.1)@40+(self connections size* 0.1).
	
	container:= CircleMorph new.
	container color: Color gray.
	container borderColor: Color black.
	container extent: self extent.
	container center: self center.
	
	innerReferencesGuide := ConnectableBoundingCircle new.
	innerReferencesGuide extent: 30@30.
	innerReferencesGuide center: self center.
	innerReferencesGuide color: Color transparent.
	innerReferencesGuide borderColor: Color transparent.
	
	self addMorph: self connectableBounds.
	self addMorph: container.
	self addMorph: innerReferencesGuide.

]

{ #category : #'as yet unclassified' }
ObjectNodeMorph >> step [
	self updateLayout 
]

{ #category : #'as yet unclassified' }
ObjectNodeMorph >> updateBounds [
	
]

{ #category : #'as yet unclassified' }
ObjectNodeMorph >> updateLayout [
	self connectableBounds updateLayout.
	container center: self center.
]
