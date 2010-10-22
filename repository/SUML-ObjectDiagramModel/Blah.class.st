Class {
	#name : #Blah,
	#superclass : #Object,
	#instVars : [
		'uno',
		'dos',
		'tres'
	],
	#category : #'SUML-ObjectDiagramModel'
}

{ #category : #accessing }
Blah >> dos [
	^ dos
]

{ #category : #accessing }
Blah >> dos: anObject [
	dos := anObject
]

{ #category : #accessing }
Blah >> tres [
	^ tres
]

{ #category : #accessing }
Blah >> tres: anObject [
	tres := anObject
]

{ #category : #accessing }
Blah >> uno [
	^ uno
]

{ #category : #accessing }
Blah >> uno: anObject [
	uno := anObject
]
