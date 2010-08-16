Class {
	#name : #TimelineMorph,
	#superclass : #Morph,
	#instVars : [
		'timeline',
		'messagesMorph',
		'titleBox'
	],
	#category : #'SUML-DiagramDrawing'
}

{ #category : #'as yet unclassified' }
TimelineMorph >> addMessageSend: aMessageSendMorph [
	messagesMorph addMorph: aMessageSendMorph.
	timeline setVertices: 
		(Array 
			with: timeline firstVertex 
			with: ( timeline firstVertex x @ messagesMorph fullBounds bottomCenter y)).
		messagesMorph position: ((titleBox width / 2) - aMessageSendMorph width) @ (titleBox fullBounds bottom + 10)
]

{ #category : #'as yet unclassified' }
TimelineMorph >> distanceTo: anotherMorph [
	^self timelineAbscissa - anotherMorph timelineAbscissa
]

{ #category : #'as yet unclassified' }
TimelineMorph >> initialize [
	super initialize.
	self color: Color transparent.
	self borderColor: Color transparent.
	self clipSubmorphs: false.
	
	titleBox := self newRectangle cellPositioning: #topCenter; height: 25..
	messagesMorph := self newRectangle .
	timeline := (PolygonMorph 
		vertices: (Array with: titleBox bottomCenter with: (titleBox bottomCenter + (0 @ 100)) )
	 	color: Color gray   
		borderWidth: 2
		borderColor: Color lightGray   )
			dashedBorder: { 5 . 10 . Color transparent . 0 . 0 }.
	
	self addMorph: timeline; addMorph: titleBox; addMorph: messagesMorph 
	


]

{ #category : #'as yet unclassified' }
TimelineMorph >> newRectangle [ 
	^RectangleMorph new 
		color: Color transparent; 
		borderColor: Color transparent;
		layoutPolicy: TableLayout new;
		listDirection: #topToBottom;
		cellPositioning:  #topLeft;
		hResizing: #spaceFill; 
		vResizing: #shrinkWrap;
		layoutInset: 5; cellInset: 0;
		cellSpacing: 0;
		width: 15; 
		position: (40@50).
]

{ #category : #'as yet unclassified' }
TimelineMorph >> objectTitle: anObjectName [
	|nameMorph|
	titleBox removeAllMorphs.
	nameMorph := (StringMorph new contents: anObjectName).
	titleBox addMorph: nameMorph.
	
	self width: nameMorph width + 15.
	titleBox  width: nameMorph width + 15.
	timeline setVertices: (Array with: titleBox fullBounds bottomCenter - (1 @ 0) with: ( titleBox bottomCenter  + (-1 @ 100)) ).

]

{ #category : #'as yet unclassified' }
TimelineMorph >> timelineAbscissa [
	^titleBox bottomCenter x
]
