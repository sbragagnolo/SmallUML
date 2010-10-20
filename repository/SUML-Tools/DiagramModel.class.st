Class {
	#name : #DiagramModel,
	#superclass : #UMLToolModel,
	#category : #'SUML-Tools'
}

{ #category : #'as yet unclassified' }
DiagramModel >> bindingErrorBecauseOf: aVariable [
	self subclassResponsibility 
]

{ #category : #'menu-options' }
DiagramModel >> checkBoxName: aBoxName [
	(bindings values anySatisfy: [:box | box name = aBoxName ]) ifTrue:[self error: 'There already exists a box named ', aBoxName ].
	^aBoxName 
]

{ #category : #'menu-options' }
DiagramModel >> deleteNode [
	self model removeDiagramNode: self selectedDiagramNode .
	self selectedIndex: self selectedIndex -1.
	self halt.
	self changed: #selectedIndex.
	self changed: #view.
	self changed: #descriptionCode.

]

{ #category : #'as yet unclassified' }
DiagramModel >> list [
	^self model ifNotNil:[self model diagramNodes]
	 "This should be changed when integrating other kinds of diagrams, doing a double dispatch maybe"
	ifNil:[#()]
]

{ #category : #'as yet unclassified' }
DiagramModel >> model: aModel [
	super model: aModel.

]

{ #category : #'menu-options' }
DiagramModel >> renameNode [
	| newBoxName newVariableName binding |
	newBoxName := self request: ('New name for ', self selectedDiagramNode name) default: ''.
	binding := self bindingOf: self selectedDiagramNode variableNameForDescriptionCode.
	self selectedDiagramNode name: newBoxName.
	binding key: self selectedDiagramNode variableNameForDescriptionCode. 
	self changed.
]

{ #category : #'as yet unclassified' }
DiagramModel >> selectedDescriptionCode [
	^self model descriptionCodeOf: self selectedDiagramNode
]

{ #category : #'as yet unclassified' }
DiagramModel >> selectedDiagramNode [
	^self list at: self selectedIndex ifAbsent:[NullDiagramNode new]
]

{ #category : #'as yet unclassified' }
DiagramModel >> selectedIndex: anIndex [
	anIndex > 0
		ifTrue: [ 
			selectedIndex := anIndex.
			]
]
