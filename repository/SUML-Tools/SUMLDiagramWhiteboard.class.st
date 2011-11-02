Class {
	#name : #SUMLDiagramWhiteboard,
	#superclass : #DiagramWhiteboard,
	#category : #'SUML-Tools'
}

{ #category : #'as yet unclassified' }
SUMLDiagramWhiteboard >> categoryDiagramsModel [
	^self model
]

{ #category : #'as yet unclassified' }
SUMLDiagramWhiteboard >> diagram [
	^self categoryDiagramsModel selectedDiagram
]

{ #category : #'as yet unclassified' }
SUMLDiagramWhiteboard >> handlesMouseDown: evt [
	^true
]

{ #category : #'as yet unclassified' }
SUMLDiagramWhiteboard >> model: anObject [
	model := anObject.
	model ifNotNil: [
		self diagram removeDependent: self.
		model removeDependent: self].
	anObject ifNotNil: [
		.anObject addDependent: self.
		self diagram addDependent: self. ].
	diagramNodes := Dictionary new.
]

{ #category : #'as yet unclassified' }
SUMLDiagramWhiteboard >> mouseDown: evt [
	evt yellowButtonPressed ifTrue:[self showActionsMenu ]
	
]

{ #category : #'as yet unclassified' }
SUMLDiagramWhiteboard >> showActionsMenu [
	| menu |
	menu := MenuMorph new.
	menu addTitle: self diagram name.
	menu addStayUpItem.
	menu target: (DiagramManager for: self diagram).
	menu add: 'New Class Box...' action: #createClassBox.
	menu add: 'New Interface / Type Box...' action: #createInterfaceBox.
	menu add: 'New Trait Box...' action: #createTraitBox.
	menu addLine.
	menu add: 'Import Class...' action: #createClassBoxFromClass.
	menu add: 'Import Class Hierarchy...' action: #createClassBoxHierarchyFromClass.
	menu add: 'Import Class from ', self diagram category action: #createClassBoxFromCategory.
	menu add: 'Import Trait...' action: #createTraitBoxFromTrait.
	menu add: 'Import Trait from ', self diagram category action: #createTraitBoxFromCategory.
	menu add: 'Import all Classes and Traits from... ' action: #createEverythingFromACategory.
	menu addLine.
	menu add: 'Update Diagram from Model' action: #updateDiagramFromModel.
	menu popUpInWorld.
]

{ #category : #'as yet unclassified' }
SUMLDiagramWhiteboard >> update: aParameter [
	super update: aParameter.
	(aParameter == #diagram) ifTrue:[
		self diagram addDependent: self. ].
]
