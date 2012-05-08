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
DiagramWhiteboard >> save [
	self diagram name: self diagramName.
	self diagram saveDescriptionInCategory: self categoryName.
	DiagramsHolder openDiagramBrowserSelecting: self diagramName.
]
