Class {
	#name : #ObjectDiagramModel,
	#superclass : #DiagramModel,
	#category : #'SUML-Tools'
}

{ #category : #'as yet unclassified' }
ObjectDiagramModel >> bindingErrorBecauseOf: aVariable [
	^'No object node associated with the variable: ', aVariable 
]

{ #category : #'as yet unclassified' }
ObjectDiagramModel >> createNode [
	| name |
	name := self request: 'Object Name' default: ''.
	"self checkBoxName: name."
	self model addDiagramNode: (ObjectNode named: name).
	self changed.
]

{ #category : #'as yet unclassified' }
ObjectDiagramModel >> list [
	^self model ifNotNil:[self model diagramNodes]
	 "This should be changed when integrating other kinds of diagrams, doing a double dispatch maybe"
	ifNil:[#()]
]

{ #category : #'as yet unclassified' }
ObjectDiagramModel >> listMenu: aMenu shifted: shifted [
	self list ifNotEmpty:[
		aMenu addList: #(('Delete object'	#deleteNode) ('Rename object'	renameNode));
			addLine].
		aMenu 
			addList: #(
					('Add new object node' 		#createNode) 
					 ).

	^ aMenu 
]
