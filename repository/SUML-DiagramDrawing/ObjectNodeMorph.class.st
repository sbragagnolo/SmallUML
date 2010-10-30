Class {
	#name : #ObjectNodeMorph,
	#superclass : #DiagramNodeMorph,
	#instVars : [
		'innerReferencesGuide',
		'connectableBounds',
		'label'
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
	self updateLabel.

	self updateLayout.
]

{ #category : #'as yet unclassified' }
ObjectNodeMorph >> drawOn: aCanvas [

	aCanvas asBalloonCanvas
			aaLevel: 4;
			drawOval: (bounds insetBy: self extent) color: self color
				borderWidth: 1 borderColor: Color black.
]

{ #category : #'as yet unclassified' }
ObjectNodeMorph >> initialize [ 
	super initialize.
	self color: Color lightGray.
	self borderColor: Color black.
	self extent: 40+(self connections size* 0.1)@40+(self connections size* 0.1).
	
	container:= CircleMorph new.
	container color: Color transparent.
	container borderColor: Color transparent.
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
ObjectNodeMorph >> updateBounds [
	
]

{ #category : #accessing }
ObjectNodeMorph >> updateLabel [
	label ifNotNil:[self removeMorph: label].
	label := StringMorph new contents: diagramNode label; color: Color white.
	self addMorph: label.
]

{ #category : #'as yet unclassified' }
ObjectNodeMorph >> updateLayout [
	
	container extent: ((label width + 10) max: 30) asPoint.
	label center: self center.
	container center: self center.
	self extent: container extent.
	innerReferencesGuide extent: container extent.
	self connectableBounds updateLayout.
]
