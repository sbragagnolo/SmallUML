Class {
	#name : #InterfaceBoxMorph,
	#superclass : #DiagramNodeMorph,
	#instVars : [
		'methodsBox',
		'boundingBox',
		'titleBox',
		'instanceMethods',
		'classMethods'
	],
	#category : #'SUML-DiagramDrawing'
}

{ #category : #'as yet unclassified' }
InterfaceBoxMorph class >> forBox: aBox [
	^self new diagramNode: aBox 
]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> addBoxMenuTo: aMenu [
	instanceMethods ifNil:[aMenu add: 'Add Instance Methods' action: #addInstanceMethods].
	classMethods ifNil:[aMenu add: 'Add Class Methods' action: #addClassMethods]
]

{ #category : #'private - layout' }
InterfaceBoxMorph >> addBoxesToContainer [
	methodsBox := self newRectangle.
	titleBox := self newRectangle cellPositioning:  #topCenter.
	container addMorph: methodsBox ; addMorph: titleBox. 
]

{ #category : #accessing }
InterfaceBoxMorph >> addTextMorphFor: aCollectionOfStrings into: aMorph property: aString [
	|textMorph|
	textMorph := (self textMorphFor: aCollectionOfStrings modifying: aString).
	^aCollectionOfStrings ifNotEmpty: [ aMorph addMorph: textMorph. textMorph  ] ifEmpty: [nil]
]

{ #category : #accessing }
InterfaceBoxMorph >> addTextMorphFor: aCollectionOfStrings into: aMorph property: aString withEmphasis: anEmphasis [ 
	|textMorph|
	textMorph := (self textMorphFor: aCollectionOfStrings modifying: aString withEmphasis: anEmphasis ).
	^aCollectionOfStrings ifNotEmpty: [ aMorph addMorph: textMorph. textMorph ] ifEmpty: [nil]
]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> arrayFromText: aText [
	^aText ifNotNil:[aText string substrings: {Character cr. Character lf }]
]

{ #category : #accessing }
InterfaceBoxMorph >> classMethods [ 
	^self listFrom: diagramNode classMethods
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

{ #category : #updating }
InterfaceBoxMorph >> diagramNode: aDiagramNode [
	super diagramNode: aDiagramNode.
	self updateTitle.
	self updateMethods.
	self updateBounds.
	
]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> doubleClick: evt [
	self eventHandler doubleClick: evt
]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> fontSize [
	^16
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

{ #category : #accessing }
InterfaceBoxMorph >> instanceMethods [ 
	^self listFrom: diagramNode instanceMethods
]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> listFrom: aCollection [
	^self formattedText: (aCollection asOrderedCollection joinUsing: String crlf) asText 
		
]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> newRectangle [ 
	^BorderedMorph new 
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
		borderColor: Color transparent;
		color: Color transparent;
		borderWidth: 0;
		width: self width -10
]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> saveClassMethods: aText [
	self diagramNode classMethods: ( self arrayFromText: aText )
]

{ #category : #'as yet unclassified' }
InterfaceBoxMorph >> saveInstanceMethods: aText [
	self diagramNode instanceMethods: ( self arrayFromText: aText )
]

{ #category : #private }
InterfaceBoxMorph >> textMorphClass [ 
"was UpdaterTextMorph "
	^PluggableTextMorph 
]

{ #category : #accessing }
InterfaceBoxMorph >> textMorphFor: aCollection modifying: aString [
	|newText|
	newText := self newText.
	newText borderWidth: 0.
	newText 		
		on: self 
		text: (aString uncapitalized) asSymbol 
		accept: ('save',aString,':') asSymbol 
		readSelection: nil
		menu: nil.
	newText fit.
"	newText onEscapeSend: #updateDescriptionText to: self."
	^newText 
]

{ #category : #accessing }
InterfaceBoxMorph >> textMorphFor: aCollection modifying: aString withEmphasis: someEmphasis [
	| aText newText|
	aText := self listFrom: aCollection.
	someEmphasis do: [ :emph | aText addAttribute: emph ].
	newText := self textMorphFor: aCollection  modifying: aString.
	newText setText: aText.
	^newText 
]

{ #category : #accessing }
InterfaceBoxMorph >> textMorphFor: aCollection withEmphasis: someEmphasis [
	| aText newText |
	aText:= (self listFrom: aCollection) .
	someEmphasis do:[:emph | aText addAttribute: emph ].
	newText := StringMorph new contents: aText.
	^newText 
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

{ #category : #updating }
InterfaceBoxMorph >> updateBounds [
	self bounds: container fullBounds.
	self extent: self extent + (7@0).
	boundingBox ifNil: [self initializeBoundingBox. ].

	boundingBox updateLayout.
		boundingBox updateView.
	
]

{ #category : #updating }
InterfaceBoxMorph >> updateDescriptionText [
	self updateMethods 
]

{ #category : #updating }
InterfaceBoxMorph >> updateMethods [ 
	methodsBox removeAllMorphs. 	
	instanceMethods := self addTextMorphFor: diagramNode instanceMethods into: methodsBox property: 'InstanceMethods'.
	classMethods := self addTextMorphFor: diagramNode classMethods into: methodsBox property: 'ClassMethods' withEmphasis: {TextEmphasis underlined}.

]

{ #category : #updating }
InterfaceBoxMorph >> updateRelationships [
	self removeAllMorphsIn:  (self connections reject:[:subMorph | diagramNode relations includes: subMorph target ]).
		
		
		
]

{ #category : #updating }
InterfaceBoxMorph >> updateTitle [  
	titleBox removeAllMorphs.
	titleBox addMorph: ((self textMorphFor:  {diagramNode boxTitle} withEmphasis:  {TextAlignment centered  . TextEmphasis bold })  ).

]
