Class {
	#name : #Mission,
	#superclass : #Object,
	#category : #'SUML-ModelExample'
}

{ #category : #'as yet unclassified' }
Mission >> canUsePirate: aPirate [
	^ aPirate isDrunkEnough
]
