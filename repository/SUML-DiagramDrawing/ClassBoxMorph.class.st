Class {
	#name : #ClassBoxMorph,
	#superclass : #InterfaceBoxMorph,
	#instVars : [
		'variablesBox'
	],
	#category : #'SUML-DiagramDrawing'
}

{ #category : #'as yet unclassified' }
ClassBoxMorph >> addBoxesToContainer [
	methodsBox := self newRectangle.
	titleBox := self newRectangle cellPositioning:  #topCenter.
	variablesBox := self newRectangle. 
	container addMorph: methodsBox ; addMorph: variablesBox; addMorph: titleBox.
]

{ #category : #'as yet unclassified' }
ClassBoxMorph >> defaultBorderStyle [ 
	^BorderStyle thinGray
]

{ #category : #'as yet unclassified' }
ClassBoxMorph >> diagramNode: aBoxDescription [
	super diagramNode: aBoxDescription.	
	self updateVariables.
]

{ #category : #'as yet unclassified' }
ClassBoxMorph >> initializeBoundingBox [
	super initializeBoundingBox.
	boundingBox fillStyle: Color veryLightGray  .
]

{ #category : #accessing }
ClassBoxMorph >> updateVariables [ 
	variablesBox   removeAllMorphs.
	self addTextMorphFor: diagramNode instanceVariables into: variablesBox.
	self addTextMorphFor: diagramNode classInstanceVariables into: variablesBox  withEmphasis: {TextEmphasis underlined . TextEmphasis italic}.
	self addTextMorphFor: diagramNode classVariables into: variablesBox  withEmphasis: {TextEmphasis underlined}.

]
