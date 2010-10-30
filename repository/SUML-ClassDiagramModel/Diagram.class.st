Class {
	#name : #Diagram,
	#superclass : #Object,
	#instVars : [
		'category',
		'name',
		'description',
		'diagramNodes'
	],
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #'as yet unclassified' }
Diagram class >> inheritanceFor: aClass [
	^(InheritanceDiagramBuilder new buildForClass: aClass ) name: 'Inheritance for ', aClass name
]

{ #category : #adding }
Diagram >> addDiagramNode: aDiagramNode [
	self diagramNodes add: aDiagramNode.
	self changed: #view
]

{ #category : #accessing }
Diagram >> category [
	^ category
]

{ #category : #accessing }
Diagram >> category: anObject [
	category := anObject
]

{ #category : #'as yet unclassified' }
Diagram >> changed [
	self changed: #view.
	super changed.
]

{ #category : #saving }
Diagram >> deleteDescriptionIn: aDiagramHolderClass [
	aDiagramHolderClass removeSelector: self name onlyLetters withFirstCharacterDownshifted asSymbol 
	
]

{ #category : #accessing }
Diagram >> description [
	^ description
]

{ #category : #accessing }
Diagram >> description: anObject [
	description := anObject
]

{ #category : #accessing }
Diagram >> descriptionCode [ 
	|descriptionCode|
	descriptionCode :=  WriteStream on: ''.
	descriptionCode nextPutAll: '| d '.
	(self diagramNodes collect:[:classBox | classBox variableNameForDescriptionCode ]) asStringOn: descriptionCode delimiter: String space.
	descriptionCode nextPutAll: '|'.
	(self diagramNodes collect:[:classBox | classBox creationAndDefinitionCode ]) asStringOn: descriptionCode delimiter: String cr, String cr.
	
	(self diagramNodes collect:[:classBox | classBox relationshipsCode ]) asStringOn: descriptionCode delimiter: String cr, String cr.
	
	descriptionCode nextPutAll: ' d := (',self class name,' new name: ''', self name, ''' ) '.
	(self diagramNodes collect:[:classBox | 'addDiagramNode: ', classBox variableNameForDescriptionCode ]) asStringOn: descriptionCode delimiter: $; asString.
	descriptionCode nextPutAll: '.^ d'.
	^descriptionCode contents
]

{ #category : #accessing }
Diagram >> descriptionCodeOf: aDiagramNode [ 
	^aDiagramNode descriptionCodeForEdition 
]

{ #category : #accessing }
Diagram >> diagramNodeFor: anObject [
	^self diagramNodes detect:[:node | node subject = anObject ] ifNone:[nil]
]

{ #category : #accessing }
Diagram >> diagramNodes [
	^diagramNodes ifNil:[diagramNodes := OrderedCollection new]
]

{ #category : #accessing }
Diagram >> diagramNodes: someDiagramNodes [ 
	diagramNodes := someDiagramNodes 
]

{ #category : #accessing }
Diagram >> displayString [
	^self name
]

{ #category : #accessing }
Diagram >> includesDiagramNodeFor: anObject [
	^(self diagramNodeFor: anObject ) notNil
]

{ #category : #accessing }
Diagram >> name [
	^ name
]

{ #category : #accessing }
Diagram >> name: anObject [
	name := anObject
]

{ #category : #'user interface' }
Diagram >> openDescriptionCodeinWorkspace [
	SHWorkspace new contents: self descriptionCode; open
]

{ #category : #accessing }
Diagram >> printString [
	^self displayString 
]

{ #category : #accessing }
Diagram >> removeDiagramNode: aDiagramNode [
	self diagramNodes remove: aDiagramNode.
	self diagramNodes do:[:diagramNode | diagramNode removeRelationshipsWith: aDiagramNode ].
	self changed: #view
]

{ #category : #saving }
Diagram >> saveDescriptionIn: aDiagramHolderClass [
	|descriptionCodeAsMethod|
	descriptionCodeAsMethod := aDiagramHolderClass prettyPrinterClass new 
		format: ((self name onlyLetters withFirstCharacterDownshifted), String cr, self descriptionCode) 
		in: aDiagramHolderClass 
		notifying: self.
	aDiagramHolderClass compile: descriptionCodeAsMethod classified: 'diagrams'
	
]
