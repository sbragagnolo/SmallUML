Class {
	#name : #DiagramModelDocumentation,
	#superclass : #CategoryDiagramsHolder,
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #diagrams }
DiagramModelDocumentation >> inheritanceforRelationship [
	| d relationship implementationRelationship inheritanceRelationship instanceRelationship associationRelationship referenceRelationship useRelationship useTraitRelationship |
	relationship := ClassBox named: 'Relationship'.
	relationship instanceVariables: #('label' 'from' 'to' ).
	relationship instanceMethods: #('originDiagramNode' 'arrow' 'from:to:' 'connects:' 'oneToMany' 'label' 'destinationDiagramNode' 'view' 'label:' ).
	"Positioning"
	relationship position: 267 @ 62.
	implementationRelationship := ClassBox named: 'ImplementationRelationship'.
	implementationRelationship instanceMethods: #('arrow' ).
	"Positioning"
	implementationRelationship position: 463 @ 393.
	inheritanceRelationship := ClassBox named: 'InheritanceRelationship'.
	inheritanceRelationship instanceMethods: #('arrow' ).
	"Positioning"
	inheritanceRelationship position: 38 @ 354.
	instanceRelationship := ClassBox named: 'InstanceRelationship'.
	instanceRelationship instanceVariables: #('oneToMany' ).
	instanceRelationship instanceMethods: #('oneToMany' 'oneToMany:' ).
	"Positioning"
	instanceRelationship position: 850 @ 453.
	associationRelationship := ClassBox named: 'AssociationRelationship'.
	associationRelationship instanceMethods: #('arrow' ).
	"Positioning"
	associationRelationship position: 934 @ 111.
	referenceRelationship := ClassBox named: 'ReferenceRelationship'.
	referenceRelationship instanceMethods: #('arrow' ).
	"Positioning"
	referenceRelationship position: 650 @ 112.
	useRelationship := ClassBox named: 'UseRelationship'.
	useRelationship instanceMethods: #('arrow' ).
	"Positioning"
	useRelationship position: 1061 @ 292.
	useTraitRelationship := ClassBox named: 'UseTraitRelationship'.
	useTraitRelationship instanceMethods: #('arrow' ).
	"Positioning"
	useTraitRelationship position: 251 @ 406.
	"Relationships"
	implementationRelationship inheritsFrom: relationship.
	"Relationships"
	inheritanceRelationship inheritsFrom: relationship.
	"Relationships"
	instanceRelationship inheritsFrom: relationship.
	"Relationships"
	associationRelationship inheritsFrom: instanceRelationship.
	"Relationships"
	referenceRelationship inheritsFrom: associationRelationship.
	"Relationships"
	useRelationship inheritsFrom: instanceRelationship.
	"Relationships"
	useTraitRelationship inheritsFrom: relationship.
	d := (ClassDiagram new name: 'Inheritance for Relationship') addDiagramNode: relationship;
				 addDiagramNode: implementationRelationship;
				 addDiagramNode: inheritanceRelationship;
				 addDiagramNode: instanceRelationship;
				 addDiagramNode: associationRelationship;
				 addDiagramNode: referenceRelationship;
				 addDiagramNode: useRelationship;
				 addDiagramNode: useTraitRelationship.
	^ d
]

{ #category : #diagrams }
DiagramModelDocumentation >> structureofaDiagram [
	| d diagramNode objectNode interfaceBox traitBox classBox diagram relationship |
	diagramNode := ClassBox named: 'DiagramNode'.
	diagramNode instanceVariables: #('position' 'relations' 'name' ).
	diagramNode instanceMethods: #('connectTo:using:' 'removeRelationship:' 'definitionCode' 'addRelationship:' 'removeRelationshipsWith:name' ).
	diagramNode classMethods: #('named:' ).
	"Positioning"
	diagramNode position: 358 @ 67.
	objectNode := ClassBox named: 'ObjectNode'.
	objectNode instanceVariables: #('object' ).
	objectNode instanceMethods: #('object:' 'updaterClass' 'object' 'hash' 'subject' 'variableNames' 'hasA:labeledAs:' '=' 'label' 'resetConnections' 'view' 'variableNamed:' 'descriptionCodeForEdition' 'connectToReferencesWithin:' 'realDiagramNode' ).
	objectNode classMethods: #('for:' ).
	"Positioning"
	objectNode position: 225 @ 353.
	interfaceBox := ClassBox named: 'InterfaceBox'.
	interfaceBox instanceVariables: #('classMethods' 'instanceMethods' ).
	interfaceBox instanceMethods: #('updaterClass' 'openDescriptionCode' 'instanceMethods:' 'instanceMethods' 'methods' 'boxTitle' 'classMethods' 'height' 'usesTrait:' 'descriptionCode' 'boxTitle:' 'isATypeOf:' 'classMethods:' 'view' 'inheritsFrom:' 'realDiagramNode' 'writeDescription:withValue:on:' 'writeDefinitionDescriptionOn:' ).
	interfaceBox classMethods: #('selectorsAsStrings:' 'newNamed:' ).
	"Positioning"
	interfaceBox position: 476 @ 350.
	traitBox := ClassBox named: 'TraitBox'.
	traitBox instanceMethods: #('view' ).
	traitBox classMethods: #('fromTrait:' ).
	"Positioning"
	traitBox position: 782 @ 340.
	classBox := ClassBox named: 'ClassBox'.
	classBox instanceVariables: #('instanceVariables' 'classInstanceVariables' 'classVariables' 'targetClass' ).
	classBox instanceMethods: #('instanceMethods' 'classVariables' 'implements:' 'height' 'subject' 'classInstanceVariables' 'instanceVariables:' 'classMethods:' 'variables' 'instanceVariables' 'updaterClass' 'instanceMethods:' 'classMethods' 'classInstanceVariables:' 'hasA:labeledAs:' 'targetClass:' 'usesLotsOf:labeledAs:' 'descriptionCode' 'usesA:labeledAs:' 'view' 'isATypeOf:' 'descriptionCodeForEdition' 'inheritsFrom:' 'hasLotsOf:labeledAs:' 'classVariables:' 'writeDefinitionDescriptionOn:' ).
	classBox classMethods: #('fromClass:' ).
	"Positioning"
	classBox position: 954 @ 404.
	diagram := ClassBox named: 'Diagram'.
	diagram instanceVariables: #('category' 'name' 'description' ).
	diagram instanceMethods: #('removeDiagramNode:' 'diagramNodeFor:' 'addDiagramNode:' 'diagramNodes:' 'includesDiagramNodeFor:' 'diagramNodes' 'description:' ).
	diagram classMethods: #('inheritanceFor:' ).
	"Positioning"
	diagram position: 32 @ 57.
	relationship := ClassBox named: 'Relationship'.
	relationship instanceVariables: #('label' ).
	relationship instanceMethods: #('originDiagramNode' 'arrow' 'from:to:' 'connects:' 'oneToMany' 'label' 'destinationDiagramNode' 'label:' ).
	relationship classMethods: #('associationRelationshipFrom:to:labeledAs:' 'implementationRelationshipFrom:to:' 'inheritanceRelationshipFrom:to:' 'from:to:' 'useRelationshipFrom:to:labeledAs:' 'useTraitRelationshipFrom:to:' ).
	"Positioning"
	relationship position: 926 @ 58.
	"Relationships"
	diagramNode hasLotsOf: relationship labeledAs: 'relations'.
	"Relationships"
	objectNode inheritsFrom: diagramNode.
	"Relationships"
	interfaceBox inheritsFrom: diagramNode.
	"Relationships"
	traitBox inheritsFrom: interfaceBox.
	"Relationships"
	classBox inheritsFrom: interfaceBox.
	"Relationships"
	diagram hasLotsOf: diagramNode labeledAs: 'diagramNodes'.
	"Relationships"
	relationship hasA: diagramNode labeledAs: 'from'.
	relationship hasA: diagramNode labeledAs: 'to'.
	d := (ClassDiagram new name: 'Structure of a Diagram') addDiagramNode: diagramNode;
				 addDiagramNode: objectNode;
				 addDiagramNode: interfaceBox;
				 addDiagramNode: traitBox;
				 addDiagramNode: classBox;
				 addDiagramNode: diagram;
				 addDiagramNode: relationship.
	^ d
]