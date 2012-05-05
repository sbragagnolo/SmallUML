Extension { #name : #BlockClosure }

{ #category : #'*SUML-ClassDiagramModel' }
BlockClosure >> asClassDiagram [
	^ClassDiagramBuilder new fromBlock: self
]
