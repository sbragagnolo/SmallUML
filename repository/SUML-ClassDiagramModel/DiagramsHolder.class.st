Class {
	#name : #DiagramsHolder,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #'as yet unclassified' }
DiagramsHolder class >> addDiagram: aDiagram [
	^aDiagram category: self category;  saveDescriptionIn: self
]

{ #category : #'as yet unclassified' }
DiagramsHolder class >> categoryModel [
	^CategoryDiagramsModel new model: self
]

{ #category : #accessing }
DiagramsHolder class >> diagramNamed: aName [
	^ (self new perform: aName asSymbol ) category: self category 
]

{ #category : #accessing }
DiagramsHolder class >> diagrams [
	^ ("(self methodsInCategory: 'diagrams')" self selectors collect: [ :selector | self diagramNamed: selector]) asOrderedCollection 
]

{ #category : #'as yet unclassified' }
DiagramsHolder class >> openDiagramBrowser [
	^self openDiagramBrowserForModel: self categoryModel 
]

{ #category : #'as yet unclassified' }
DiagramsHolder class >> openDiagramBrowserForModel: aModel [
	^(UMLDiagramWindow on: aModel) setLabel: self category; openAsIs; maximize 
]

{ #category : #'as yet unclassified' }
DiagramsHolder class >> openDiagramBrowserSelecting: aDiagramName [
	^self openDiagramBrowserForModel: (self categoryModel selectDiagramByName: aDiagramName )
]

{ #category : #nil }
DiagramsHolder class >> prettyPrinterClass [
  	^ OpalCompiler
]

{ #category : #'as yet unclassified' }
DiagramsHolder class >> removeDiagram: aDiagram [
	aDiagram deleteDescriptionIn: self
]

{ #category : #nil }
DiagramsHolder class >> uniqueInstance [ 
	^uniqueInstance ifNil:[uniqueInstance := self new].
]

{ #category : #'*SUML-ClassDiagramModel' }
DiagramsHolder >> diagramsModel [
	| d diagramNode interfaceBox classBox traitBox relationship |
	diagramNode := ClassBox named: 'DiagramNode'.
	diagramNode instanceVariables: #('position' 'relations' 'name').
	diagramNode instanceMethods: #('relations' 'addRelationship:').
	diagramNode classMethods: #('named:').	"Positioning"
	diagramNode position: 424.0 @ 74.0.
	interfaceBox := ClassBox named: 'InterfaceBox'.
	interfaceBox instanceVariables: #('classMethods' 'instanceMethods').
	interfaceBox
		instanceMethods:
			#('inheritsFromClass:' 'boxTitle:' 'classMethods:' 'instanceMethods:' 'usesTrait:' 'boxTitle' 'classMethods' 'relateIfPossibleTo:' 'isATypeOf:' 'instanceMethods     ').
	interfaceBox classMethods: #('newNamed:').	"Positioning"
	interfaceBox position: 216.0 @ 10.0.
	classBox := ClassBox named: 'ClassBox'.
	classBox instanceVariables: #('instanceVariables' 'classInstanceVariables' 'classVariables' 'targetClass').
	classBox
		instanceMethods:
			#('classVariables' 'usesLotsOf:' 'hasLotsOf:labeledAs:' 'instanceVariables' 'classMethods:' 'relateIfPossibleToTrait:' 'relateIfPossibleToClass:' 'classInstanceVariables' 'isATypeOf:' 'classInstanceVariables:' 'instanceMethods' 'variables' 'usesA:' 'instanceVariables:' 'instanceMethods:' 'hasA:labeledAs:' 'classVariables:' 'classMethods' 'relateIfPossibleTo:' 'inheritsFromClass:' 'implements:                              ').
	classBox classMethods: #('fromClass:').	"Positioning"
	classBox position: 24.0 @ 475.0.
	traitBox := ClassBox named: 'TraitBox'.
	traitBox instanceMethods: #('relateIfPossibleToTrait:' 'relateIfPossibleToClass:' 'relateIfPossibleTo:').
	traitBox classMethods: #('fromTrait:').	"Positioning"
	traitBox position: 293.0 @ 472.0.
	relationship := ClassBox named: 'Relationship'.
	relationship instanceVariables: #('label' 'from' 'to').
	relationship instanceMethods: #('from:to:' 'destinationDiagramNode' 'oneToMany' 'originDiagramNode' 's').
	relationship
		classMethods:
			#('inheritanceRelationshipFrom:to:' 'useRelationshipFrom:to:' 'from:to:' 'useTraitRelationshipFrom:to:' 'implementationRelationshipFrom:to:' 'associationRelationshipFrom:to:labeledAs:').	"Positioning"
	relationship position: 724.0 @ 12.0.	"Relationships"
	diagramNode hasLotsOf: relationship labeledAs: 'relations'.	"Relationships"
	interfaceBox inheritsFromClass: diagramNode.	"Relationships"
	classBox inheritsFromClass: interfaceBox.	"Relationships"
	traitBox inheritsFromClass: interfaceBox.	"Relationships"
	relationship hasA: diagramNode labeledAs: 'from'.
	relationship hasA: diagramNode labeledAs: 'to'.
	d := (ClassDiagram new name: 'Diagrams Model')
		addDiagramNode: diagramNode;
		addDiagramNode: interfaceBox;
		addDiagramNode: classBox;
		addDiagramNode: traitBox;
		addDiagramNode: relationship.
	^ d
]
