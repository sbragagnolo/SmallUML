Class {
	#name : #CategoryDiagramsTreeItemNode,
	#superclass : #ListItemWrapper,
	#instVars : [
		'diagrams'
	],
	#category : #'SUML-Tools'
}

{ #category : #'as yet unclassified' }
CategoryDiagramsTreeItemNode >> asString [
	^item asString withoutQuoting trimLeft:[:char | char = $*]
]

{ #category : #'as yet unclassified' }
CategoryDiagramsTreeItemNode >> contents [
	^ diagrams ifNil:[diagrams := (DiagramsHolder allMethodsInCategory: item) collect:[:m |  DiagramTreeItemNode with: ((DiagramsHolder uniqueInstance perform: m) category: self asString) model: model]]
]

{ #category : #'as yet unclassified' }
CategoryDiagramsTreeItemNode >> icon [
	^nil
]
