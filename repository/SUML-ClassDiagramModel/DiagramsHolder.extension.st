Extension { #name : #DiagramsHolder }

{ #category : #'*SUML-ClassDiagramModel' }
DiagramsHolder >> diagramsModel [
	| d diagramNode interfaceBox classBox traitBox relationship |
	diagramNode := ClassBox named: 'DiagramNode'.
	diagramNode instanceVariables: #('position' 'relations' 'name' ).
	diagramNode instanceMethods: #('relations' 'addRelationship:' ).
	diagramNode classMethods: #('named:' ).
	"named:"
	diagramNode position: 424.0 @ 74.0.
	interfaceBox := ClassBox named: 'InterfaceBox'.
	interfaceBox instanceVariables: #('classMethods' 'instanceMethods' ).
	interfaceBox instanceMethods: #('inheritsFromClass:' 'boxTitle:' 'classMethods:' 'instanceMethods:' 'usesTrait:' 'boxTitle' 'classMethods' 'relateIfPossibleTo:' 'isATypeOf:' 'instanceMethods     ' ).
	interfaceBox classMethods: #('newNamed:' ).
	"newNamed:"
	interfaceBox position: 216.0 @ 10.0.
	classBox := ClassBox named: 'ClassBox'.
	classBox instanceVariables: #('instanceVariables' 'classInstanceVariables' 'classVariables' 'targetClass' ).
	classBox instanceMethods: #('classVariables' 'usesLotsOf:' 'hasLotsOf:labeledAs:' 'instanceVariables' 'classMethods:' 'relateIfPossibleToTrait:' 'relateIfPossibleToClass:' 'classInstanceVariables' 'isATypeOf:' 'classInstanceVariables:' 'instanceMethods' 'variables' 'usesA:' 'instanceVariables:' 'instanceMethods:' 'hasA:labeledAs:' 'classVariables:' 'classMethods' 'relateIfPossibleTo:' 'inheritsFromClass:' 'implements:                              ' ).
	classBox classMethods: #('fromClass:' ).
	"fromClass:"
	classBox position: 24.0 @ 475.0.
	traitBox := ClassBox named: 'TraitBox'.
	traitBox instanceMethods: #('relateIfPossibleToTrait:' 'relateIfPossibleToClass:' 'relateIfPossibleTo:' ).
	traitBox classMethods: #('fromTrait:' ).
	"fromTrait:"
	traitBox position: 293.0 @ 472.0.
	relationship := ClassBox named: 'Relationship'.
	relationship instanceVariables: #('label' 'from' 'to' ).
	relationship instanceMethods: #('from:to:' 'destinationDiagramNode' 'oneToMany' 'originDiagramNode' 's' ).
	relationship classMethods: #('inheritanceRelationshipFrom:to:' 'useRelationshipFrom:to:' 'from:to:' 'useTraitRelationshipFrom:to:' 'implementationRelationshipFrom:to:' 'associationRelationshipFrom:to:labeledAs:' ).
	"associationRelationshipFrom:to:labeledAs:"
	relationship position: 724.0 @ 12.0.
	"position:"
	diagramNode hasLotsOf: relationship labeledAs: 'relations'.
	"relations"
	interfaceBox inheritsFromClass: diagramNode.
	"diagramNode"
	classBox inheritsFromClass: interfaceBox.
	"interfaceBox"
	traitBox inheritsFromClass: interfaceBox.
	"interfaceBox"
	relationship hasA: diagramNode labeledAs: 'from'.
	relationship hasA: diagramNode labeledAs: 'to'.
	d := (ClassDiagram new name: 'Diagrams Model') addDiagramNode: diagramNode;
				 addDiagramNode: interfaceBox;
				 addDiagramNode: classBox;
				 addDiagramNode: traitBox;
				 addDiagramNode: relationship.
	^ d
]
