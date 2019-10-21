Extension { #name : #Diagram }

{ #category : #'*SUML-Tools' }
Diagram >> diagramListModelClass [ 
	^ObjectDiagramModel 
]

{ #category : #'*SUML-Tools' }
Diagram >> modelForDiagramsHolder: aDiagramsHolder [
	^(self diagramListModelClass new model: self  ) 
]

{ #category : #'*SUML-Tools' }
Diagram >> openQuickView [
	DiagramWindow new setLabel: 'Diagram Quick View'; openOn: self
]
