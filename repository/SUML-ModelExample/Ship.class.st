Class {
	#name : #Ship,
	#superclass : #Object,
	#instVars : [
		'mission',
		'tripulation'
	],
	#category : #'SUML-ModelExample'
}

{ #category : #'as yet unclassified' }
Ship >> acceptIntoTripulation: aPirate [
	(aPirate isUsefulForTheMission: mission)
		ifTrue: [tripulation add: aPirate].
	tripulation anySatisfy: [:p | p isDrunkEnough ]
]

{ #category : #'as yet unclassified' }
Ship >> canPerformMission [
	self flag: #todo.
	^ self tripulationIsBigEnough & (mission canBeAccomplishedBy: self)
]

{ #category : #'as yet unclassified' }
Ship >> initialize [ 
	tripulation := Set new.
]

{ #category : #'as yet unclassified' }
Ship >> mission: aMission [
	mission := aMission 
]
