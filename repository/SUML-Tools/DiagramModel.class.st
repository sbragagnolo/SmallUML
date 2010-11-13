Class {
	#name : #DiagramModel,
	#superclass : #UMLToolModel,
	#instVars : [
		'bindings'
	],
	#category : #'SUML-Tools'
}

{ #category : #'as yet unclassified' }
DiagramModel >> bindingErrorBecauseOf: aVariable [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
DiagramModel >> bindingOf: aString [
	^bindings associationAt: aString ifAbsent:[self error: (self model bindingErrorBecauseOf: aString ) ].
]

{ #category : #'menu-options' }
DiagramModel >> checkBoxName: aBoxName [
	(bindings values anySatisfy: [:box | box name = aBoxName ]) ifTrue:[self error: 'There already exists a diagram node named ', aBoxName ].
	^aBoxName 
]

{ #category : #'menu-options' }
DiagramModel >> deleteNode [
	self model removeDiagramNode: self selectedDiagramNode .
	self selectedIndex: self selectedIndex -1.
	self changed: #descriptionCode.
	self changed: #selectedIndex.
	self changed: #view.
	

]

{ #category : #'as yet unclassified' }
DiagramModel >> hasBindingOf: aString [
	^(bindings notNil and: [bindings includesKey: aString])
]

{ #category : #binding }
DiagramModel >> initializeBindings [
	bindings := Dictionary new.
	self list do:[:de |
		bindings at: de variableNameForDescriptionCode put:  (de updaterClass new realDiagramNode: de)]
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
	model ifNotNil: [model removeDependent: self].
	aModel ifNotNil: [aModel addDependent: self].

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
