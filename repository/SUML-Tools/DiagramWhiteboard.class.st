Class {
	#name : #DiagramWhiteboard,
	#superclass : #Morph,
	#instVars : [
		'classBoxes',
		'model'
	],
	#category : #'SUML-Tools'
}

{ #category : #accessing }
DiagramWhiteboard >> boxMorphFor: aClassBoxDescription [ 
	^classBoxes at: aClassBoxDescription ifAbsentPut: aClassBoxDescription view
]

{ #category : #accessing }
DiagramWhiteboard >> boxMorphs [
	^ self boxes collect:[:boxDesc | (self boxMorphFor: boxDesc) boxModel: boxDesc  ]
]

{ #category : #accessing }
DiagramWhiteboard >> boxes [
	^self diagram boxes 
]

{ #category : #'as yet unclassified' }
DiagramWhiteboard >> diagram [
	^self model model
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
	anObject ifNotNil: [anObject addDependent: self].
	classBoxes := Dictionary new.
	model := anObject.
	self update.
]

{ #category : #'as yet unclassified' }
DiagramWhiteboard >> relationships [
	^self submorphs inject: OrderedCollection new into:[:rels :box | rels union: box connections ].
]

{ #category : #'as yet unclassified' }
DiagramWhiteboard >> update [
	self removeAllMorphs.
	classBoxes := Dictionary new.
	self boxMorphs" do: [:classBoxMorph | classBoxMorph updateRelationships  ]".
	classBoxes keysAndValuesDo: [:classBoxDescription :classBoxMorph | 
		(classBoxDescription relations difference: (classBoxMorph relations)) do:[:relation | 
			relation view fitIntoDiagram:self ]].

	self addAllMorphs: (self boxMorphs difference: submorphs ). 
	self boxMorphs do: #adjustPosition.
	self relationships do: #updateView.
	self boxMorphs do: [:classBoxMorph | classBoxMorph updateBounds  ].
	self bounds: self fullBounds.

	
]

{ #category : #'as yet unclassified' }
DiagramWhiteboard >> update: aParameter [
	(aParameter == #view) 
		ifTrue:[self update].

]

{ #category : #'as yet unclassified' }
DiagramWhiteboard >> updateDescriptionCode [ 
	self model update: #descriptionCode.
]

{ #category : #'as yet unclassified' }
DiagramWhiteboard >> updateRelationships [
	self relationships do:[:rel | rel fitIntoDiagram: self].
	self relationships do: #updateView.
	self boxMorphs do: #updateBounds.
]
