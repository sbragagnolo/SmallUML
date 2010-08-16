Class {
	#name : #InterfaceBoxMorph,
	#superclass : #Morph,
	#traits : 'TConnectableShape',
	#classTraits : 'TConnectableShape classTrait',
	#instVars : [
		'container',
		'methodsBox',
		'boundingBox',
		'boxModel',
		'titleBox'
	],
	#category : #'SUML-DiagramDrawing'
}

{ #category : #'as yet unclassified' }
InterfaceBoxMorph class >> forBox: aBox [
	^self new boxModel: aBox 
]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> addBoxesToContainer [
	methodsBox := self newRectangle.
	titleBox := self newRectangle cellPositioning:  #topCenter.
	container addMorph: methodsBox ; addMorph: titleBox.
]

{ #category : #accessing }
InterfaceBoxMorph >> addTextMorphFor: aCollectionOfStrings into: aMorph [
	^aCollectionOfStrings ifNotEmpty: [ aMorph addMorph: (self textMorphFor: aCollectionOfStrings) ] ifEmpty: [nil]
]

{ #category : #accessing }
InterfaceBoxMorph >> addTextMorphFor: aCollectionOfStrings into: aMorph withEmphasis: anEmphasis [ 
	^aCollectionOfStrings ifNotEmpty: [ aMorph addMorph: (self textMorphFor: aCollectionOfStrings withEmphasis: anEmphasis ) ] ifEmpty: [nil]
]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> boxModel: aBoxDescription [
	boxModel := aBoxDescription.
	
	boxModel ifNotNil: [boxModel removeDependent: self].
	aBoxDescription ifNotNil: [aBoxDescription addDependent: self].
	
	self updateTitle.
	self updateMethods.
	self position: self position.
	self updateBounds.
]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> connectTo: anotherBox using: aConnection [
	| origin destination |
	origin := SingleConnectionPoint new.
	destination := SingleConnectionPoint new.
	self connectableBoundingBox addConnectionPoint: origin thatConnectsTo: anotherBox.
	anotherBox connectableBoundingBox addConnectionPoint: destination thatConnectsTo:  self.
	aConnection from: origin to: destination.
	self connectableBoundingBox addMorph: aConnection.

]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> connectableBoundingBox [
	^boundingBox 
]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> connectionBorderNear: anotherClassBox [
	self top > anotherClassBox bottom ifTrue:[^self connectableBoundingBox topBorder].
	self bottom < anotherClassBox top ifTrue:[^self connectableBoundingBox bottomBorder].
	self left > anotherClassBox right ifTrue:[^self connectableBoundingBox leftBorder].
	self right < anotherClassBox left ifTrue:[^self connectableBoundingBox rightBorder].
	^self connectableBoundingBox leftBorder

]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> defaultBorderStyle [ 
	| borderStyle selColor focusColor dashColor |
	borderStyle := BorderStyle dashed.
	dashColor := Color white .
	borderStyle
		dashColors:
				{dashColor .  Color gray   };
			dashLengths: #(5 10);
		width: 1.
	^ borderStyle
]

{ #category : #accessing }
InterfaceBoxMorph >> descriptionCode [ 
	^boxModel descriptionCode 
]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> fontSize [
	^13
]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> formattedText: aText [
	^aText addAttribute: (TextFontReference toFont: (StrikeFont familyName: 'Arial' size: self fontSize)); 
		yourself.
		
]

{ #category : #'dragging-dropping' }
InterfaceBoxMorph >> handlesMouseDown: evt [
	^true
]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> initialize [
	super initialize.
	self clipSubmorphs: false.
	container:= self newRectangle 
		color: Color transparent; 
		borderColor: Color transparent;
		cellInset: -2;
		listDirection: #topToBottom.
	
	self addBoxesToContainer.
	
	self addMorph: container.


]

{ #category : #'private - layout' }
InterfaceBoxMorph >> initializeBoundingBox [ 
	boundingBox := ConnectableBoundingBox new. self addMorph: boundingBox. boundingBox goBehind. 
	boundingBox borderStyle: self defaultBorderStyle.
	boundingBox fillStyle: Color white.
]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> insideBorderStyle [ 
	| borderStyle selColor focusColor dashColor |
	borderStyle := BorderStyle dashed.
	dashColor := (Color r: 100 g: 100 b: 100) .
	borderStyle
		dashColors:
				{dashColor .  Color white   };
			dashLengths: #(5 2);
		width: 2.
	^ borderStyle
]

{ #category : #'dragging-dropping' }
InterfaceBoxMorph >> justDroppedInto: aMorph event: evt [
	boxModel position: self position - owner position .
	owner updateRelationships.
	self updateBounds.

]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> listFrom: aCollection [
	^self formattedText: (aCollection asOrderedCollection joinUsing: String crlf) asText 
		
]

{ #category : #'dragging-dropping' }
InterfaceBoxMorph >> mouseDown: evt [
	evt hand grabMorph: self
]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> newRectangle [ 
	^RectangleMorph new 
		color: Color white; 
		borderColor: (Color r: 100 g: 100 b: 100);
		"width: 250;"
		layoutPolicy: TableLayout new;
		listDirection: #bottomToTop;
		cellPositioning:  #topLeft;
		hResizing: #spaceFill; 
		vResizing: #shrinkWrap;
		layoutInset: 5; cellInset: 2.
]

{ #category : #private }
InterfaceBoxMorph >> newText [
	^ (self textMorphClass new)
		borderWidth: 0;
		borderColor: Color transparent;
		color: Color white;
		readOnly: true
]

{ #category : #private }
InterfaceBoxMorph >> position [
	^ owner ifNil:[ boxModel position ] ifNotNil:[ super position]
]

{ #category : #accessing }
InterfaceBoxMorph >> relations [ 
	^self connections collect:[:conn | conn target]
]

{ #category : #private }
InterfaceBoxMorph >> textMorphClass [ 
"was UpdaterTextMorph "
	^NewTextMorph    
]

{ #category : #accessing }
InterfaceBoxMorph >> textMorphFor: aCollection [
	^self newText text: (self listFrom: aCollection ); fitToParagraph .
]

{ #category : #accessing }
InterfaceBoxMorph >> textMorphFor: aCollection withEmphasis: someEmphasis [
	| aText |
	aText:= (self listFrom: aCollection) .
	someEmphasis do:[:emph | aText addAttribute: emph ].
	^self newText text: aText ; fitToParagraph .
]

{ #category : #updating }
InterfaceBoxMorph >> update: aParameter [
	(aParameter == #variables)
		ifTrue: [self updateVariables].
	(aParameter == #methods)
		ifTrue: [self updateMethods].
	(aParameter == #title)
		ifTrue: [self updateTitle].
	(aParameter == #position)
		ifTrue: [self position: boxModel position + owner position. owner updateDescriptionCode.].
	(aParameter == #title)
		ifTrue: [self updateTitle].	
	self updateBounds.
	 
]

{ #category : #'private - layout' }
InterfaceBoxMorph >> updateBounds [
	self bounds: container fullBounds.
	self extent: self extent + (7@0).
	boundingBox ifNil: [self initializeBoundingBox. ].
	
	boundingBox updateView.
	boundingBox updateLayout.
	
]

{ #category : #accessing }
InterfaceBoxMorph >> updateMethods [ 
	methodsBox removeAllMorphs. 	
	self addTextMorphFor: boxModel instanceMethods into: methodsBox.
	self addTextMorphFor: boxModel classMethods into: methodsBox withEmphasis: {TextEmphasis underlined}.

]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> updateRelationships [
	self removeAllMorphsIn:  (self connections reject:[:subMorph | boxModel relations includes: subMorph target ]).
		
		
		
]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> updateTitle [  
	titleBox removeAllMorphs.
	titleBox addMorph: ((self textMorphFor:  {boxModel boxTitle} withEmphasis:  {TextAlignment centered  . TextEmphasis bold })    ).

]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> wantsToBeDroppedInto: aMorph [
	^aMorph isKindOf: DiagramWhiteboard 
]
