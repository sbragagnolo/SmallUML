Class {
	#name : #DiagramNodeMorph,
	#superclass : #Morph,
	#traits : 'TConnectableShape',
	#classTraits : 'TConnectableShape classTrait',
	#instVars : [
		'container',
		'diagramNode'
	],
	#category : #'SUML-DiagramDrawing'
}

{ #category : #'as yet unclassified' }
DiagramNodeMorph >> adjustPosition [
	(self position = diagramNode position)
		ifTrue:[self position: owner position + diagramNode position]
]

{ #category : #accessing }
DiagramNodeMorph >> connections [ 
	^self connectableBounds connections 
]

{ #category : #'as yet unclassified' }
DiagramNodeMorph >> diagramNode: aDiagramNode [
	diagramNode  := aDiagramNode.
	
	diagramNode  ifNotNil: [diagramNode  removeDependent: self].
	aDiagramNode ifNotNil: [aDiagramNode addDependent: self].
	
	self position: self position.
]

{ #category : #'dragging-dropping' }
DiagramNodeMorph >> handlesMouseDown: evt [
	^true
]

{ #category : #'dragging-dropping' }
DiagramNodeMorph >> justDroppedInto: aMorph event: evt [
	diagramNode position: self position - owner position .
	owner updateRelationships.
	self updateBounds.

]

{ #category : #'dragging-dropping' }
DiagramNodeMorph >> mouseDown: evt [
	evt hand grabMorph: self
]

{ #category : #private }
DiagramNodeMorph >> position [
	^ owner ifNil:[ diagramNode position ] ifNotNil:[ super position]
]

{ #category : #accessing }
DiagramNodeMorph >> relations [ 
	^self connections collect:[:conn | conn target]
]

{ #category : #'as yet unclassified' }
DiagramNodeMorph >> update: aParameter [
	(aParameter == #position)
		ifTrue: [self position: diagramNode position.
				owner ifNotNil:[ self position: self position + owner position. owner updateDescriptionCode].].
]

{ #category : #'as yet unclassified' }
DiagramNodeMorph >> wantsToBeDroppedInto: aMorph [
	^aMorph isKindOf: DiagramWhiteboard  
]
