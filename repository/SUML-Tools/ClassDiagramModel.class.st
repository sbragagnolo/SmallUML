Class {
	#name : #ClassDiagramModel,
	#superclass : #DiagramModel,
	#category : #'SUML-Tools'
}

{ #category : #'as yet unclassified' }
ClassDiagramModel >> bindingErrorBecauseOf: aVariable [
	^'No class description associated with the variable: ', aVariable 
]

{ #category : #'menu-options' }
ClassDiagramModel >> chooseClassFromCategory [
	| dialog choice |
	dialog := PopupChoiceOrRequestDialogWindow new filterInput: false;
		title: 'Choose a class from the category ', self category;
		labels: (SystemOrganization classesInCategory: self category);
		lines: #();
		model: (SystemOrganization classesInCategory: self category).
	choice := (SystemWindow topWindow openModal: dialog) choice.
	dialog cancelled ifTrue: [ ^nil ].
	choice 
		ifNotNil: [ ^"self checkBoxName: "choice ]
		ifNil: [ ^dialog filterValue ]
]

{ #category : #'menu-options' }
ClassDiagramModel >> chooseTraitFromCategory [
	| dialog choice |
	dialog := PopupChoiceOrRequestDialogWindow new filterInput: false;
		title: 'Choose a trait from the category ', self category;
		labels: (SystemOrganization orderedTraitsIn: self category);
		lines: #();
		model: (SystemOrganization orderedTraitsIn: self category).
	choice := (SystemWindow topWindow openModal: dialog) choice.
	dialog cancelled ifTrue: [ ^nil ].
	choice 
		ifNotNil: [ ^self checkBoxName: choice ]
		ifNil: [ ^dialog filterValue ]
]

{ #category : #'menu-options' }
ClassDiagramModel >> createClassBox [
	| className |
	className := self request: 'Class Name' default: ''.
	self checkBoxName: className.
	self model addNewClassDescriptionNamed: className.
	self changed.
]

{ #category : #'menu-options' }
ClassDiagramModel >> createClassBoxFromCategory [
	self createClassBoxFromClass: self chooseClassFromCategory.
	self changed.
]

{ #category : #'menu-options' }
ClassDiagramModel >> createClassBoxFromClass [
	|className|
	className := self request: 'For which class would you like to create a new Class Box?' default: nil.
	self checkBoxName: className.
	className ifNotNil:[self createClassBoxFromClass: (Smalltalk at: className asSymbol ).
	self changed.]
]

{ #category : #'menu-options' }
ClassDiagramModel >> createClassBoxFromClass: aClass [
	aClass ifNotNil: [ self model addDiagramNode: (ClassBox fromClass: aClass )].
	self changed.
]

{ #category : #'menu-options' }
ClassDiagramModel >> createInterfaceBox [
	| interfaceName |
	interfaceName := self request: 'Interface / Type Name' default: ''.
	self checkBoxName: interfaceName .
	self model addDiagramNode: (InterfaceBox new boxTitle: interfaceName).
	self changed.
]

{ #category : #'menu-options' }
ClassDiagramModel >> createTraitBox [
	| traitName |
	traitName := self request: 'Trait Name' default: ''.
	self checkBoxName: traitName .
	self model addDiagramNode: (TraitBox new boxTitle: traitName).
	self changed.
]

{ #category : #'menu-options' }
ClassDiagramModel >> createTraitBoxFromCategory [
	self createTraitBoxFromTrait: self chooseTraitFromCategory.
	self changed.
]

{ #category : #'menu-options' }
ClassDiagramModel >> createTraitBoxFromTrait [
	|traitName|
	traitName := self request: 'For which trait would you like to create a new Trait Box?' default: nil.
	self checkBoxName: traitName .
	self createTraitBoxFromTrait: (Smalltalk at: traitName asSymbol ).
	self changed.
]

{ #category : #'menu-options' }
ClassDiagramModel >> createTraitBoxFromTrait: aTrait [
	aTrait ifNotNil:[ self model addDiagramNode: (TraitBox  fromTrait: aTrait )]
]

{ #category : #accessing }
ClassDiagramModel >> descriptionCode [
	^self model descriptionCodeOf: self selectedDiagramNode 
]

{ #category : #accessing }
ClassDiagramModel >> list [
	^self model ifNotNil:[self model diagramNodes]
	 "This should be changed when integrating other kinds of diagrams, doing a double dispatch maybe"
	ifNil:[#()]
]

{ #category : #'menu-options' }
ClassDiagramModel >> listMenu: aMenu shifted: shifted [
	self list ifNotEmpty:[
		aMenu addList: #(('Delete box'	#deleteNode) ('Rename box'	#renameNode));
			addLine].
		aMenu 
			addList: #(
					('Add new class box' 		#createClassBox) 
					('Add new class box from existing class in category' #createClassBoxFromCategory)
					('Add new class box from existing class' #createClassBoxFromClass)
					('Add new interface / type box' 		#createInterfaceBox)
					('Add new trait box' 		#createTraitBox)
					('Add new trait box from existing trait in category' #createTraitBoxFromCategory)
					('Add new trait box from existing trait' #createTraitBoxFromTrait)
					 ).

	^ aMenu 
]
