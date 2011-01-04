Class {
	#name : #DiagramNodeManager,
	#superclass : #ActionsManager,
	#category : #'SUML-Tools'
}

{ #category : #'as yet unclassified' }
DiagramNodeManager >> addClassInstanceVariables [
	self diagramNode classInstanceVariables: #('(Add class instance variables here)').
]

{ #category : #'as yet unclassified' }
DiagramNodeManager >> addClassMethods [
	self diagramNode classMethods: #('(Add class methods here)').
]

{ #category : #'as yet unclassified' }
DiagramNodeManager >> addClassVariables [
	self diagramNode classVariables: #('(Add class variables here)').
]

{ #category : #'as yet unclassified' }
DiagramNodeManager >> addInstanceMethods [
	self diagramNode instanceMethods: #('(Add instance methods here)').
]

{ #category : #'as yet unclassified' }
DiagramNodeManager >> addInstanceVariables [
	self diagramNode instanceVariables: #('(Add instance variables here)').
]

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
	((newBoxName := self request: ('New name for ', self diagramNode name) default: self diagramNode name asString)
		isNil or: [newBoxName isEmpty]) ifTrue: [^self].
	"binding := self bindingOf: self diagramNode variableNameForDescriptionCode."
	self diagramNode name: newBoxName.
	"binding key: self diagramNode variableNameForDescriptionCode. "
	self diagramNode changed: #title.
	self model changed: #descriptionCode.
	self diagram update: #view.
]

{ #category : #'as yet unclassified' }
DiagramNodeManager >> updateFromModel [
	self diagramNode updateFromModel.
	self diagram relateDiagramNode: self diagramNode.
]
