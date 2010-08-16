Class {
	#name : #CategoryDiagramsHolder,
	#superclass : #Object,
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #'as yet unclassified' }
CategoryDiagramsHolder class >> addDiagram: aDiagram [
	^aDiagram saveDescriptionIn: self
]

{ #category : #accessing }
CategoryDiagramsHolder class >> diagrams [
	| diagramHolder |
	diagramHolder := self new.
	^ (self methodsInCategory: 'diagrams') collect: [ :selector | (diagramHolder perform: selector) category: self category ]
]

{ #category : #'as yet unclassified' }
CategoryDiagramsHolder class >> openDiagramBrowser [
	^(UMLDiagramWindow on: (CategoryDiagramsModel new model: self)) setLabel: self category; openAsIs; maximize 
]

{ #category : #'as yet unclassified' }
CategoryDiagramsHolder class >> removeDiagram: aDiagram [
	aDiagram deleteDescriptionIn: self
]
