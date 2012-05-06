Extension { #name : #CompiledMethod }

{ #category : #'*SUML-ClassDiagramModel' }
CompiledMethod >> referredInstVars [
|theClass idx|
theClass  := self methodClass.
^theClass instVarNames select: [ :varName | 
    idx := theClass instVarIndexFor: varName.
    (self readsField: idx) or: [ self writesField: idx ]
]
]
