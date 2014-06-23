Class {
	#name : #MessageSendMorph,
	#superclass : #Morph,
	#instVars : [
		'durationMorph',
		'isInitialMessage',
		'sentMessageOrigin',
		'sentMessageDestination',
		'returnValueOrigin',
		'returnValueDestination',
		'sender',
		'returnValueMorph'
	],
	#category : #'SUML-DiagramDrawing'
}

{ #category : #'as yet unclassified' }
MessageSendMorph class >> message: aSequenceMessage from: anObjectTimeline to: anotherObjectTimeline [
	^self new initialize sender: anObjectTimeline ; message: aSequenceMessage toObject: anotherObjectTimeline  
]

{ #category : #'as yet unclassified' }
MessageSendMorph >> activityMorph [
^ self newRectangle
	 color: Color white;
	 borderColor: (Color r: 150 g: 150 b: 150);
	 borderWidth: 2;
	 width: 15;
	 height: 40;
	listDirection: #topToBottom;
	 useRoundedCorners.
]

{ #category : #'as yet unclassified' }
MessageSendMorph >> addMessageSend: aMessageSend [
	durationMorph addMorph: aMessageSend. 
	
	returnValueOrigin position:  durationMorph fullBounds bottomLeft - (0 @ 5) .
	returnValueDestination position: (self bottomLeft x @ (durationMorph fullBounds bottomLeft y - 5)) .
	returnValueMorph bottomRight: returnValueOrigin position.
	
	returnValueDestination updateView.
	returnValueOrigin updateView.
]

{ #category : #'as yet unclassified' }
MessageSendMorph >> initialize [ 
	super initialize.
	self width: 15.
	self color: Color transparent.
	self clipSubmorphs: false.
	self isInitialMessage: false.
	
	durationMorph := self activityMorph.
	self addMorph: durationMorph.
	
	sentMessageOrigin := SingleConnectionPoint new.
	sentMessageOrigin position: (self topLeft + ((durationMorph width / 2) @ 5)).
	
	
	
]

{ #category : #accessing }
MessageSendMorph >> isInitialMessage [
	^ isInitialMessage
]

{ #category : #accessing }
MessageSendMorph >> isInitialMessage: anObject [
	isInitialMessage := anObject
]

{ #category : #'as yet unclassified' }
MessageSendMorph >> message: aSequenceMessage toObject: anObjectTimeline [
	| messageLabelMorph |
	durationMorph position: ((anObjectTimeline distanceTo: sender)   @ self topLeft y).
	
	sentMessageDestination := SingleConnectionPoint new.
	sentMessageDestination position: durationMorph topLeft + (0 @ 5).
	returnValueOrigin := SingleConnectionPoint new.
	returnValueOrigin position: (durationMorph topLeft x @ (durationMorph bottomLeft y - 5)) .
	returnValueDestination := SingleConnectionPoint new.
	returnValueDestination position: ((self topLeft x + (durationMorph width / 2)) @ (durationMorph bottomLeft y - 5)) .
	
	"self addMorph: sentMessageOrigin ; addMorph: returnValueOrigin .
	anObjectTimeline addMorph: sentMessageDestination ; addMorph: returnValueDestination ."
	
	self addMorph: (Connection newWithArrow lineWidth: 1; from: sentMessageOrigin to: sentMessageDestination ).
	self addMorph: (Connection newWithArrow lineWidth: 1; from: returnValueOrigin  to: returnValueDestination  ). 
	
	messageLabelMorph :=  (StringMorph new contents: aSequenceMessage message; bottomLeft: sentMessageOrigin position + (3 @ 0)  ).
	sentMessageOrigin addMorph: messageLabelMorph. self addMorph: messageLabelMorph.
	
	returnValueMorph:= StringMorph new contents: aSequenceMessage returnValue; bottomRight: returnValueOrigin position.
	returnValueOrigin addMorph: returnValueMorph. self addMorph: returnValueMorph 
	
	
	
]

{ #category : #'as yet unclassified' }
MessageSendMorph >> newRectangle [
	^ (BorderedMorph new)
		color: Color white;
		borderColor: (Color r: 100 g: 100 b: 100);
		borderWidth: 2;
		width: 15;
		height: 40;
		layoutPolicy: TableLayout new;
		cellPositioning: #topLeft;
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		layoutInset: 5;
		cellInset: 2;
		listDirection: #topToBottom;
		useRoundedCorners
]

{ #category : #accessing }
MessageSendMorph >> sender: anObjectTimeline [
	sender:= anObjectTimeline 
]
