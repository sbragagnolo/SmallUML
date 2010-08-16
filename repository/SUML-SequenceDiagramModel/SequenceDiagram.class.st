Class {
	#name : #SequenceDiagram,
	#superclass : #Object,
	#instVars : [
		'steps'
	],
	#category : #'SUML-SequenceDiagramModel'
}

{ #category : #'as yet unclassified' }
SequenceDiagram >> addFirstMessage: aMessage to: anotherObject [ 
	^self steps add: ((SequenceMessage message: aMessage)  to: anotherObject)
]

{ #category : #'as yet unclassified' }
SequenceDiagram >> addFirstMessage: aMessage to: aReceiver thatReturns: aResult [ 
	^(self addFirstMessage: aMessage  to: aReceiver) returns: aResult  
]

{ #category : #'as yet unclassified' }
SequenceDiagram >> addLoop: aLoopDescription withSequence: aBlockClosure [ 
	^self steps add: (SequenceLoop new description: aLoopDescription; sequence: aBlockClosure)
]

{ #category : #'as yet unclassified' }
SequenceDiagram >> addMessage: aMessage sentFrom: aSender to: aReceiver [ 
	^self steps add: ((SequenceMessage message: aMessage) from: aSender; to: aReceiver)
]

{ #category : #'as yet unclassified' }
SequenceDiagram >> addMessage: aMessage sentFrom: aSender to: aReceiver thatReturns: aResult [ 
	^(self addMessage: aMessage sentFrom: aSender  to: aReceiver) returns: aResult   
]

{ #category : #accessing }
SequenceDiagram >> objectsInvolved [
	^self steps inject: Set new into:[:objects :step | objects union: step objectsInvolved] 
]

{ #category : #accessing }
SequenceDiagram >> steps [
	^steps ifNil:[steps:= OrderedCollection new]
]
