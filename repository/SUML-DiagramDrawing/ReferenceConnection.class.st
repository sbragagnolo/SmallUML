Class {
	#name : #ReferenceConnection,
	#superclass : #UMLConnection,
	#category : #'SUML-DiagramDrawing'
}

{ #category : #'as yet unclassified' }
ReferenceConnection class >> newReference [
	^(self new)
		name: 'Reference';
		arrowNames: #(noArrow basicArrow)
]

{ #category : #'as yet unclassified' }
ReferenceConnection >> connectionPoints: aCollection [
	| middle |
	super connectionPoints: aCollection.
	middle:= (self tailConnectionPoint position + self headConnectionPoint position) / 2 .
	"A nice math thinking is lacking here"
	middle := middle + (middle normal + 20 "* (1.1 to: 5.0) atRandom").
	self vertices: {self headConnectionPoint position . middle . self tailConnectionPoint position}
]

{ #category : #'as yet unclassified' }
ReferenceConnection >> initialize [ 
	super initialize.
	self beSmoothCurve.
]

{ #category : #'as yet unclassified' }
ReferenceConnection >> updateLabel [
| angle newPosition normalizedDirection labelOffset |

    angle:= ((self headConnectionPoint center y - self tailConnectionPoint center y) arcTan: (self tailConnectionPoint  center x - self headConnectionPoint center x) ) .
    self goesRight ifTrue:[angle := angle + Float pi ].
	
    "The angle could be 5pi or other multiples of pi, and we need an offset for the label proportional to the angle between Pi/2 and -Pi/2"
    labelOffset := angle \\ (Float pi * 2). 
    (labelOffset > Float pi) ifTrue: [labelOffset := (Float pi * 2) - labelOffset].
    labelOffset := (labelOffset \\ Float pi) - (Float halfPi).
    labelOffset > 0 ifTrue: [labelOffset := labelOffset - Float halfPi].
    labelOffset := 10 + (((labelOffset sin + 1) * 30) rounded).

label ifNotNil:[
    label angle: angle .

    newPosition := self tailConnectionPoint position.
    normalizedDirection :=(((self curveInfoNearest: (self tailConnectionPoint center)) tangent)) normalized roundTo: 0.1.
    newPosition := newPosition +( normalizedDirection * 50) - (0@labelOffset).
    label position: newPosition.
    label comeToFront. 
    ].

]
