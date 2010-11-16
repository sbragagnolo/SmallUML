Class {
	#name : #SUMLDiagramWhiteboard,
	#superclass : #DiagramWhiteboard,
	#category : #'SUML-Tools'
}

{ #category : #'as yet unclassified' }
SUMLDiagramWhiteboard >> categoryDiagramsModel [
	^self model
]

{ #category : #'as yet unclassified' }
SUMLDiagramWhiteboard >> diagram [
	^self categoryDiagramsModel model
]

{ #category : #'as yet unclassified' }
SUMLDiagramWhiteboard >> model: anObject [
	model := anObject.
	model ifNotNil: [
		self diagram removeDependent: self.
		model removeDependent: self].
	anObject ifNotNil: [
		.anObject addDependent: self.
		self diagram addDependent: self. ].
	diagramNodes := Dictionary new.
]
