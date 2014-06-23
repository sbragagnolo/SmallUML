Class {
	#name : #SequenceDiagramBuilder,
	#superclass : #Object,
	#category : #'SUML-SequenceDiagramModel'
}

{ #category : #'as yet unclassified' }
SequenceDiagramBuilder >> buildSequenceDiagram: aSequenceDiagram [
	|timelines|
	
	timelines := aSequenceDiagram objectsInvolved collect: [:each | 
		TimelineMorph new objectTitle: each name asString].
	timelines collect: [:t | aSequenceDiagram steps collect: [ :s |
			|newMsg |
			 newMsg := MessageSendMorph new sender: t.
			 t addMessageSend: newMsg.
			newMsg message: s toObject: t] ].		
	timelines do: [ :t | t openInWindowLabeled: 'SequenceDiagram']
]
