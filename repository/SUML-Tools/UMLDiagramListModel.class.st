Class {
	#name : #UMLDiagramListModel,
	#superclass : #Object,
	#instVars : [
		'diagramModel',
		'selectedIndex',
		'bindings',
		'diagramsHolder'
	],
	#category : #'SUML-Tools'
}

{ #category : #accessing }
UMLDiagramListModel >> acceptContents: aText [ 
	"The binding actually has an Updater"
	self bindingOfSelectedDiagramNode update.
	self selectedDiagram saveDescriptionIn: self diagramsHolder.
	self changed: #list.
	self changed: #descriptionCode.
	self changed: #view.
	self changed.
]

{ #category : #binding }
UMLDiagramListModel >> bindingOf: aString [
	^bindings associationAt: aString ifAbsent:[self error: (self model bindingErrorBecauseOf: aString ) ].

	
]

{ #category : #binding }
UMLDiagramListModel >> bindingOfSelectedDiagramNode [
	^(self bindingOf: self selectedDiagramNode variableNameForDescriptionCode) value
]

{ #category : #'as yet unclassified' }
UMLDiagramListModel >> category [
	^self model category
]

{ #category : #'as yet unclassified' }
UMLDiagramListModel >> changed [
	self initializeBindings.
	self changed: #list.
	self changed: #view.
	self changed: #descriptionCode.
	super changed.
]

{ #category : #'as yet unclassified' }
UMLDiagramListModel >> changed: aParameter [
	(aParameter ~= #descriptionCode)
		ifTrue:[self model changed: aParameter].
	((aParameter = #selectedIndex) or:[aParameter = #position])
		ifTrue:[
			self changed: #descriptionCode.].
	(aParameter = #view)
		ifTrue:[
			self diagramsHolder changed: #view].
		super changed: aParameter 
]

{ #category : #'as yet unclassified' }
UMLDiagramListModel >> clearRelationshipsOfSelectedDiagramNode [ 
	self bindingOfSelectedDiagramNode clearRelationships 
]

{ #category : #'as yet unclassified' }
UMLDiagramListModel >> diagramName [ 
	^self selectedDiagram name
]

{ #category : #accessing }
UMLDiagramListModel >> diagramNodes [
	^self selectedDiagram  diagramNodes 
]

{ #category : #accessing }
UMLDiagramListModel >> diagramsHolder [
	^ diagramsHolder
]

{ #category : #accessing }
UMLDiagramListModel >> diagramsHolder: anObject [
	diagramsHolder := anObject
]

{ #category : #binding }
UMLDiagramListModel >> hasBindingOf: aString [
	^(bindings notNil and: [bindings includesKey: aString])
]

{ #category : #'as yet unclassified' }
UMLDiagramListModel >> initialize [ 
	selectedIndex := 1.
]

{ #category : #binding }
UMLDiagramListModel >> initializeBindings [
	bindings := Dictionary new.
	self list do:[:de |
		bindings at: de variableNameForDescriptionCode put:  (de updaterClass new realDiagramNode: de)]
]

{ #category : #accessing }
UMLDiagramListModel >> list [
	^self model list
]

{ #category : #'as yet unclassified' }
UMLDiagramListModel >> listMenu: aMenu shifted: shifted [
	aMenu target: self model.
	^self model listMenu: aMenu shifted: shifted
]

{ #category : #accessing }
UMLDiagramListModel >> model [
	^ diagramModel 
]

{ #category : #accessing }
UMLDiagramListModel >> model: anObject [
	diagramModel  := anObject.
	diagramModel ifNotNil: [diagramModel removeDependent: self].
	anObject ifNotNil: [anObject addDependent: self].
	self initializeBindings.
	selectedIndex := 1.
	self changed: #list
	
]

{ #category : #accessing }
UMLDiagramListModel >> selectedDescriptionCode [
	^self selectedDiagram descriptionCodeOf: self selectedDiagramNode
]

{ #category : #accessing }
UMLDiagramListModel >> selectedDiagram [
	^self model model
]

{ #category : #accessing }
UMLDiagramListModel >> selectedDiagramNode [
	^self model selectedDiagramNode 
]

{ #category : #accessing }
UMLDiagramListModel >> selectedIndex [
	^ selectedIndex
]

{ #category : #accessing }
UMLDiagramListModel >> selectedIndex: anIndex [
	anIndex > 0
		ifTrue: [ 
			selectedIndex := anIndex.
			self changed: #selectedIndex.
			]
]

{ #category : #accessing }
UMLDiagramListModel >> update: aParameter [
	(aParameter = #descriptionCode)
		ifTrue:[self changed: #descriptionCode].

	(aParameter = #view)
		ifTrue:[self diagramsHolder changed: #view].
			
	(aParameter = #selectedIndex )
		ifTrue:[
				
				self model selectedIndex: self selectedIndex. 
				
				self changed: #list. 
				self changed: #descriptionCode].
	self initializeBindings.
]

{ #category : #updating }
UMLDiagramListModel >> updateView [
	self dependents do:[:dep | dep update: #view]
]
