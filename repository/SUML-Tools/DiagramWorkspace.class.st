Class {
	#name : #DiagramWorkspace,
	#superclass : #SHWorkspace,
	#instVars : [
		'model'
	],
	#category : #'SUML-Tools'
}

{ #category : #'as yet unclassified' }
DiagramWorkspace >> acceptContents: aText from: anEditor [
	self model clearRelationshipsOfSelectedDiagramNode.
	anEditor selectAll;  doIt.
	self model acceptContents: aText .
	self acceptContents: aText.
]

{ #category : #'as yet unclassified' }
DiagramWorkspace >> bindingOf: aString [
	^self model bindingOf: aString
]

{ #category : #accessing }
DiagramWorkspace >> descriptionCode [
	^self model selectedDescriptionCode 
]

{ #category : #'as yet unclassified' }
DiagramWorkspace >> doItReceiver [ 
	^model model
]

{ #category : #'as yet unclassified' }
DiagramWorkspace >> hasBindingOf: aString [
	^self model hasBindingOf: aString
]

{ #category : #accessing }
DiagramWorkspace >> model [
	^ model
]

{ #category : #accessing }
DiagramWorkspace >> model: anObject [
	model ifNotNil: [model removeDependent: self].
	anObject ifNotNil: [anObject addDependent: self].
	model := anObject.
	model initializeBindings.
]

{ #category : #'as yet unclassified' }
DiagramWorkspace >> update: aParameter [
	(aParameter = #descriptionCode)
		ifTrue:[self acceptContents: model selectedDescriptionCode].
	self changed: aParameter
]
