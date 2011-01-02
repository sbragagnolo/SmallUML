Class {
	#name : #TransparentNewTextMorph,
	#superclass : #NewTextMorph,
	#category : #'SUML-DiagramDrawing'
}

{ #category : #accessing }
TransparentNewTextMorph >> borderStyle [
	^self hasKeyboardFocus
		ifTrue:[^self defaultBorderStyle ]
		ifFalse:[^BorderStyle color: Color red width: 0. ]
]

{ #category : #'as yet unclassified' }
TransparentNewTextMorph >> fillStyle [
	^Color transparent 
]

{ #category : #'as yet unclassified' }
TransparentNewTextMorph >> keyStroke: evt [
	super keyStroke: evt.
	(evt keyValue = 115) "Cmd-S"
		ifTrue:[self acceptContents ]
]
