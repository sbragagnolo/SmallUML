Class {
	#name : #DiagramDrawingDocumentation,
	#superclass : #CategoryDiagramsHolder,
	#category : #'SUML-DiagramDrawing'
}

{ #category : #diagrams }
DiagramDrawingDocumentation >> boxdescriptioncode [
	| d interfaceBox classBox traitBox messageSendMorph |
	interfaceBox := ClassBox named: 'InterfaceBox'.
	interfaceBox instanceVariables: #('classMethods' 'classNameForTitle' 'position' 'instanceMethods' 'relations' ).
	interfaceBox instanceMethods: #('relationshipsCode' 'creationAndDefinitionCode' 'creationCode' 'definitionCode' 'descriptionCodeForBoxEdition' 'variableNameForDescriptionCode' 'descriptionCode' 'writeDefinitionDescriptionOn:' 'writeDescription:withValue:on:' 'writeRelationshipsDescriptionOn:' 'writePositioningDescriptionOn:' ).
	interfaceBox classMethods: #('selectorsAsStrings:' 'named:' 'newNamed:' ).
	"Positioning"
	interfaceBox position: 503 @ 43.
	classBox := ClassBox named: 'ClassBox'.
	classBox instanceVariables: #('instanceVariables' 'classInstanceVariables' 'classVariables' ).
	classBox instanceMethods: #('definitionCode' 'descriptionCode' 'descriptionCodeForBoxEdition' 'writeDefinitionDescriptionOn:' ).
	classBox classMethods: #('fromClass:' ).
	"Positioning"
	classBox position: 844 @ 132.
	traitBox := ClassBox named: 'TraitBox'.
	traitBox classMethods: #('fromTrait:' ).
	"Positioning"
	traitBox position: 243 @ 158.
	messageSendMorph := ClassBox named: 'MessageSendMorph'.
	messageSendMorph instanceVariables: #('durationMorph' 'isInitialMessage' 'sentMessageOrigin' 'sentMessageDestination' 'returnValueOrigin' 'returnValueDestination' 'sender' 'returnValueMorph' ).
	messageSendMorph instanceMethods: #('newRectangle' 'isInitialMessage' 'addMessageSend:' 'isInitialMessage:' 'initialize' 'sender:' 'message:toObject:' 'activityMorph' ).
	messageSendMorph classMethods: #('message:from:to:' ).
	"Positioning"
	messageSendMorph position: 14 @ 27.
	"Relationships"
	interfaceBox hasA: classBox labeledAs: 'bleh'.
	"Relationships"
	classBox inheritsFrom: interfaceBox.
	"Relationships"
	traitBox inheritsFrom: interfaceBox.
	d := (ClassDiagram new name: 'Box description code') addDiagramNode: interfaceBox;
				 addDiagramNode: classBox;
				 addDiagramNode: traitBox;
				 addDiagramNode: messageSendMorph.
	^ d
]

{ #category : #diagrams }
DiagramDrawingDocumentation >> connectableShapes [
	| d interfaceBoxMorph connectableShape |
	interfaceBoxMorph := ClassBox named: 'InterfaceBoxMorph'.
	interfaceBoxMorph instanceMethods: #('connectableBoundingBox' ).
	"Positioning"
	interfaceBoxMorph position: 388 @ 301.
	connectableShape := TraitBox named: 'ConnectableShape'.
	connectableShape instanceMethods: #('connectableBoundingBox' 'connectTo:using:' 'connections' 'connectionBorderNear:' ).
	"Positioning"
	connectableShape position: 500 @ 34.
	"Relationships"
	interfaceBoxMorph usesTrait: connectableShape.
	d := (ClassDiagram new name: 'Connectable Shapes') addDiagramNode: interfaceBoxMorph;
				 addDiagramNode: connectableShape.
	^ d
]

{ #category : #diagrams }
DiagramDrawingDocumentation >> objectdiagram [
	| d dos uno fulano |
	dos := ObjectNode named: 'dos'.
	"Positioning"
	dos position: 801 @ 124.
	uno := ObjectNode named: 'uno'.
	"Positioning"
	uno position: 572 @ 118.
	fulano := ObjectNode named: 'Fulano'.
	"Positioning"
	fulano position: 497 @ 315.
	"Relationships"
	dos hasA: uno labeledAs: 'uno'.
	"Relationships"
	fulano hasA: dos labeledAs: 'dos'.
	d := (ObjectDiagram new name: 'objectdiagram') addDiagramNode: dos;
				 addDiagramNode: uno;
				 addDiagramNode: fulano.
	^ d
]

{ #category : #'as yet unclassified' }
DiagramDrawingDocumentation >> otherDiagram [
	 | d first tres|first:= ObjectNode named: 'first'.

"Positioning"
first position: 0@0.

tres:= ObjectNode named: 'tres'.

"Positioning"
tres position: 0@0.

"Relationships"
first hasA:tres labeledAs: 'tres'.

 d := (ObjectDiagram new name: 'lalala') addDiagramNode: first;addDiagramNode: tres.^ d
]
