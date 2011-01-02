Class {
	#name : #RelationshipGraphicBuilder,
	#superclass : #Object,
	#instVars : [
		'origin',
		'destination',
		'originIndicatorMorph'
	],
	#category : #'SUML-Tools'
}

{ #category : #'as yet unclassified' }
RelationshipGraphicBuilder >> addToRelationship: aDiagramNodeMorph from: aDiagramNodeEventHandler event: evt [
	origin 
		ifNil:[origin := aDiagramNodeMorph.
			originIndicatorMorph :=  (CircleMorph new borderWidth: 0; color: (Color red alpha: 0.5); center: evt position).
			aDiagramNodeMorph owner addMorph: originIndicatorMorph  ]
		ifNotNil: [destination := aDiagramNodeMorph.
				self createRelationship.
				aDiagramNodeEventHandler resetRelationshipBuilder.
				originIndicatorMorph delete.]
	
]

{ #category : #'as yet unclassified' }
RelationshipGraphicBuilder >> createRelationship [
	self showActionsMenu.
	
]

{ #category : #'as yet unclassified' }
RelationshipGraphicBuilder >> initialize [ 
	 
]

{ #category : #'as yet unclassified' }
RelationshipGraphicBuilder >> newAssociation [
	| label |
	label := self request: 'label' default: ''.
	origin diagramNode hasA: destination diagramNode labeledAs: label.
]

{ #category : #'as yet unclassified' }
RelationshipGraphicBuilder >> newCollectionAssociation [
	| label |
	label := self request: 'label' default: ''.
	origin diagramNode hasLotsOf: destination diagramNode labeledAs: label.
]

{ #category : #'as yet unclassified' }
RelationshipGraphicBuilder >> newCollectionUse [
	origin diagramNode usesLotsOf: destination diagramNode .

]

{ #category : #'as yet unclassified' }
RelationshipGraphicBuilder >> newImplementation [
	origin diagramNode implements: destination diagramNode .

]

{ #category : #'as yet unclassified' }
RelationshipGraphicBuilder >> newInheritance [
	origin diagramNode inheritsFrom: destination diagramNode .

]

{ #category : #'as yet unclassified' }
RelationshipGraphicBuilder >> newUse [
	origin diagramNode usesA: destination diagramNode .

]

{ #category : #'as yet unclassified' }
RelationshipGraphicBuilder >> newUseTrait [
	origin diagramNode usesTrait: destination diagramNode .

]

{ #category : #accessing }
RelationshipGraphicBuilder >> origin: aDiagramNodeMorph [
	origin := aDiagramNodeMorph diagramNode
]

{ #category : #'as yet unclassified' }
RelationshipGraphicBuilder >> request: aTitle default: aDefaultValue [
	^UIManager default
		request: aTitle
		initialAnswer: aDefaultValue
]

{ #category : #'as yet unclassified' }
RelationshipGraphicBuilder >> showActionsMenu [
	| menu |
	menu := MenuMorph new.
	menu addTitle: 'New Relationship'.
	menu addStayUpItem.
	menu target: self.
	menu add: 'Association' action: #newAssociation.
	menu add: 'Association *' action: #newCollectionAssociation.
	menu add: 'Inheritance' action: #newInheritance.
	menu add: 'Implementation' action: #newImplementation.
	menu add: 'Use' action: #newUse.
	menu add: 'Use *' action: #newCollectionUse.
	menu add: 'Use of Trait' action: #newUseTrait.
	
	menu popUpInWorld.
]
