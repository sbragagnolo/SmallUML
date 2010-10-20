Class {
	#name : #DiagramWhiteboard,
	#superclass : #Morph,
	#instVars : [
		'model',
		'diagramNodes'
	],
	#category : #'SUML-Tools'
}

{ #category : #'as yet unclassified' }
DiagramWhiteboard >> connections [
	^self submorphs inject: OrderedCollection new into:[:rels :box | rels union: box connections ].
]

{ #category : #'as yet unclassified' }
DiagramWhiteboard >> diagram [
	^self model model
]

{ #category : #accessing }
DiagramWhiteboard >> diagramNodeMorphFor: aDiagramNodeDescription [
	^diagramNodes at: aDiagramNodeDescription ifAbsentPut: aDiagramNodeDescription view
]

{ #category : #accessing }
DiagramWhiteboard >> diagramNodeMorphs [
	^ self diagramNodes collect:[:boxDesc | (self diagramNodeMorphFor: boxDesc) diagramNode: boxDesc  ]
]

{ #category : #accessing }
DiagramWhiteboard >> diagramNodes [
	^self model diagramNodes
]

{ #category : #accessing }
DiagramWhiteboard >> displayString [
	^self name
]

{ #category : #'as yet unclassified' }
DiagramWhiteboard >> initialize [
	super initialize.
	self fillStyle: Color white.
	self dropEnabled: true.
]

{ #category : #'as yet unclassified' }
DiagramWhiteboard >> model [ 
	^model 
]

{ #category : #'as yet unclassified' }
DiagramWhiteboard >> model: anObject [
	model ifNotNil: [model removeDependent: self].
	anObject ifNotNil: [.anObject addDependent: self].
	diagramNodes := Dictionary new.
	model := anObject.
	self update.
]

{ #category : #'as yet unclassified' }
DiagramWhiteboard >> update [
	self removeAllMorphs.
	diagramNodes := Dictionary new.
	self diagramNodeMorphs" do: [:classBoxMorph | classBoxMorph updateRelationships  ]".
	diagramNodes keysAndValuesDo: [:classBoxDescription :classBoxMorph | 
		(classBoxDescription relations difference: (classBoxMorph connections)) do:[:relation | 
			relation view fitIntoDiagram:self ]].

	self addAllMorphs: (self diagramNodeMorphs difference: submorphs ). 
	self diagramNodeMorphs do: #adjustPosition.
	self connections do: #updateView.
	self diagramNodeMorphs do: [:classBoxMorph | classBoxMorph updateBounds  ].
	self bounds: self fullBounds.

	
]

{ #category : #'as yet unclassified' }
DiagramWhiteboard >> update: aParameter [
	(aParameter == #view) 
		ifTrue:[self update.].

]

{ #category : #'as yet unclassified' }
DiagramWhiteboard >> updateDescriptionCode [ 
	self model update: #descriptionCode.
]

{ #category : #'as yet unclassified' }
DiagramWhiteboard >> updateRelationships [
	self connections do:[:rel | rel fitIntoDiagram: self].
	self connections do: #updateView.
	self diagramNodeMorphs do: #updateBounds.
]
