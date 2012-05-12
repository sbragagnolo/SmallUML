Extension { #name : #DiagramsHolder }

{ #category : #'*SUML-ModelExample' }
DiagramsHolder >> pirates [
	| d pirate byteSymbol treasureQuest mission ship |
	pirate := ClassBox named: 'Pirate'.
	pirate instanceVariables: #('alcoholLevel' ).
	pirate instanceMethods: #(#alcoholLevel: #items: #isUsefulForTheMission: #isDrunkEnough #includesItem: ).
	"includesItem:"
	pirate position: 663.0 @ 201.0.
	byteSymbol := ClassBox named: 'ByteSymbol'.
	"ByteSymbol"
	byteSymbol position: 951.0 @ 253.0.
	treasureQuest := ClassBox named: 'TreasureQuest'.
	treasureQuest instanceMethods: #(#canUsePirate: ).
	"canUsePirate:"
	treasureQuest position: 50.0 @ 240.0.
	mission := ClassBox named: 'Mission'.
	mission instanceMethods: #(#canUsePirate: ).
	"canUsePirate:"
	mission position: 57.0 @ 26.0.
	ship := ClassBox named: 'Ship'.
	ship instanceMethods: #(#mission: #acceptIntoTripulation: ).
	"acceptIntoTripulation:"
	ship position: 318.0 @ 232.0.
	"position:"
	pirate hasLotsOf: byteSymbol labeledAs: 'items'.
	"items"
	treasureQuest inheritsFromClass: mission.
	"mission"
	ship hasA: treasureQuest labeledAs: 'mission'.
	ship hasLotsOf: pirate labeledAs: 'tripulation'.
	d := (ClassDiagram new name: 'Pirates!') addDiagramNode: pirate;
				 addDiagramNode: byteSymbol;
				 addDiagramNode: treasureQuest;
				 addDiagramNode: mission;
				 addDiagramNode: ship.
	^ d
]
