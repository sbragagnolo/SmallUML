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
ReferenceConnection >> center [
	^(connectionPoints at:1) position + (connectionPoints at:2) position // 2
]

{ #category : #'as yet unclassified' }
ReferenceConnection >> mouseDown: evt [
]

{ #category : #'as yet unclassified' }
ReferenceConnection >> updateLabel [
| angle newPosition normalizedDirection labelOffset xOffset objectNode|

   angle:= ((self headConnectionPoint center y - self tailConnectionPoint center y) arcTan: (self tailConnectionPoint  center x - self headConnectionPoint center x) ) .
    self goesRight ifTrue:[angle := angle + Float pi ].
	
    "The angle could be 5pi or other multiples of pi, and we need an offset for the label proportional to the angle between Pi/2 and -Pi/2"
   " labelOffset := angle \\ (Float pi * 2). 
    (labelOffset > Float pi) ifTrue: [labelOffset := (Float pi * 2) - labelOffset].
    labelOffset := (labelOffset \\ Float pi) - (Float halfPi).
    labelOffset > 0 ifTrue: [labelOffset := labelOffset - Float halfPi].
    labelOffset := objectNode height /2 + (((labelOffset sin + 1)* 30) roundTo:0.1)..
"
label ifNotNil:[
	label center: self center" +  (15 @ 10)".
    label angle: angle .
   " newPosition := self tailConnectionPoint position roundTo: 0.1.
    normalizedDirection :=(((self curveInfoNearest: (self tailConnectionPoint center)) tangent)) normalized roundTo: 0.1.
    xOffset := objectNode width / 2.
    self goesRight ifTrue:[xOffset := xOffset negated ].

 newPosition := newPosition +( normalizedDirection * 50 * (label width / 100)) -  (xOffset @labelOffset).

	label center: newPosition."
	
	
    label comeToFront. 
    ].


owner goBehind.
label comeToFront 

]
