Class {
	#name : #Pirate,
	#superclass : #Object,
	#instVars : [
		'items',
		'alcoholLevel'
	],
	#category : #'SUML-ModelExample'
}

{ #category : #'as yet unclassified' }
Pirate >> alcoholLevel: aNumber [
	alcoholLevel := aNumber 
]

{ #category : #'as yet unclassified' }
Pirate >> includesItem: anItem [
	^ items includes: anItem 
]

{ #category : #'as yet unclassified' }
Pirate >> isDrunkEnough [ 
	^ alcoholLevel > 0.5
]

{ #category : #'as yet unclassified' }
Pirate >> isUsefulForTheMission: aMission [
	^ aMission canUsePirate: self
]

{ #category : #'as yet unclassified' }
Pirate >> items: aCollection [
	items := aCollection
]
