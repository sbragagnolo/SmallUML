Class {
	#name : #ClassDiagram,
	#superclass : #Diagram,
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #'as yet unclassified' }
ClassDiagram class >> inheritanceFor: aClass [
	^(InheritanceDiagramBuilder new buildForClass: aClass ) name: 'Inheritance for ', aClass name
]

{ #category : #adding }
ClassDiagram >> addNewClassDescriptionNamed: aClassName [
	self addDiagramNode: (ClassBox new boxTitle: aClassName )
]

{ #category : #'as yet unclassified' }
ClassDiagram >> copyNodesTo: anotherDiagram [
	self diagramNodes do:[:diagramNode |
		anotherDiagram addDiagramNode: diagramNode]
]

{ #category : #'as yet unclassified' }
ClassDiagram >> notify: aByteString at: aSmallInteger in: aReadStream [ 
	
]
