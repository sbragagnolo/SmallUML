Class {
	#name : #DiagramNodeEventHandler,
	#superclass : #DraggingEventHandler,
	#category : #'SUML-Tools'
}

{ #category : #'as yet unclassified' }
DiagramNodeEventHandler >> handleMove: evt [
	super handleMove: evt.
	self passenger justDroppedInto: passenger owner event: evt.
	self passenger updateConnections
]

{ #category : #'as yet unclassified' }
DiagramNodeEventHandler >> handlesKeyboard: aKeyboardEvent [ 
	^false
]

{ #category : #'events-accessing' }
DiagramNodeEventHandler >> handlesMouseOver: aMouseMoveEvent [ 
	^false
]

{ #category : #'events-accessing' }
DiagramNodeEventHandler >> handlesMouseOverDragging: aMouseMoveEvent [ 
	^false
]

{ #category : #'events-accessing' }
DiagramNodeEventHandler >> handlesMouseStillDown: aMouseButtonEvent [ 
	^false
]
