Class {
	#name : #DiagramManager,
	#superclass : #ActionsManager,
	#category : #'SUML-Tools'
}

{ #category : #'as yet unclassified' }
DiagramManager >> category [
	^self diagram category
]

{ #category : #'as yet unclassified' }
DiagramManager >> chooseClassFromCategory [
	| dialog choice |
	dialog := PopupChoiceOrRequestDialogWindow new filterInput: false;
		title: 'Choose a class from the category ', self category;
		labels: (SystemOrganization classesInCategory: self category);
		lines: #();
		model: (SystemOrganization classesInCategory: self category).
	choice := (SystemWindow topWindow openModal: dialog) choice.
	dialog cancelled ifTrue: [ ^nil ].
	choice 
		ifNotNil: [ ^choice ]
		ifNil: [ ^dialog filterValue ]
]

{ #category : #'as yet unclassified' }
DiagramManager >> chooseTraitFromCategory [
	| dialog choice |
	dialog := PopupChoiceOrRequestDialogWindow new filterInput: false;
		title: 'Choose a trait from the category ', self category;
		labels: (SystemOrganization orderedTraitsIn: self category);
		lines: #();
		model: (SystemOrganization orderedTraitsIn: self category).
	choice := (SystemWindow topWindow openModal: dialog) choice.
	dialog cancelled ifTrue: [ ^nil ].
	choice 
		ifNotNil: [ ^choice ]
		ifNil: [ ^dialog filterValue ]
]

{ #category : #'as yet unclassified' }
DiagramManager >> createClassBox [
	| className |
	className := self request: 'Class Name' default: ''.
	self diagram addNewClassDescriptionNamed: className.
]

{ #category : #'as yet unclassified' }
DiagramManager >> createClassBoxFromCategory [
	self createClassBoxFromClass: self chooseClassFromCategory.
]

{ #category : #'as yet unclassified' }
DiagramManager >> createClassBoxFromClass [
	|className|
	className := self request: 'For which class would you like to create a new Class Box?' default: nil.
	self createClassBoxFromClass: (Smalltalk at: className asSymbol ifAbsent:[nil]).
]

{ #category : #'as yet unclassified' }
DiagramManager >> createClassBoxFromClass: aClass [
	aClass ifNotNil: [ self diagram addDiagramNode: (ClassBox fromClass: aClass )].
]

{ #category : #'as yet unclassified' }
DiagramManager >> createClassBoxHierarchyFromClass [
	|className aClass|
	className := self request: 'Root class of the hierarchy?' default: nil.
	aClass := (Smalltalk at: className asSymbol ifAbsent:[self error: 'There''s no class named ', className ]).
	(ClassDiagram inheritanceFor: aClass) copyNodesTo: self diagram. 
]

{ #category : #'as yet unclassified' }
DiagramManager >> createInterfaceBox [
	| interfaceName |
	interfaceName := self request: 'Interface / Type Name' default: ''.
	self diagram addDiagramNode: (InterfaceBox newNamed: interfaceName).
]

{ #category : #'as yet unclassified' }
DiagramManager >> createTraitBox [
	| traitName |
	traitName := self request: 'Trait Name' default: ''.
	self diagram addDiagramNode: (TraitBox newNamed: traitName).
]

{ #category : #'as yet unclassified' }
DiagramManager >> createTraitBoxFromCategory [
	self createTraitBoxFromTrait: self chooseTraitFromCategory.
]

{ #category : #'as yet unclassified' }
DiagramManager >> createTraitBoxFromTrait [
	|traitName|
	traitName := self request: 'For which trait would you like to create a new Trait Box?' default: nil.
	self createTraitBoxFromTrait: (Smalltalk at: traitName asSymbol ifAbsent:[nil]).
]

{ #category : #'as yet unclassified' }
DiagramManager >> createTraitBoxFromTrait: aTrait [
	aTrait ifNotNil:[ self diagram addDiagramNode: (TraitBox  fromTrait: aTrait )]
]

{ #category : #accessing }
DiagramManager >> diagram [
	^ self model
]

{ #category : #'as yet unclassified' }
DiagramManager >> updateDiagramFromModel [
	self diagram updateFromModel 
]
