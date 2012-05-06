Class {
	#name : #BecomeALegend,
	#superclass : #Mission,
	#category : #'SUML-ModelExample'
}

{ #category : #'as yet unclassified' }
BecomeALegend >> canUsePirate: aPirate [
	^(super canUsePirate: aPirate) & aPirate hasMoreItemsThan: 10.
]
