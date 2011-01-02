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
	|  scrollPane|

scrollPane := ScrollPane new.
diagram := SUMLDiagramWhiteboard new . 
diagram extent: 1000@2000.
diagram clipSubmorphs: false.
diagram model: model.
diagram update.
scrollPane scroller addMorph: diagram.
diagram position: 0@0.


self addMorph: (self diagramsList addDependent: diagram; yourself)frame: (0@0 corner: 0.15@1).
self addMorph: scrollPane frame: (0.15@0 corner: 1@01).
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
