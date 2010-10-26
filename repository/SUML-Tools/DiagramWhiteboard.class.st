Class {
	#name : #DiagramWhiteboard,
	#superclass : #Morph,
	#instVars : [
		'model',
		'diagramNodes'
	],
	#category : #'SUML-Tools'
}

{ #category : #positioning }
DiagramWhiteboard >> availablePositions [
	^ (self positionedDiagramNodes 
		ifEmpty: [ Set with: "self center" 50@50 ] 
		ifNotEmpty: [self positionedDiagramNodes	inject: OrderedCollection new into:[:points :node | points union: (self neighborsFor: node position) ]
			])
			 select:[:point | self diagramNodes allSatisfy: [:node | node position ~= point]]
]

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
	self extent: 500@500
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

]

{ #category : #positioning }
DiagramWhiteboard >> neighborsFor: aPoint [ 
|delta|
delta := 150.

	^ (Array with: aPoint + (delta @ 0)
		with: aPoint + (0 @ delta)
		with: aPoint - (delta @ 0)
		with: aPoint - (0 @ delta)) select:[:point | self containsPoint: point + self position]

]

{ #category : #'as yet unclassified' }
DiagramWhiteboard >> positionDiagramNodes [
|bannedPositions|
bannedPositions := Set new.
	self diagramNodes do:[:node |
		node position ifNil:[
			self positionNode: node.
"			[((self positionedDiagramNodes reject:[:n | n = node]) anySatisfy: [:n| n view intersects: node view bounds])] whileTrue:
				[bannedPositions add: node position.
						self positionNode: node]"]]
]

{ #category : #positioning }
DiagramWhiteboard >> positionNode: aNode [
	aNode position: self availablePositions anyOne.
]

{ #category : #positioning }
DiagramWhiteboard >> positionedDiagramNodes [
	^self diagramNodes select:[:node | node position notNil]
]

{ #category : #'as yet unclassified' }
DiagramWhiteboard >> update [
	self removeAllMorphs.
	diagramNodes := Dictionary new.
	self positionDiagramNodes.
	self diagramNodeMorphs" do: [:classBoxMorph | classBoxMorph updateRelationships  ]".
	diagramNodes keysAndValuesDo: [:classBoxDescription :classBoxMorph | 
		(classBoxDescription relations difference: (classBoxMorph connections)) do:[:relation | 
			relation view fitIntoDiagram:self ]].

	self addAllMorphs: (self diagramNodeMorphs difference: submorphs ). 
	self diagramNodeMorphs do: #adjustPosition.
	self connections do: #updateView.
	self diagramNodeMorphs do: [:classBoxMorph | classBoxMorph updateBounds  ].
	owner ifNil:[self bounds: self fullBounds] ifNotNil:[self bounds: owner bounds].

	
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
