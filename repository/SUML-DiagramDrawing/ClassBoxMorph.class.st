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
ClassBoxMorph >> boxModel: aBoxDescription [
	super boxModel: aBoxDescription.	
	self updateVariables.
]

{ #category : #'as yet unclassified' }
ClassBoxMorph >> defaultBorderStyle [ 
	^BorderStyle thinGray
]

{ #category : #'as yet unclassified' }
ClassBoxMorph >> initializeBoundingBox [
	super initializeBoundingBox.
	boundingBox fillStyle: Color veryLightGray  .
]

{ #category : #accessing }
ClassBoxMorph >> updateVariables [ 
	variablesBox   removeAllMorphs.
	self addTextMorphFor: boxModel instanceVariables into: variablesBox.
	self addTextMorphFor: boxModel classInstanceVariables into: variablesBox  withEmphasis: {TextEmphasis underlined . TextEmphasis italic}.
	self addTextMorphFor: boxModel classVariables into: variablesBox  withEmphasis: {TextEmphasis underlined}.

]
