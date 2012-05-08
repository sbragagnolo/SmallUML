Class {
	#name : #DiagramsHolder,
	#superclass : #Object,
	#category : #'SUML-ClassDiagramModel'
}

{ #category : #'as yet unclassified' }
DiagramsHolder class >> addDiagram: aDiagram [
	^aDiagram category: self category;  saveDescriptionIn: self
]

{ #category : #'as yet unclassified' }
DiagramsHolder class >> categoryModel [
	^CategoryDiagramsModel new model: self
]

{ #category : #accessing }
DiagramsHolder class >> diagramNamed: aName [
	^ (self new perform: aName asSymbol ) category: self category 
]

{ #category : #accessing }
DiagramsHolder class >> diagrams [
	^ ("(self methodsInCategory: 'diagrams')" self selectors collect: [ :selector | self diagramNamed: selector]) asOrderedCollection 
]

{ #category : #'as yet unclassified' }
DiagramsHolder class >> openDiagramBrowser [
	^self openDiagramBrowserForModel: self categoryModel 
]

{ #category : #'as yet unclassified' }
DiagramsHolder class >> openDiagramBrowserForModel: aModel [
	^(UMLDiagramWindow on: aModel) setLabel: self category; openAsIs; maximize 
]

{ #category : #'as yet unclassified' }
DiagramsHolder class >> openDiagramBrowserSelecting: aDiagramName [
	^self openDiagramBrowserForModel: (self categoryModel selectDiagramByName: aDiagramName )
]

{ #category : #'as yet unclassified' }
DiagramsHolder class >> removeDiagram: aDiagram [
	aDiagram deleteDescriptionIn: self
]

{ #category : #diagrams }
DiagramsHolder >> pirates [
	| d pirate byteSymbol treasureQuest mission ship |
	pirate := ClassBox named: 'Pirate'.
	pirate instanceVariables: #('alcoholLevel' ).
	pirate instanceMethods: #(#alcoholLevel: #items: #isUsefulForTheMission: #isDrunkEnough #includesItem: ).
	"includesItem:"
	pirate position: 842.0 @ 26.0.
	byteSymbol := ClassBox named: 'ByteSymbol'.
	"ByteSymbol"
	byteSymbol position: 966.0 @ 343.0.
	treasureQuest := ClassBox named: 'TreasureQuest'.
	treasureQuest instanceMethods: #(#canUsePirate: ).
	"canUsePirate:"
	treasureQuest position: 610.0 @ 355.0.
	mission := ClassBox named: 'Mission'.
	mission instanceMethods: #(#canUsePirate: ).
	"canUsePirate:"
	mission position: 255.0 @ 320.0.
	ship := ClassBox named: 'Ship'.
	ship instanceMethods: #(#mission: #acceptIntoTripulation: ).
	"acceptIntoTripulation:"
	ship position: 518.0 @ 57.0.
	"position:"
	pirate hasLotsOf: byteSymbol labeledAs: 'items'.
	"items"
	treasureQuest inheritsFromClass: mission.
	"mission"
	ship hasA: treasureQuest labeledAs: 'mission'.
	ship hasLotsOf: pirate labeledAs: 'tripulation'.
	d := (ClassDiagram new name: 'Pirates!!') addDiagramNode: pirate;
				 addDiagramNode: byteSymbol;
				 addDiagramNode: treasureQuest;
				 addDiagramNode: mission;
				 addDiagramNode: ship.
	^ d
]

{ #category : #diagrams }
DiagramsHolder >> sUMLExampleModel [
	| d pirate byteSymbol treasureQuest mission ship |
	pirate := ClassBox named: 'Pirate'.
	pirate instanceMethods: #(#alcoholLevel: #items: #isUsefulForTheMission: #isDrunkEnough #includesItem: ).
	"includesItem:"
	pirate position: 602.0 @ 150.0.
	byteSymbol := ClassBox named: 'ByteSymbol'.
	"ByteSymbol"
	byteSymbol position: 636.0 @ 475.0.
	treasureQuest := ClassBox named: 'TreasureQuest'.
	treasureQuest instanceMethods: #(#canUsePirate: ).
	"canUsePirate:"
	treasureQuest position: 65.0 @ 183.0.
	mission := ClassBox named: 'Mission'.
	mission instanceMethods: #(#canUsePirate: ).
	"canUsePirate:"
	mission position: 72.0 @ 10.0.
	ship := ClassBox named: 'Ship'.
	ship instanceMethods: #(#mission: #acceptIntoTripulation: ).
	"acceptIntoTripulation:"
	ship position: 310.0 @ 174.0.
	"position:"
	pirate hasLotsOf: byteSymbol labeledAs: 'items'.
	"items"
	treasureQuest inheritsFromClass: mission.
	"mission"
	ship hasA: treasureQuest labeledAs: 'mission'.
	ship hasLotsOf: pirate labeledAs: 'tripulation'.
	d := (ClassDiagram new name: 'SUML-ExampleModel') addDiagramNode: pirate;
				 addDiagramNode: byteSymbol;
				 addDiagramNode: treasureQuest;
				 addDiagramNode: mission;
				 addDiagramNode: ship.
	^ d
]
