Class {
	#name : #RelationshipManager,
	#superclass : #ActionsManager,
	#category : #'SUML-Tools'
}

{ #category : #'as yet unclassified' }
RelationshipManager >> delete [
	self model removeFromDiagram.
]

{ #category : #'as yet unclassified' }
RelationshipManager >> relationship [
	^self model
]

{ #category : #'as yet unclassified' }
RelationshipManager >> rename [
	| newLabel  |
	newLabel := self request: ('New label for ', self relationship label) default: ''.
	self relationship label: newLabel.
	self relationship originDiagramNode changed: #view.
	
]
