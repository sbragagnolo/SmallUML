Extension { #name : #DiagramsHolder }

{ #category : #'*SUML-ModelExample' }
DiagramsHolder >> pirates [
	| d pirate byteSymbol treasureQuest mission ship |
	pirate := ClassBox named: 'Pirate'.
	pirate instanceVariables: #('alcoholLevel').
	pirate instanceMethods: #(#alcoholLevel: #items: #isUsefulForTheMission: #isDrunkEnough #includesItem:).	"Positioning"
	pirate position: 663.0 @ 201.0.
	byteSymbol := ClassBox named: 'ByteSymbol'.	"Positioning"
	byteSymbol position: 951.0 @ 253.0.
	treasureQuest := ClassBox named: 'TreasureQuest'.
	treasureQuest instanceMethods: #(#canUsePirate:).	"Positioning"
	treasureQuest position: 50.0 @ 240.0.
	mission := ClassBox named: 'Mission'.
	mission instanceMethods: #(#canUsePirate:).	"Positioning"
	mission position: 57.0 @ 26.0.
	ship := ClassBox named: 'Ship'.
	ship instanceMethods: #(#mission: #acceptIntoTripulation:).	"Positioning"
	ship position: 318.0 @ 232.0.	"Relationships"
	pirate hasLotsOf: byteSymbol labeledAs: 'items'.	"Relationships"
	treasureQuest inheritsFromClass: mission.	"Relationships"
	ship hasA: treasureQuest labeledAs: 'mission'.
	ship hasLotsOf: pirate labeledAs: 'tripulation'.
	d := (ClassDiagram new name: 'Pirates!')
		addDiagramNode: pirate;
		addDiagramNode: byteSymbol;
		addDiagramNode: treasureQuest;
		addDiagramNode: mission;
		addDiagramNode: ship.
	^ d
]
