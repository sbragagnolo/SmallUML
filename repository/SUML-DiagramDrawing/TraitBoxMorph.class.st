Class {
	#name : #TraitBoxMorph,
	#superclass : #InterfaceBoxMorph,
	#category : #'SUML-DiagramDrawing'
}

{ #category : #'as yet unclassified' }
TraitBoxMorph >> initializeBoundingBox [
	super initializeBoundingBox.
	boundingBox fillStyle: Color veryLightGray .
]
