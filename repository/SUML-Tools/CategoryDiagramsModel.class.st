Class {
	#name : #CategoryDiagramsModel,
	#superclass : #UMLToolModel,
	#instVars : [
		'selectedDiagramModel'
	],
	#category : #'SUML-Tools'
}

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> changed [
	self selectedDiagramModel model: self selectedDiagram.
	super changed.
]

{ #category : #accessing }
CategoryDiagramsModel >> changed: aParameter [
	(aParameter == #selectedIndex)
		ifTrue:[
			self selectedDiagramModel model: self selectedDiagram.
			self selectedDiagramModel changed: #list.
			self selectedDiagramModel changed: #descriptionCode.
			self selectedDiagramModel changed: #view.
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
CategoryDiagramsModel >> exportDiagramAsWorkspace [
	Workspace new saveString: self selectedDiagram descriptionCode toFile: self selectedDiagram name, '.ws' 
]

{ #category : #accessing }
CategoryDiagramsModel >> labelString [
	^self model category, ' - ', self selectedDiagram name
]

{ #category : #accessing }
CategoryDiagramsModel >> list [
	^self model diagrams
]

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> listMenu: aMenu shifted: aBoolean [
	self list ifNotEmpty: [
		aMenu addList: #(
		('delete diagram'	deleteDiagram)
		('rename diagram'	renameDiagram)
		)].
	aMenu addLine.
	aMenu addList: #(('add new diagram'	createDiagram)).
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
	PNGReadWriter putForm: (DiagramWhiteboard new model: self selectedDiagramModel) imageForm onFileNamed: self selectedDiagram name, '.png'.

]

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> selectedDiagram [
	^ self list at: self selectedIndex ifAbsent:[NullDiagram new]
]

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> selectedDiagramModel [
	^selectedDiagramModel ifNil:[selectedDiagramModel := (DiagramModel new model: self selectedDiagram; diagramsHolder: self model) ]
]
