Class {
	#name : #DiagramModel,
	#superclass : #UMLToolModel,
	#instVars : [
		'bindings',
		'diagramsHolder'
	],
	#category : #'SUML-Tools'
}

{ #category : #accessing }
DiagramModel >> acceptContents: aText [ 
	self bindingOfSelectedBoxDescription updateRealBox.
	self model saveDescriptionIn: self diagramsHolder.
	self changed: #list.
	self changed: #descriptionCode.
	self changed: #view.
	self changed.
]

{ #category : #binding }
DiagramModel >> bindingOf: aString [
	^bindings associationAt: aString ifAbsent:[self error:'No class description associated with the variable: ', aString ].

	
]

{ #category : #binding }
DiagramModel >> bindingOfSelectedBoxDescription [
	^(self bindingOf: self selectedBox variableNameForDescriptionCode) value
]

{ #category : #'as yet unclassified' }
DiagramModel >> changed [
	self initializeBindings.
	self changed: #list.
	self changed: #view.
	self changed: #descriptionCode.
	super changed.
]

{ #category : #'as yet unclassified' }
DiagramModel >> changed: aParameter [
	((aParameter == #selectedIndex) or:[aParameter == #position])
		ifTrue:[
			self changed: #descriptionCode.].
	(aParameter == #view)
		ifTrue:[
			self model changed].
		super changed: aParameter 
]

{ #category : #'menu-options' }
DiagramModel >> checkBoxName: aBoxName [
	(bindings values anySatisfy: [:box | box name = aBoxName ]) ifTrue:[self error: 'There already exists a box named ', aBoxName ].
	^aBoxName 
]

{ #category : #'menu-options' }
DiagramModel >> chooseClassFromCategory [
	| dialog choice |
	dialog := PopupChoiceOrRequestDialogWindow new filterInput: false;
		title: 'Choose a class from the category ', self category;
		labels: (SystemOrganization classesInCategory: self category);
		lines: #();
		model: (SystemOrganization classesInCategory: self category).
	choice := (SystemWindow topWindow openModal: dialog) choice.
	dialog cancelled ifTrue: [ ^nil ].
	choice 
		ifNotNil: [ ^self checkBoxName: choice ]
		ifNil: [ ^dialog filterValue ]
]

{ #category : #'menu-options' }
DiagramModel >> chooseTraitFromCategory [
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

{ #category : #'as yet unclassified' }
DiagramModel >> clearRelationshipsOfSelectedBoxDescription [ 
	self bindingOfSelectedBoxDescription clearRelationships 
]

{ #category : #'menu-options' }
DiagramModel >> createClassBox [
	| className |
	className := self request: 'Class Name' default: ''.
	self checkBoxName: className.
	self model addNewClassDescriptionNamed: className.
	self changed.
]

{ #category : #'menu-options' }
DiagramModel >> createClassBoxFromCategory [
	self createClassBoxFromClass: self chooseClassFromCategory.
	self changed.
]

{ #category : #'menu-options' }
DiagramModel >> createClassBoxFromClass [
	|className|
	className := self request: 'For which class would you like to create a new Class Box?' default: nil.
	self checkBoxName: className.
	className ifNotNil:[self createClassBoxFromClass: (Smalltalk at: className asSymbol ).
	self changed.]
]

{ #category : #'menu-options' }
DiagramModel >> createClassBoxFromClass: aClass [
	aClass ifNotNil: [ self model addBoxDescription: (ClassBox fromClass: aClass )]
]

{ #category : #'menu-options' }
DiagramModel >> createInterfaceBox [
	| interfaceName |
	interfaceName := self request: 'Interface / Type Name' default: ''.
	self checkBoxName: interfaceName .
	self model addBoxDescription: (InterfaceBox new boxTitle: interfaceName).
	self changed.
]

{ #category : #'menu-options' }
DiagramModel >> createTraitBox [
	| traitName |
	traitName := self request: 'Trait Name' default: ''.
	self checkBoxName: traitName .
	self model addBoxDescription: (TraitBox new boxTitle: traitName).
	self changed.
]

{ #category : #'menu-options' }
DiagramModel >> createTraitBoxFromCategory [
	self createTraitBoxFromTrait: self chooseTraitFromCategory.
	self changed.
]

{ #category : #'menu-options' }
DiagramModel >> createTraitBoxFromTrait [
	|traitName|
	traitName := self request: 'For which trait would you like to create a new Trait Box?' default: nil.
	self checkBoxName: traitName .
	self createTraitBoxFromTrait: (Smalltalk at: traitName asSymbol ).
	self changed.
]

{ #category : #'menu-options' }
DiagramModel >> createTraitBoxFromTrait: aTrait [
	aTrait ifNotNil:[ self model addBoxDescription: (TraitBox  fromTrait: aTrait )]
]

{ #category : #'menu-options' }
DiagramModel >> deleteBox [
	self model removeBoxDescription: self selectedBox .
	self selectedIndex: self selectedIndex -1.
	self changed: #list.
	self changed: #view.
	self changed: #descriptionCode.
	self initializeBindings.

]

{ #category : #accessing }
DiagramModel >> descriptionCode [
	^self model descriptionCodeOf: self selectedBox 
]

{ #category : #accessing }
DiagramModel >> diagramElements [ 
	^self model boxMorphs
]

{ #category : #accessing }
DiagramModel >> diagramsHolder [
	^ diagramsHolder
]

{ #category : #accessing }
DiagramModel >> diagramsHolder: anObject [
	diagramsHolder := anObject
]

{ #category : #binding }
DiagramModel >> hasBindingOf: aString [
	^(bindings notNil and: [bindings includesKey: aString])
]

{ #category : #binding }
DiagramModel >> initializeBindings [
	bindings := Dictionary new.
	self model boxes do:[:de |
		bindings at: de variableNameForDescriptionCode put:  (de updaterClass new realBox: de)]
]

{ #category : #accessing }
DiagramModel >> list [
	^self model ifNotNil:[self model boxes]
	 "This should be changed when integrating other kinds of diagrams, doing a double dispatch maybe"
	ifNil:[#()]
]

{ #category : #'menu-options' }
DiagramModel >> listMenu: aMenu shifted: shifted [
	self list ifNotEmpty:[
		aMenu addList: #(('Delete box'	#deleteBox) ('Rename box'	renameBox));
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

{ #category : #'as yet unclassified' }
DiagramModel >> model: aModel [
	super model: aModel.
	self initializeBindings.
	self selectedIndex: 1.
	
]

{ #category : #'menu-options' }
DiagramModel >> renameBox [
	| newBoxName newVariableName binding |
	newBoxName := self request: ('New name for ', self selectedBox name) default: ''.
	binding := self bindingOf: self selectedBox variableNameForDescriptionCode.
	self selectedBox boxTitle: newBoxName.
	binding key: self selectedBox variableNameForDescriptionCode. 
	self changed.
]

{ #category : #accessing }
DiagramModel >> selectedBox [
	^self list at: self selectedIndex ifAbsent:[NullDescription new]
]

{ #category : #accessing }
DiagramModel >> selectedDescriptionCode [
	^self model descriptionCodeOf: self selectedBox
]

{ #category : #accessing }
DiagramModel >> update: aParameter [
	(aParameter == #descriptionCode)
		ifTrue:[self changed: #descriptionCode].
	self model saveDescriptionIn: self diagramsHolder.
]
