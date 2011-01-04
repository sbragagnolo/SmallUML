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
			updateFromModel 
]

{ #category : #'as yet unclassified' }
TraitBox >> mapsToModel [ 
	^self model notNil
]

{ #category : #'as yet unclassified' }
TraitBox >> model [
	^Smalltalk at: self name asSymbol ifAbsent:[nil]
]

{ #category : #'as yet unclassified' }
TraitBox >> relateIfPossibleTo: aDiagramNode [
	(self mapsToModel and:[aDiagramNode mapsToModel]) ifFalse:[^self].
	aDiagramNode relateIfPossibleToTrait: self.
]

{ #category : #'as yet unclassified' }
TraitBox >> relateIfPossibleToClass: aClassBox [
	(aClassBox model traitCompositionIncludes: self model) ifTrue:[
		aClassBox usesTrait: self].
]

{ #category : #'as yet unclassified' }
TraitBox >> relateIfPossibleToTrait: aTraitBox [
	(aTraitBox model ~= self model and: [ aTraitBox model traitCompositionIncludes: self model ])
		ifTrue: [ aTraitBox usesTrait: self ]
]

{ #category : #'as yet unclassified' }
TraitBox >> updateFromModel [
	self
		instanceMethods: (self selectorsAsStrings: self model selectors);
		classMethods: (self selectorsAsStrings: self model classTrait selectors)
]

{ #category : #'as yet unclassified' }
TraitBox >> view [
	^(TraitBoxMorph forBox: self)
]
