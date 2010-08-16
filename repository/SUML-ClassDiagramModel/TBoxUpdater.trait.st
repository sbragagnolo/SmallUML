Trait {
	#name : #TBoxUpdater,
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #'as yet unclassified' }
TBoxUpdater >> clearRelationships [
	self relations: OrderedCollection new.
]

{ #category : #'as yet unclassified' }
TBoxUpdater >> printString [ 
	^self realBox printString 
]

{ #category : #accessing }
TBoxUpdater >> realBox: anObject [
	realBox := anObject.
	self initializeFrom: anObject 
]

{ #category : #'as yet unclassified' }
TBoxUpdater >> realRelationships [
	^self relations collect:[:rel | self relationBetweenRealClassBoxes: rel]
]

{ #category : #'as yet unclassified' }
TBoxUpdater >> relationBetweenRealClassBoxes: aRelation [
	^(aRelation  from: aRelation classBoxOrigin realBox to: aRelation classBoxDestination realBox )
]

{ #category : #'as yet unclassified' }
TBoxUpdater >> relations: aCollection [
	relations := aCollection 
]

{ #category : #'as yet unclassified' }
TBoxUpdater >> updateRealBox [
	"The real class box isn't updated directly because the relations have to be administrated'"
	self updateBoxDefinition.

	(self realRelationships difference: self realBox relations) do: [:relation | self realBox addRelationship: (self relationBetweenRealClassBoxes: relation)].
	(self realBox relations difference: self realRelationships) do: [:relation | self realBox removeRelationship: relation].

	
]
