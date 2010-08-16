Class {
	#name : #SequenceMessage,
	#superclass : #Object,
	#instVars : [
		'message',
		'receiver',
		'sender',
		'returns'
	],
	#category : #'SUML-SequenceDiagramModel'
}

{ #category : #creation }
SequenceMessage class >> message: aByteString [ 
	^self new message: aByteString 
]

{ #category : #accessing }
SequenceMessage >> from: aByteSymbol [ 
	sender:= aByteSymbol 
]

{ #category : #accessing }
SequenceMessage >> message [
	^message  
]

{ #category : #accessing }
SequenceMessage >> message: aByteString [ 
	message:= aByteString 
]

{ #category : #accessing }
SequenceMessage >> objectsInvolved [
	^self sender
		ifNil:[Set with: self receiver]
		ifNotNil:[Set with: self receiver with: self sender ]
]

{ #category : #'as yet unclassified' }
SequenceMessage >> receiver [
	^receiver 
]

{ #category : #accessing }
SequenceMessage >> returnValue [
	^returns
]

{ #category : #accessing }
SequenceMessage >> returns: aByteString [ 
	returns:= aByteString 
]

{ #category : #accessing }
SequenceMessage >> sender [
	^sender
]

{ #category : #accessing }
SequenceMessage >> to: aByteSymbol [ 
	receiver:= aByteSymbol 
]
