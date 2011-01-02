Class {
	#name : #ClassDiagramNodeEventHandler,
	#superclass : #DiagramNodeEventHandler,
	#classVars : [
		'RelationshipBuilder'
	],
	#category : #'SUML-Tools'
}

{ #category : #accessing }
ClassDiagramNodeEventHandler class >> relationshipBuilder [
	^RelationshipBuilder ifNil:[ self resetRelationshipBuilder ]
	
]

{ #category : #accessing }
ClassDiagramNodeEventHandler class >> resetRelationshipBuilder [
	RelationshipBuilder := RelationshipGraphicBuilder new
	
]

{ #category : #'as yet unclassified' }
ClassDiagramNodeEventHandler >> doubleClick: evt [
	self relationshipBuilder addToRelationship: self passenger from: self event: evt.
	

]

{ #category : #'as yet unclassified' }
ClassDiagramNodeEventHandler >> mouseDown: evt [
	evt yellowButtonPressed
		ifTrue: [ self showActionsMenu ]
		ifFalse: [ super mouseDown: evt. ].
	evt hand
		waitForClicksOrDrag: self passenger
		event: evt
		selectors: {nil. #doubleClick: . nil . nil}
		threshold: 10
]

{ #category : #accessing }
ClassDiagramNodeEventHandler >> relationshipBuilder [
	^self class relationshipBuilder 
]

{ #category : #'as yet unclassified' }
ClassDiagramNodeEventHandler >> resetRelationshipBuilder [
	self class resetRelationshipBuilder.
]

{ #category : #'as yet unclassified' }
ClassDiagramNodeEventHandler >> showActionsMenu [
	| menu |
	menu := MenuMorph new.
	menu addTitle: self passenger diagramNode name.
	menu addStayUpItem.
	menu target: (DiagramNodeManager for: self passenger).
	menu add: 'Delete' action: #delete.
	menu add: 'Rename' action: #rename.
	Smalltalk at: self passenger diagramNode name asSymbol 
		ifPresent:[:class | menu add: 'Browse' action: #browse.].

	menu popUpInWorld.
]
