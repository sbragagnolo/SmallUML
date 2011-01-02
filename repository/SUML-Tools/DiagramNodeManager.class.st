Class {
	#name : #DiagramNodeManager,
	#superclass : #ActionsManager,
	#category : #'SUML-Tools'
}

{ #category : #'as yet unclassified' }
DiagramNodeManager >> browse [
	|aClass|
	aClass := Smalltalk at: self diagramNode name asSymbol.
	ToolSet browse: aClass selector: nil
]

{ #category : #actions }
DiagramNodeManager >> delete [
	self diagram removeDiagramNode: self diagramNode .
]

{ #category : #accessing }
DiagramNodeManager >> diagram [
	^self model owner diagram
]

{ #category : #accessing }
DiagramNodeManager >> diagramNode [
	^ model diagramNode
]

{ #category : #actions }
DiagramNodeManager >> rename [
	| newBoxName newVariableName binding |
	newBoxName := self request: ('New name for ', self diagramNode name) default: ''.
	"binding := self bindingOf: self diagramNode variableNameForDescriptionCode."
	self diagramNode name: newBoxName.
	"binding key: self diagramNode variableNameForDescriptionCode. "
	self diagramNode changed: #title.
	self model changed: #descriptionCode.
	self diagram update: #view.
]
