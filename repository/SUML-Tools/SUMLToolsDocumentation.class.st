Class {
	#name : #SUMLToolsDocumentation,
	#superclass : #CategoryDiagramsHolder,
	#category : #'SUML-Tools'
}

{ #category : #diagrams }
SUMLToolsDocumentation >> dfguh [
	| d |
	d := ClassDiagram new name: 'dfguh'.
	^ d
]

{ #category : #diagrams }
SUMLToolsDocumentation >> models [
	| d categoryDiagramsModel uMLDiagramListModel sUMLDiagramWhiteboard |
	categoryDiagramsModel := ClassBox named: 'CategoryDiagramsModel'.
	categoryDiagramsModel instanceVariables: #('selectedDiagramModel' ).
	categoryDiagramsModel instanceMethods: #('diagramNodes' 'createDiagram' 'update:' 'diagramListModel' 'listMenu:shifted:' 'saveDiagramAsPNG' 'labelString' 'changed' 'exportDiagramAsWorkspace' 'deleteDiagram' 'renameDiagram' 'selectedDiagramModel' 'changed:' 'createInheritanceDiagram' 'selectedDiagram' 'addDiagram:' 'list' ).
	"Positioning"
	categoryDiagramsModel position: 338 @ 94.
	uMLDiagramListModel := ClassBox named: 'UMLDiagramListModel'.
	uMLDiagramListModel instanceVariables: #('diagramModel' 'selectedIndex' 'bindings' 'diagramsHolder' ).
	uMLDiagramListModel instanceMethods: #('clearRelationshipsOfSelectedDiagramNode' 'selectedDescriptionCode' 'listMenu:shifted:' 'diagramsHolder' 'diagramName' 'diagramsHolder:' 'changed' 'initialize' 'selectedIndex:' 'bindingOf:' 'list' 'initializeBindings' 'diagramNodes' 'selectedIndex' 'update:' 'updateView' 'category' 'acceptContents:' 'selectedDiagramNode' 'model' 'changed:' 'bindingOfSelectedDiagramNode' 'hasBindingOf:' 'selectedDiagram' 'model:' ).
	"Positioning"
	uMLDiagramListModel position: 848 @ 81.
	sUMLDiagramWhiteboard := ClassBox named: 'SUMLDiagramWhiteboard'.
	sUMLDiagramWhiteboard instanceMethods: #('handlesMouseDown:' 'showActionsMenu' 'categoryDiagramsModel' 'diagram' 'mouseDown:' 'model:' ).
	"Positioning"
	sUMLDiagramWhiteboard position: 32 @ 218.
	"Relationships"
	categoryDiagramsModel hasA: uMLDiagramListModel labeledAs: 'blah'.
	categoryDiagramsModel hasLotsOf: uMLDiagramListModel labeledAs: 'blehs'.
	d := (ClassDiagram new name: 'Models') addDiagramNode: categoryDiagramsModel;
				 addDiagramNode: uMLDiagramListModel;
				 addDiagramNode: sUMLDiagramWhiteboard.
	^ d
]
