Class {
	#name : #UMLConnection,
	#superclass : #Connection,
	#instVars : [
		'label',
		'cardinality'
	],
	#category : #'SUML-DiagramDrawing'
}

{ #category : #'as yet unclassified' }
UMLConnection class >> fromRelation: anUMLRelation forDiagram: aDiagram [
	
]

{ #category : #'as yet unclassified' }
UMLConnection class >> newImplementationAssociation [
	^self newInheritanceAssociation dashedLine: true
]

{ #category : #'as yet unclassified' }
UMLConnection class >> newInheritanceAssociation [
	^(self new)
		name: 'Inheritance';
		arrowNames: #(noArrow openArrow)
]

{ #category : #'as yet unclassified' }
UMLConnection class >> newInstanceAssociation [
	^(self new)
		name: 'Association';
		arrowNames: #(noArrow basicArrow)
]

{ #category : #'as yet unclassified' }
UMLConnection class >> newInstanceUse [
	^self newInstanceAssociation dashedLine: true
]

{ #category : #'as yet unclassified' }
UMLConnection class >> newTraitsUse [
	^(self new)
		name: 'Trait use';
		arrowNames: #(noArrow umlArrow);
		dashedLine: true
]

{ #category : #drawing }
UMLConnection >> clipSubmorphs [ 
	^false
]

{ #category : #'as yet unclassified' }
UMLConnection >> connectionPoints [ 
	^connectionPoints 
]

{ #category : #'as yet unclassified' }
UMLConnection >> dettachFromConnectionPoints [
	self headConnectionPoint dettachFrom: self.
	self tailConnectionPoint dettachFrom: self.
]

{ #category : #'as yet unclassified' }
UMLConnection >> fitIntoDiagram: aDiagram [
	self isConnected ifTrue:[self dettachFromConnectionPoints].
	(aDiagram boxMorphFor: target originBox ) connectTo: (aDiagram boxMorphFor: target destinationBox) using: self.
]

{ #category : #'as yet unclassified' }
UMLConnection >> goesLeft [
	^self headConnectionPoint left < self tailConnectionPoint left
]

{ #category : #'as yet unclassified' }
UMLConnection >> goesRight [
	^self headConnectionPoint left  > self tailConnectionPoint left
]

{ #category : #testing }
UMLConnection >> isConnected [
	^self headConnectionPoint notNil
]

{ #category : #accessing }
UMLConnection >> labelText: aByteString [ 

	label:=  (TransformationMorph new asFlexOf: (ImageMorph fromString: ' ',aByteString,' ' font: (TextFontReference toFont: ((StrikeFont familyName: 'Arial' size: 14)) ) font ) ).
	self addMorph: label.
	label position: label position + (15 @ -10).
]

{ #category : #'stepping and presenter' }
UMLConnection >> step [
	self updateView 
]

{ #category : #testing }
UMLConnection >> stepTime [ 
	^10
]

{ #category : #'view of a model or target' }
UMLConnection >> target: aRelationship [
	aRelationship label ifNotNil:[self labelText: aRelationship label].
	target:= aRelationship 
	
]

{ #category : #'gaucho-created' }
UMLConnection >> updateHeadVertex [
	super updateHeadVertex.
	self updateLabel.
]

{ #category : #other }
UMLConnection >> updateLabel [
| angle newPosition normalizedDirection labelOffset |

    angle:= ((self headConnectionPoint center y - self tailConnectionPoint center y) arcTan: (self tailConnectionPoint  center x - self headConnectionPoint center x) ) .
    self goesRight ifTrue:[angle := angle + Float pi ].
	
    "The angle could be 5pi or other multiples of pi, and we need an offset for the label proportional to the angle between Pi/2 and -Pi/2"
    labelOffset := angle \\ (Float pi * 2). 
    (labelOffset > Float pi) ifTrue: [labelOffset := (Float pi * 2) - labelOffset].
    labelOffset := (labelOffset \\ Float pi) - (Float halfPi).
    labelOffset > 0 ifTrue: [labelOffset := labelOffset - Float halfPi].
    labelOffset := 10 + (((labelOffset sin + 1)* 30) rounded).

label ifNotNil:[
    label angle: angle .

    newPosition := self tailConnectionPoint position.
    normalizedDirection :=(((self curveInfoNearest: (self tailConnectionPoint center)) tangent)) normalized roundTo: 0.1.
    newPosition := newPosition +( normalizedDirection * 40) - (0@labelOffset).
    label center: newPosition.
    label comeToFront. 
    ].
self target oneToMany ifTrue:[
	cardinality ifNil:[cardinality:= StringMorph new contents:'*'. self addMorph: cardinality].
	cardinality ifNotNil:[
		  newPosition := self headConnectionPoint position.
 		  normalizedDirection :=(((self curveInfoNearest: (self headConnectionPoint center)) tangent)) normalized roundTo: 0.1.
		  newPosition := newPosition -( normalizedDirection * 40) - (0@(10 + labelOffset)).
cardinality position: newPosition  ]
]
]

{ #category : #'gaucho-created' }
UMLConnection >> updateTailVertex [
	super updateTailVertex.
	self updateLabel.
]
