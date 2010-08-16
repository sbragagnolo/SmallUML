Class {
	#name : #TraitBox,
	#superclass : #InterfaceBox,
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #'as yet unclassified' }
TraitBox class >> fromTrait: aTrait [
	aTrait isTrait ifFalse:[self error:aTrait name asString , ' is not a Trait'].
	^(self 
		newNamed: aTrait name asString )
			instanceMethods: (self selectorsAsStrings: aTrait selectors);
			classMethods: (self selectorsAsStrings: aTrait classTrait selectors)
]

{ #category : #'as yet unclassified' }
TraitBox >> view [
	^(TraitBoxMorph forBox: self)
]
