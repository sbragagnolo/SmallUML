Class {
	#name : #UMLToolModel,
	#superclass : #Object,
	#instVars : [
		'model',
		'selectedIndex'
	],
	#category : #'SUML-Tools'
}

{ #category : #'as yet unclassified' }
UMLToolModel >> category [
	^self model category
]

{ #category : #'as yet unclassified' }
UMLToolModel >> diagramName [ 
	^self selectedDiagram name
]

{ #category : #'as yet unclassified' }
UMLToolModel >> initialize [ 
	selectedIndex := 1.
]

{ #category : #accessing }
UMLToolModel >> list [
	self subclassResponsibility
]

{ #category : #accessing }
UMLToolModel >> model [
	^ model
]

{ #category : #accessing }
UMLToolModel >> model: anObject [
	model := anObject.
	model ifNotNil: [model removeDependent: self].
	anObject ifNotNil: [anObject addDependent: self].
]

{ #category : #'as yet unclassified' }
UMLToolModel >> request: aTitle default: aDefaultValue [
	^UIManager default
		request: aTitle
		initialAnswer: aDefaultValue
]

{ #category : #accessing }
UMLToolModel >> selectedIndex [
	^ selectedIndex
]

{ #category : #accessing }
UMLToolModel >> selectedIndex: anIndex [
	anIndex > 0
		ifTrue: [ 
			selectedIndex := anIndex.
			self changed: #selectedIndex.
			]
]

{ #category : #accessing }
UMLToolModel >> update: anObject [ 
	super update: anObject.
	(anObject ~= #descriptionCode) ifTrue: [self changed: #list.]
]
