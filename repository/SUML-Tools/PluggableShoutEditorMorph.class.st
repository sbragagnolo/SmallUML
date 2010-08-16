Class {
	#name : #PluggableShoutEditorMorph,
	#superclass : #PluggableShoutMorph,
	#category : #'SUML-Tools'
}

{ #category : #'as yet unclassified' }
PluggableShoutEditorMorph >> selectAll [
	super selectAll.
	selectionInterval := self textMorph editor selectionInterval.
]

{ #category : #'as yet unclassified' }
PluggableShoutEditorMorph >> selectFrom: start to: stop [
	super selectFrom: start to: stop.
	selectionInterval := self textMorph editor selectionInterval.
]
