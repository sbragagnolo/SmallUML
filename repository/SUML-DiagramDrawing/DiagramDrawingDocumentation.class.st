Class {
	#name : #DiagramDrawingDocumentation,
	#superclass : #CategoryDiagramsHolder,
	#category : #'SUML-DiagramDrawing'
}

{ #category : #diagrams }
DiagramDrawingDocumentation >> boxdescriptioncode [
	| d interfaceBox classBox traitBox |
	interfaceBox := ClassBox named: 'InterfaceBox'.
	interfaceBox instanceVariables: #('classMethods' 'classNameForTitle' 'position' 'instanceMethods' 'relations' ).
	interfaceBox instanceMethods: #('relationshipsCode' 'creationAndDefinitionCode' 'creationCode' 'definitionCode' 'descriptionCodeForBoxEdition' 'variableNameForDescriptionCode' 'descriptionCode' 'writeDefinitionDescriptionOn:' 'writeDescription:withValue:on:' 'writeRelationshipsDescriptionOn:' 'writePositioningDescriptionOn:' ).
	interfaceBox classMethods: #('selectorsAsStrings:' 'named:' 'newNamed:' ).
	"Positioning"
	interfaceBox position: 432 @ 30.
	classBox := ClassBox named: 'ClassBox'.
	classBox instanceVariables: #('instanceVariables' 'classInstanceVariables' 'classVariables' ).
	classBox instanceMethods: #('definitionCode' 'descriptionCode' 'descriptionCodeForBoxEdition' 'writeDefinitionDescriptionOn:' ).
	classBox classMethods: #('fromClass:' ).
	"Positioning"
	classBox position: 908 @ 129.
	traitBox := ClassBox named: 'TraitBox'.
	traitBox classMethods: #('fromTrait:' ).
	"Positioning"
	traitBox position: 89 @ 177.
	"Relationships"
	classBox inheritsFrom: interfaceBox.
	"Relationships"
	traitBox inheritsFrom: interfaceBox.
	d := (ClassDiagram new name: 'Box description code') addBoxDescription: interfaceBox;
				 addBoxDescription: classBox;
				 addBoxDescription: traitBox.
	^ d
]

{ #category : #diagrams }
DiagramDrawingDocumentation >> connectableShapes [
	| d interfaceBoxMorph connectableShape |
	interfaceBoxMorph := ClassBox named: 'InterfaceBoxMorph'.
	interfaceBoxMorph instanceMethods: #('connectableBoundingBox' ).
	"Positioning"
	interfaceBoxMorph position: 513 @ 337.
	connectableShape := TraitBox named: 'ConnectableShape'.
	connectableShape instanceMethods: #('connectableBoundingBox' 'connectTo:using:' 'connections' 'connectionBorderNear:' ).
	"Positioning"
	connectableShape position: 442 @ 160.
	"Relationships"
	interfaceBoxMorph usesTrait: connectableShape.
	d := (ClassDiagram new name: 'Connectable Shapes') addBoxDescription: interfaceBoxMorph;
				 addBoxDescription: connectableShape.
	^ d
]
