Class {
	#name : #CategoryDiagramsHolder,
	#superclass : #Object,
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #'as yet unclassified' }
CategoryDiagramsHolder class >> addDiagram: aDiagram [
	^aDiagram category: self category;  saveDescriptionIn: self
]

{ #category : #accessing }
CategoryDiagramsHolder class >> diagramNamed: aName [
	^ (self new perform: aName asSymbol ) category: self category 
]

{ #category : #accessing }
CategoryDiagramsHolder class >> diagrams [
	^ ((self methodsInCategory: 'diagrams') collect: [ :selector | self diagramNamed: selector]) asOrderedCollection 
]

{ #category : #'as yet unclassified' }
CategoryDiagramsHolder class >> openDiagramBrowser [
	^(UMLDiagramWindow on: (CategoryDiagramsModel new model: self)) setLabel: self category; openAsIs; maximize 
]

{ #category : #'as yet unclassified' }
CategoryDiagramsHolder class >> removeDiagram: aDiagram [
	aDiagram deleteDescriptionIn: self
]
