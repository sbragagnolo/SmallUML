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
DiagramNodeMorph >> diagramNode [
	^diagramNode 
]

{ #category : #'as yet unclassified' }
DiagramNodeMorph >> diagramNode: aDiagramNode [
	diagramNode  := aDiagramNode.
	
	diagramNode  ifNotNil: [diagramNode  removeDependent: self].
	aDiagramNode ifNotNil: [aDiagramNode addDependent: self].
	
	self position: diagramNode position
]

{ #category : #'as yet unclassified' }
DiagramNodeMorph >> dragEventHandler [ 
	^dragEventHandler 
]

{ #category : #'dragging-dropping' }
DiagramNodeMorph >> initialize [ 
	super initialize.
	dragEventHandler  := DraggingEventHandler new passenger: self.
]

{ #category : #accessing }
DiagramNodeMorph >> relations [ 
	^self connections collect:[:conn | conn target]
]

{ #category : #updating }
DiagramNodeMorph >> resetBoundings [
	self connectableBounds resetConnectionPoints
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
