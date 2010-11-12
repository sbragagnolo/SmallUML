Class {
	#name : #DiagramNodeMorph,
	#superclass : #Morph,
	#traits : 'TConnectableShape',
	#classTraits : 'TConnectableShape classTrait',
	#instVars : [
		'container',
		'diagramNode',
		'dragEventHandler'
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
	
	self position: diagramNode position
]

{ #category : #'dragging-dropping' }
DiagramNodeMorph >> initialize [ 
	super initialize.
	dragEventHandler  := DraggingEventHandler new passenger: self.
]

{ #category : #'dragging-dropping' }
DiagramNodeMorph >> justDroppedInto: aMorph event: evt [
	diagramNode position: self position.
	owner updateRelationships.
	self updateBounds.

]

{ #category : #'dragging-dropping' }
DiagramNodeMorph >> mouseDown: evt [
	dragEventHandler startHandleDrag: evt
]

{ #category : #'dragging-dropping' }
DiagramNodeMorph >> mouseMove: evt [
	dragEventHandler handleMove: evt.
	self connectableBounds updateConnectionsLabel
]

{ #category : #'dragging-dropping' }
DiagramNodeMorph >> mouseUp: evt [
	dragEventHandler stopHandleDrag: evt
]

{ #category : #accessing }
DiagramNodeMorph >> relations [ 
	^self connections collect:[:conn | conn target]
]

{ #category : #'as yet unclassified' }
DiagramNodeMorph >> step [
	self updateLayout .
]

{ #category : #'as yet unclassified' }
DiagramNodeMorph >> update: aParameter [
	(aParameter == #position)
		ifTrue: [self position: diagramNode position.
				owner ifNotNil:[ owner updateDescriptionCode].].
]

{ #category : #'as yet unclassified' }
DiagramNodeMorph >> updateLayout [

	self connectableBounds updateLayout.
]

{ #category : #'as yet unclassified' }
DiagramNodeMorph >> wantsToBeDroppedInto: aMorph [
	^aMorph isKindOf: DiagramWhiteboard 
]
