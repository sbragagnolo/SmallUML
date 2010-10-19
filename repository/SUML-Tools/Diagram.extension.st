Extension { #name : #Diagram }

{ #category : #'*SUML-Tools' }
Diagram >> diagramListModelClass [ 
	self subclassResponsibility 
]

{ #category : #'*SUML-Tools' }
Diagram >> modelForDiagramsHolder: aDiagramsHolder [
	^(self diagramListModelClass new model: self  ) 
]
