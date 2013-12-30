Class {
	#name : #CategoryDiagramsModel,
	#superclass : #UMLToolModel,
	#instVars : [
		'selectedDiagramModel',
		'diagrams',
		'selectedDiagram'
	],
	#category : #'SUML-Tools'
}

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> addDiagram: aDiagram [
	self model addDiagram: aDiagram.
"	diagrams add: aDiagram."
]

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> changed [
	self diagramListModel model: self selectedDiagramModel.
	super changed.
]

{ #category : #accessing }
CategoryDiagramsModel >> changed: aParameter [
	(aParameter == #selectedIndex)
		ifTrue:[
			self diagramListModel model: self selectedDiagramModel.
"			self diagramListModel changed: #list."
			self diagramListModel changed: #descriptionCode.
			self changed: #view.
			"self changed: #relabel"
			self changed: #diagram].

	super changed: aParameter 
]

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> createDiagram [
	|diagramName newDiagram |
	((diagramName := self request: 'Diagram Name' default: '')
		isNil or: [diagramName isEmpty]) ifTrue: [^self].
	newDiagram:= (ClassDiagram new name: diagramName).
	self addDiagram: newDiagram .
	self changed: #list.
	self selectedIndex: self list size.
]

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> createInheritanceDiagram [
	|className rootClass newDiagram |
	[className := self request: 'Root Class for the inheritance diagram' default: ''.
	rootClass := Smalltalk at: className asSymbol]
		on: Error
		do: [^ UIManager default inform: className asString , ' not found'].
	newDiagram := ClassDiagram inheritanceFor: rootClass.
	self model addDiagram: newDiagram.
	diagrams add: newDiagram.
	self selectedIndex: self list size.
	self changed: #list.
]

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> deleteDiagram [
	self model removeDiagram: self selectedDiagram .
	"diagrams remove: self selectedDiagram."

	(self list notEmpty) 
		ifTrue: [self selectedDiagram: self list first ].
	self changed: #roots.
	


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
CategoryDiagramsModel >> listMenu: aMenu [
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
	diagramName ifNotNil: [
		currentDiagram := self selectedDiagram.
	self deleteDiagram.
	currentDiagram name: diagramName.
	self addDiagram: currentDiagram.
	self selectedDiagram: currentDiagram.
	self changed: #selectedIndex.
	self changed: #roots.
]
	
]

{ #category : #accessing }
CategoryDiagramsModel >> roots [
	^((DiagramsHolder allProtocolsUpTo: DiagramsHolder) collect:[:item| CategoryDiagramsTreeItemNode with: item model: self ]).
]

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> saveDiagramAsPNG [
	PNGReadWriter putForm: ((SUMLDiagramWhiteboard new model: self diagramListModel) update) imageForm onFileNamed: self selectedDiagram name, '.png'.

]

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> selectDiagramByName: aDiagramName [
	self selectedIndex: ((self list collect:#name) indexOf: aDiagramName )
]

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> selectedDiagram [
	^ selectedDiagram ifNil:[NullDiagram new]
]

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> selectedDiagram: aDiagram [
(aDiagram isKindOf: Diagram) ifTrue:[
	selectedDiagram := aDiagram.
	self changed: #view.
	self changed: #selectedIndex]
]

{ #category : #accessing }
CategoryDiagramsModel >> selectedDiagramModel [
	^self selectedDiagram modelForDiagramsHolder: self model
]

{ #category : #'as yet unclassified' }
CategoryDiagramsModel >> update: aParameter [
	
	(aParameter = #view) ifTrue:[self changed: #view].
	(aParameter = #descriptionCode) ifTrue:[self changed: #list].
	self diagramListModel changed: #descriptionCode.
	super update: aParameter.
]
