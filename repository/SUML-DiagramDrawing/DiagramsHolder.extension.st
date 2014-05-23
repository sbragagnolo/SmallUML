Extension { #name : #DiagramsHolder }

{ #category : #'*SUML-DiagramDrawing' }
DiagramsHolder >> connectableBounds [
	| d horizontalConnectableBorder verticalConnectableBorder connectableBorder singleConnectionPoint connection |
	horizontalConnectableBorder := ClassBox named: 'HorizontalConnectableBorder'.
	horizontalConnectableBorder instanceMethods: #('updateView' 'initialize' 'updateLayout').	"Positioning"
	horizontalConnectableBorder position: 460.0 @ 391.0.
	verticalConnectableBorder := ClassBox named: 'VerticalConnectableBorder'.
	verticalConnectableBorder instanceMethods: #('updateView' 'initialize' 'updateLayout').	"Positioning"
	verticalConnectableBorder position: 771.0 @ 391.0.
	connectableBorder := ClassBox named: 'ConnectableBorder'.
	connectableBorder instanceMethods: #('updateConnectionsLabel' 'connectionPoints' 'sortSubmorphsBy:' 'updateLayout').	"Positioning"
	connectableBorder position: 729.0 @ 128.0.
	singleConnectionPoint := ClassBox named: 'SingleConnectionPoint'.
	singleConnectionPoint
		instanceMethods:
			#('attachTailOf:' 'oppositeConnectionPoint' 'connectTo:' 'attachHeadOf:' 'updateConnections' 'dettachFrom:' 'connection').	"Positioning"
	singleConnectionPoint position: 404.0 @ 94.0.
	connection := ClassBox named: 'Connection'.
	connection
		instanceMethods: #('closestPointTo:' 'connectionPoints:' 'headConnectionPoint' 'tailConnectionPoint' 'from:to:').
	connection classMethods: #('from:to:').	"Positioning"
	connection position: 40 @ 94.	"Relationships"
	horizontalConnectableBorder inheritsFromClass: connectableBorder.	"Relationships"
	verticalConnectableBorder inheritsFromClass: connectableBorder.	"Relationships"
	connectableBorder hasLotsOf: singleConnectionPoint labeledAs: 'submorphs'.	"Relationships"
	singleConnectionPoint hasLotsOf: connection labeledAs: 'outConnections'.
	singleConnectionPoint hasLotsOf: connection labeledAs: 'inConnections'.	"Relationships"
	connection hasLotsOf: singleConnectionPoint labeledAs: 'connectionPoints'.
	d := (ClassDiagram new name: 'Connectable Bounds')
		addDiagramNode: horizontalConnectableBorder;
		addDiagramNode: verticalConnectableBorder;
		addDiagramNode: connectableBorder;
		addDiagramNode: singleConnectionPoint;
		addDiagramNode: connection.
	^ d
]

{ #category : #'*SUML-DiagramDrawing' }
DiagramsHolder >> connectableShapes [
	| d diagramNodeMorph connectableBorder connectableBoundingBox connectableBoundingCircle connectableBounds tConnectableShape |
	diagramNodeMorph := ClassBox named: 'DiagramNodeMorph'.
	diagramNodeMorph instanceVariables: #('container' 'diagramNode' 'dragEventHandler').
	diagramNodeMorph
		instanceMethods:
			#('connectTo:using:' 'update:' 'connections' 'mouseUp:' 'connectTo:' 'relations' 'handlesMouseDown:' 'diagramNode:' 'adjustPosition' 'connectableBounds' 'step' 'initialize' 'updateLayout' 'wantsToBeDroppedInto:' 'mouseDown:' 'justDroppedInto:event:' 'mouseMove:').	"Positioning"
	diagramNodeMorph position: 241.0 @ 14.0.
	connectableBorder := ClassBox named: 'ConnectableBorder'.
	connectableBorder instanceMethods: #('updateConnectionsLabel' 'connectionPoints' 'sortSubmorphsBy:' 'updateLayout').	"Positioning"
	connectableBorder position: 1122.0 @ 336.0.
	connectableBoundingBox := ClassBox named: 'ConnectableBoundingBox'.
	connectableBoundingBox
		instanceMethods:
			#('connections' 'updateConnectionsLabel' 'connectionPoints' 'newVerticalBorder' 'newHorizontalBorder' 'newBorder' 'connectionNear:' 'addConnectionPoint:thatConnectsTo:').	"Positioning"
	connectableBoundingBox position: 736.0 @ 295.0.
	connectableBoundingCircle := ClassBox named: 'ConnectableBoundingCircle'.
	connectableBoundingCircle instanceVariables: #('points').
	connectableBoundingCircle instanceMethods: #('connections' 'connectionNear:' 'addConnectionPoint:thatConnectsTo:').	"Positioning"
	connectableBoundingCircle position: 458.00000000000006 @ 321.0.
	connectableBounds := InterfaceBox named: 'ConnectableBounds'.
	connectableBounds instanceMethods: #('connections' 'addConnectionPoint:thatConnectsTo:' 'connectionNear:').	"Positioning"
	connectableBounds position: 606.0 @ 96.0.
	tConnectableShape := TraitBox named: 'TConnectableShape'.
	tConnectableShape
		instanceMethods: #('connectTo:using:' 'connections' 'connectTo:' 'handlesMouseDown:' 'connectableBounds').	"Positioning"
	tConnectableShape position: 5.0 @ 161.0.	"Relationships"
	diagramNodeMorph hasA: connectableBounds labeledAs: 'connectableBounds'.
	diagramNodeMorph usesTrait: tConnectableShape.	"Relationships"
	connectableBoundingBox implements: connectableBounds.
	connectableBoundingBox hasLotsOf: connectableBorder labeledAs: 'borders'.	"Relationships"
	connectableBoundingCircle implements: connectableBounds.
	d := (ClassDiagram new name: 'Connectable Shapes')
		addDiagramNode: diagramNodeMorph;
		addDiagramNode: connectableBorder;
		addDiagramNode: connectableBoundingBox;
		addDiagramNode: connectableBoundingCircle;
		addDiagramNode: connectableBounds;
		addDiagramNode: tConnectableShape.
	^ d
]
