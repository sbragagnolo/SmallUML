Class {
	#name : #InterfaceBoxMorph,
	#superclass : #DiagramNodeMorph,
	#instVars : [
		'methodsBox',
		'boundingBox',
		'titleBox'
	],
	#category : #'SUML-DiagramDrawing'
}

{ #category : #'as yet unclassified' }
InterfaceBoxMorph class >> forBox: aBox [
	^self new diagramNode: aBox 
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
InterfaceBoxMorph >> connectableBounds [
	^boundingBox 
]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> connectionBorderNear: anotherClassBox [
	self top > anotherClassBox bottom ifTrue:[^self connectableBounds topBorder].
	self bottom < anotherClassBox top ifTrue:[^self connectableBounds bottomBorder].
	self left > anotherClassBox right ifTrue:[^self connectableBounds leftBorder].
	self right < anotherClassBox left ifTrue:[^self connectableBounds rightBorder].
	^self connectableBounds leftBorder

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
	^diagramNode descriptionCode 
]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> diagramNode: aDiagramNode [
	super diagramNode: aDiagramNode.
	self updateTitle.
	self updateMethods.
	self updateBounds.
	
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

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> initialize [
	super initialize.
	diagramEventHandler := ClassDiagramNodeEventHandler new passenger: self.
	
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

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> listFrom: aCollection [
	^self formattedText: (aCollection asOrderedCollection joinUsing: String crlf) asText 
		
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
	(aParameter == #title)
		ifTrue: [self updateTitle].	
	super update: aParameter.
	self updateBounds.
	 
]

{ #category : #'private - layout' }
InterfaceBoxMorph >> updateBounds [
	self bounds: container fullBounds.
	self extent: self extent + (7@0).
	boundingBox ifNil: [self initializeBoundingBox. ].

	boundingBox updateLayout.
		boundingBox updateView.
	
]

{ #category : #accessing }
InterfaceBoxMorph >> updateMethods [ 
	methodsBox removeAllMorphs. 	
	self addTextMorphFor: diagramNode instanceMethods into: methodsBox.
	self addTextMorphFor: diagramNode classMethods into: methodsBox withEmphasis: {TextEmphasis underlined}.

]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> updateRelationships [
	self removeAllMorphsIn:  (self connections reject:[:subMorph | diagramNode relations includes: subMorph target ]).
		
		
		
]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> updateTitle [  
	titleBox removeAllMorphs.
	titleBox addMorph: ((self textMorphFor:  {diagramNode boxTitle} withEmphasis:  {TextAlignment centered  . TextEmphasis bold })    ).

]
