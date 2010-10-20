Class {
	#name : #ClassDiagram,
	#superclass : #Diagram,
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #adding }
ClassDiagram >> addNewClassDescriptionNamed: aClassName [
	self addDiagramNode: (ClassBox new boxTitle: aClassName )
]
