Class {
	#name : #UMLDiagramWindow,
	#superclass : #SystemWindow,
	#instVars : [
		'diagram'
	],
	#category : #'SUML-Tools'
}

{ #category : #'as yet unclassified' }
UMLDiagramWindow class >> on: aModel [
	^(self new model: aModel) createView 
]

{ #category : #'as yet unclassified' }
UMLDiagramWindow >> acceptContents: contents [ 
	self model: (Compiler evaluate: contents)
]

{ #category : #'as yet unclassified' }
UMLDiagramWindow >> createView [ 
	|  scrollPane tree|

scrollPane := ScrollPane new.
diagram := SUMLDiagramWhiteboard new . 
diagram extent: 1500@2000.
diagram clipSubmorphs: false.
diagram model: model.
diagram update.
scrollPane scroller addMorph: diagram.
diagram position: 0@0.


self addMorph: (self diagramsList addDependent: diagram; yourself)frame: (0@0 corner: 0.15@1).
self addMorph: scrollPane frame: (0.15@0 corner: 1@01).
]

{ #category : #'as yet unclassified' }
UMLDiagramWindow >> diagramsList [
|tree|
tree := 
 PluggableTreeMorph 
		on: self model
		list: #roots
		selected: #selectedDiagram
		changeSelected: #selectedDiagram:
		menu: #listMenu:
		keystroke: nil.
		"menu: #menu."
		
"		PluggableTreeMorph new
		model: self model;
		setSelectedSelector: #;
		getMenuSelector: #listMenu:shifted:.
tree list: ((DiagramsHolder allMethodCategoriesIntegratedThrough: DiagramsHolder) collect:[:item| CategoryDiagramsTreeItemNode  with: item model: tree])."

^tree

	"	on: self model
		list: #list
		selected: #selectedIndex
		changeSelected: #selectedIndex:
		menu: #listMenu:shifted:
		keystroke: #listKey:from:;
		 borderWidth: 0;
		 enableDragNDrop: false;
		 autoDeselect: true;
		 yourself"
]

{ #category : #'as yet unclassified' }
UMLDiagramWindow >> model: aModel [
	super model: aModel.
	self setLabel: model diagramName. 


]

{ #category : #accessing }
UMLDiagramWindow >> selectedDescriptionModel [
	^self model diagramListModel 
]
