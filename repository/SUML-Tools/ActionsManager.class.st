Class {
	#name : #ActionsManager,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'SUML-Tools'
}

{ #category : #'as yet unclassified' }
ActionsManager class >> for: aModel [
	^self new model: aModel 
]

{ #category : #accessing }
ActionsManager >> model [
	^ model
]

{ #category : #accessing }
ActionsManager >> model: anObject [
	model := anObject
]

{ #category : #'as yet unclassified' }
ActionsManager >> request: aTitle default: aDefaultValue [
	^UIManager default
		request: aTitle
		initialAnswer: aDefaultValue
]
