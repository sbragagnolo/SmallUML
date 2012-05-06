Class {
	#name : #TreasureQuest,
	#superclass : #Mission,
	#category : #'SUML-ModelExample'
}

{ #category : #'as yet unclassified' }
TreasureQuest >> canUsePirate: aPirate [
	^(super canUsePirate: aPirate) & (aPirate includesItem: #islandMap) & (aPirate includesItem: #compass).
]
