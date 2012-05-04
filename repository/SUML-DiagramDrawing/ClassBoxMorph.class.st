Class {
	#name : #ClassBoxMorph,
	#superclass : #InterfaceBoxMorph,
	#instVars : [
		'variablesBox',
		'instanceVariables',
		'classVariables',
		'classInstanceVariables'
	],
	#category : #'SUML-DiagramDrawing'
}

{ #category : #'as yet unclassified' }
ClassBoxMorph >> addBoxMenuTo: aMenu [
	instanceVariables ifNil:[aMenu add: 'Add Instance Variables' action: #addInstanceVariables].
	classInstanceVariables ifNil:[aMenu add: 'Add Class Instance Variables' action: #addClassInstanceVariables].
	classVariables ifNil:[aMenu add: 'Add Class Variables' action: #addClassVariables].
	super addBoxMenuTo: aMenu.
]

{ #category : #'private - layout' }
ClassBoxMorph >> addBoxesToContainer [
	methodsBox := self newRectangle.
	titleBox := self newRectangle cellPositioning:  #topCenter.
	variablesBox := self newRectangle. 
	container addMorph: methodsBox ; addMorph: variablesBox; addMorph: titleBox. 
]

{ #category : #accessing }
ClassBoxMorph >> classInstanceVariables [
	^ self listFrom: diagramNode classInstanceVariables
]

{ #category : #accessing }
ClassBoxMorph >> classVariables [
	^self listFrom: diagramNode classVariables
]

{ #category : #defaults }
ClassBoxMorph >> defaultBorderStyle [ 
	^BorderStyle thinGray
]

{ #category : #accessing }
ClassBoxMorph >> diagramNode: aBoxDescription [
	super diagramNode: aBoxDescription.	
	self updateVariables.
]

{ #category : #initialization }
ClassBoxMorph >> initializeBoundingBox [
	super initializeBoundingBox.
	boundingBox fillStyle: Color veryLightGray  .
]

{ #category : #accessing }
ClassBoxMorph >> instanceVariables [
	^self listFrom: diagramNode instanceVariables
]

{ #category : #creation }
ClassBoxMorph >> newTextMorph [
	^ self textMorphClass new
]

{ #category : #updating }
ClassBoxMorph >> saveClassInstanceVariables: aText [
	self diagramNode classInstanceVariables:( self arrayFromText: aText )
]

{ #category : #updating }
ClassBoxMorph >> saveClassVariables: aText [
	self diagramNode classVariables:( self arrayFromText: aText)
]

{ #category : #updating }
ClassBoxMorph >> saveInstanceVariables: aText [
	self diagramNode instanceVariables:( self arrayFromText: aText  )
]

{ #category : #accessing }
ClassBoxMorph >> updateDescriptionText [ 
	super updateDescriptionText.
	self updateVariables.
]

{ #category : #accessing }
ClassBoxMorph >> updateVariables [ 
	variablesBox   removeAllMorphs.
	instanceVariables := self addTextMorphFor: diagramNode instanceVariables into: variablesBox property: 'InstanceVariables'.
	classInstanceVariables := self addTextMorphFor: diagramNode classInstanceVariables into: variablesBox  property: 'ClassInstanceVariables' withEmphasis: {TextEmphasis underlined . TextEmphasis italic}.
	classVariables := self addTextMorphFor: diagramNode classVariables into: variablesBox  property: 'ClassVariables'  withEmphasis: {TextEmphasis underlined}.

]
