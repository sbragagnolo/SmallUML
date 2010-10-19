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
	| diagramCode |
	diagramCode  := (PluggableShoutEditorMorph 
		on: (DiagramWorkspace new model: model diagramListModel) 
		text: #descriptionCode 
		accept: #acceptContents:from:
		readSelection: nil 
		menu: #codePaneMenu:shifted:).

diagram := DiagramWhiteboard new. 
diagram clipSubmorphs: true.
diagram model: model.
self addMorph: diagram frame: (0@0 corner: 1@0.8).
self addMorph: (self diagramsList addDependent: diagram; yourself)frame: (0@0.8 corner: 0.25@1).
self addMorph: self descriptionsList frame: (0.25@0.8 corner: 0.5@1).
self addMorph: diagramCode frame: (0.5@0.8 corner: 1@1).

]

{ #category : #'as yet unclassified' }
UMLDiagramWindow >> descriptionCode [ 
	^model ifNil: [''] ifNotNil: [model descriptionCode] 
]

{ #category : #'as yet unclassified' }
UMLDiagramWindow >> descriptionsList [
	^PluggableListMorph new
		on: self model diagramListModel
		list: #list
		selected: #selectedIndex
		changeSelected: #selectedIndex:
		menu: #listMenu:shifted:
		keystroke: #listKey:from:;
		 borderWidth: 0;
		 enableDragNDrop: false;
		 autoDeselect: true;
		 yourself
]

{ #category : #'as yet unclassified' }
UMLDiagramWindow >> diagramsList [
	^PluggableListMorph new
		on: self model
		list: #list
		selected: #selectedIndex
		changeSelected: #selectedIndex:
		menu: #listMenu:shifted:
		keystroke: #listKey:from:;
		 borderWidth: 0;
		 enableDragNDrop: false;
		 autoDeselect: true;
		 yourself
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
