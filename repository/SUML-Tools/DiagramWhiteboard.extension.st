Extension { #name : #DiagramWhiteboard }

{ #category : #'*SUML-Tools' }
DiagramWhiteboard >> categoryName [
	|categoryName currentDiagram|
		categoryName := UIManager default
		request:  'In which category you''d like to save the diagram?' 
		initialAnswer: nil.
	categoryName ifNil:[self error:'Oops! You didn''t give a valid category name'].
	^categoryName 
]

{ #category : #'*SUML-Tools' }
DiagramWhiteboard >> diagramName [
	|diagramName currentDiagram|
	^self model name ifNil:[
		diagramName := UIManager default
		request:  'Please give a name to this diagram' 
		initialAnswer: nil.
	diagramName ifNil:[self error:'Oops! You didn''t name the diagram'].
	diagramName ]
]

{ #category : #'*SUML-Tools' }
DiagramWhiteboard >> handlesMouseDown: evt [
	^true
]

{ #category : #'*SUML-Tools' }
DiagramWhiteboard >> mouseDown: evt [
	evt yellowButtonPressed ifTrue:[self showActionsMenu ]
]

{ #category : #'*SUML-Tools' }
DiagramWhiteboard >> save [
	self diagram name: self diagramName.
	self diagram saveDescriptionInCategory: self categoryName.
	DiagramsHolder openDiagramBrowserSelecting: self diagramName.
]

{ #category : #'*SUML-Tools' }
DiagramWhiteboard >> showActionsMenu [
	| menu |
	menu := MenuMorph new.
	menu addTitle: (self model name ifNil:['Class Diagram']).
	menu addStayUpItem.
	menu target: self.
	menu add: 'Save for category...' action: #save.
	menu add: 'Save as PNG' action: #exportAsPNG.
	menu popUpInWorld.
]
