Class {
	#name : #CategoryDiagramsModel,
	#superclass : #UMLToolModel,
	#instVars : [
		'selectedDiagramModel',
		'diagrams'
	],
	#category : #'SUML-Tools'
}

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> changed [
	self diagramListModel model: self selectedDiagram.
	super changed.
]

{ #category : #accessing }
CategoryDiagramsModel >> changed: aParameter [
	(aParameter = #list) ifTrue:[diagrams:= self model diagrams].
	(aParameter == #selectedIndex)
		ifTrue:[
			self diagramListModel model: self selectedDiagramModel.
"			self diagramListModel changed: #list."
			self diagramListModel changed: #descriptionCode.
			self changed: #view.
			self changed: #relabel].
	super changed: aParameter 
]

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> createDiagram [
	|diagramName|
	diagramName := self request: 'Diagram Name' default: ''.
	self model addDiagram: (ClassDiagram new name: diagramName).
	self selectedIndex: self list size.
	self changed: #list.
	
]

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> createInheritanceDiagram [
	|className|
	className := self request: 'Root Class for the inheritance diagram' default: ''.
	self model addDiagram: (ClassDiagram inheritanceFor: (Smalltalk at: className asSymbol) ).
	self selectedIndex: self list size.
	self changed: #list.
	
]

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> deleteDiagram [
	self model removeDiagram: self selectedDiagram .
	
	self changed: #list.
	(self list notEmpty and:[ self selectedIndex > 1]) 
		ifTrue: [self selectedIndex: self selectedIndex -1].
	(self list notEmpty and:[ self selectedIndex = 1]) 
		ifTrue:[self selectedIndex: 1].
	self changed: #selectedIndex.
	


]

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> diagramListModel [
	^selectedDiagramModel ifNil:[selectedDiagramModel := UMLDiagramListModel new diagramsHolder: self model; model: (self selectedDiagramModel)]
]

{ #category : #accessing }
CategoryDiagramsModel >> diagramNodes [
	^self selectedDiagram diagramNodes 
]

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> exportDiagramAsWorkspace [
	Workspace new saveString: self selectedDiagram descriptionCode toFile: self selectedDiagram name, '.ws' 
]

{ #category : #accessing }
CategoryDiagramsModel >> labelString [
	^self model category, ' - ', self selectedDiagram name
]

{ #category : #accessing }
CategoryDiagramsModel >> list [
	^diagrams ifNil:[ diagrams:= self model diagrams]
]

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> listMenu: aMenu shifted: aBoolean [
	self list ifNotEmpty: [
		aMenu addList: #(
		('delete diagram'	deleteDiagram)
		('rename diagram'	renameDiagram)
		)].
	aMenu addLine.
	aMenu addList: #(('add diagram'	createDiagram)).
	aMenu addList: #(('add inheritance diagram' createInheritanceDiagram)).
	aMenu addLine.
	aMenu addList: #(
		('save diagram as PNG' saveDiagramAsPNG)
		('export diagram description code as a workspace'  exportDiagramAsWorkspace)).
	^ aMenu
]

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> renameDiagram [
	|diagramName currentDiagram|
	diagramName := self request: 'New name for ', self selectedDiagram name default: nil.
	diagramName ifNotNil: [currentDiagram := self selectedDiagram.
	self deleteDiagram.
	currentDiagram name: diagramName.
	self model addDiagram: currentDiagram.
	self changed: #list.
	self changed: #selectedIndex.
	self changed.]
	
]

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> saveDiagramAsPNG [
	PNGReadWriter putForm: (DiagramWhiteboard new model: self diagramListModel) imageForm onFileNamed: self selectedDiagram name, '.png'.

]

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> selectedDiagram [
	^ self list at: self selectedIndex ifAbsent:[NullDiagram new]
]

{ #category : #accessing }
CategoryDiagramsModel >> selectedDiagramModel [
	^self selectedDiagram modelForDiagramsHolder: self model
]

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> update: aParameter [
	
	(aParameter = #view) ifTrue:[self changed: #view].
	self diagramListModel changed: #descriptionCode.
	super update: aParameter.
]
