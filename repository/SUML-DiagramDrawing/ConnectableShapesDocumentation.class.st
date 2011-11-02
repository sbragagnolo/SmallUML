Class {
	#name : #ConnectableShapesDocumentation,
	#superclass : #CategoryDiagramsHolder,
	#category : #'SUML-DiagramDrawing'
}

{ #category : #diagrams }
ConnectableShapesDocumentation >> connectableBounds [
	| d horizontalConnectableBorder verticalConnectableBorder connectableBorder singleConnectionPoint connection |
	horizontalConnectableBorder := ClassBox named: 'HorizontalConnectableBorder'.
	horizontalConnectableBorder instanceMethods: #('updateView' 'initialize' 'updateLayout' ).
	"Positioning"
	horizontalConnectableBorder position: 954 @ 221.
	verticalConnectableBorder := ClassBox named: 'VerticalConnectableBorder'.
	verticalConnectableBorder instanceMethods: #('updateView' 'initialize' 'updateLayout' ).
	"Positioning"
	verticalConnectableBorder position: 935 @ 31.
	connectableBorder := ClassBox named: 'ConnectableBorder'.
	connectableBorder instanceMethods: #('updateConnectionsLabel' 'connectionPoints' 'sortSubmorphsBy:' 'updateLayout' ).
	"Positioning"
	connectableBorder position: 650 @ 111.
	singleConnectionPoint := ClassBox named: 'SingleConnectionPoint'.
	singleConnectionPoint instanceMethods: #('attachTailOf:' 'oppositeConnectionPoint' 'connectTo:' 'attachHeadOf:' 'updateConnections' 'dettachFrom:' 'connection' ).
	"Positioning"
	singleConnectionPoint position: 377 @ 93.
	connection := ClassBox named: 'Connection'.
	connection instanceMethods: #('closestPointTo:' 'connectionPoints:' 'headConnectionPoint' 'tailConnectionPoint' 'from:to:' ).
	connection classMethods: #('from:to:' ).
	"Positioning"
	connection position: 40 @ 94.
	"Relationships"
	horizontalConnectableBorder inheritsFrom: connectableBorder.
	"Relationships"
	verticalConnectableBorder inheritsFrom: connectableBorder.
	"Relationships"
	connectableBorder hasLotsOf: singleConnectionPoint labeledAs: 'submorphs'.
	"Relationships"
	singleConnectionPoint hasLotsOf: connection labeledAs: 'outConnections'.
	singleConnectionPoint hasLotsOf: connection labeledAs: 'inConnections'.
	"Relationships"
	connection hasLotsOf: singleConnectionPoint labeledAs: 'connectionPoints'.
	d := (ClassDiagram new name: 'Connectable Bounds') addDiagramNode: horizontalConnectableBorder;
				 addDiagramNode: verticalConnectableBorder;
				 addDiagramNode: connectableBorder;
				 addDiagramNode: singleConnectionPoint;
				 addDiagramNode: connection.
	^ d
]

{ #category : #diagrams }
ConnectableShapesDocumentation >> connectableShapes [
	| d diagramNodeMorph connectableBorder connectableBoundingBox connectableBoundingCircle connectableBounds tConnectableShape |
	diagramNodeMorph := ClassBox named: 'DiagramNodeMorph'.
	diagramNodeMorph instanceVariables: #('container' 'diagramNode' 'dragEventHandler' ).
	diagramNodeMorph instanceMethods: #('connectTo:using:' 'update:' 'connections' 'mouseUp:' 'connectTo:' 'relations' 'handlesMouseDown:' 'diagramNode:' 'adjustPosition' 'connectableBounds' 'step' 'initialize' 'updateLayout' 'wantsToBeDroppedInto:' 'mouseDown:' 'justDroppedInto:event:' 'mouseMove:' ).
	"Positioning"
	diagramNodeMorph position: 195 @ 46.
	connectableBorder := ClassBox named: 'ConnectableBorder'.
	connectableBorder instanceMethods: #('updateConnectionsLabel' 'connectionPoints' 'sortSubmorphsBy:' 'updateLayout' ).
	"Positioning"
	connectableBorder position: 1008 @ 316.
	connectableBoundingBox := ClassBox named: 'ConnectableBoundingBox'.
	connectableBoundingBox instanceMethods: #('connections' 'updateConnectionsLabel' 'connectionPoints' 'newVerticalBorder' 'newHorizontalBorder' 'newBorder' 'connectionNear:' 'addConnectionPoint:thatConnectsTo:' ).
	"Positioning"
	connectableBoundingBox position: 654 @ 295.
	connectableBoundingCircle := ClassBox named: 'ConnectableBoundingCircle'.
	connectableBoundingCircle instanceVariables: #('points' ).
	connectableBoundingCircle instanceMethods: #('connections' 'connectionNear:' 'addConnectionPoint:thatConnectsTo:' ).
	"Positioning"
	connectableBoundingCircle position: 408 @ 294.
	connectableBounds := InterfaceBox named: 'ConnectableBounds'.
	connectableBounds instanceMethods: #('connections' 'addConnectionPoint:thatConnectsTo:' 'connectionNear:' ).
	"Positioning"
	connectableBounds position: 589 @ 109.
	tConnectableShape := TraitBox named: 'TConnectableShape'.
	tConnectableShape instanceMethods: #('connectTo:using:' 'connections' 'connectTo:' 'handlesMouseDown:' 'connectableBounds' ).
	"Positioning"
	tConnectableShape position: 11 @ 139.
	"Relationships"
	diagramNodeMorph hasA: connectableBounds labeledAs: 'connectableBounds'.
	diagramNodeMorph usesTrait: tConnectableShape.
	"Relationships"
	connectableBoundingBox implements: connectableBounds.
	connectableBoundingBox hasLotsOf: connectableBorder labeledAs: 'borders'.
	"Relationships"
	connectableBoundingCircle implements: connectableBounds.
	d := (ClassDiagram new name: 'Connectable Shapes') addDiagramNode: diagramNodeMorph;
				 addDiagramNode: connectableBorder;
				 addDiagramNode: connectableBoundingBox;
				 addDiagramNode: connectableBoundingCircle;
				 addDiagramNode: connectableBounds;
				 addDiagramNode: tConnectableShape.
	^ d
]

{ #category : #diagrams }
ConnectableShapesDocumentation >> inheritanceforConnection [
	| d connection handledConnection uMLConnection referenceConnection |
	connection := ClassBox named: 'Connection'.
	connection instanceVariables: #('lineWidth' 'smoothCurve' 'vertices' 'segments' 'contours' 'arrows' 'arrowForms' 'arrowScales' 'arrowJoints' 'connectionPoints' 'type' 'borderDashSpec' 'connectionFactory' ).
	connection classVariables: #(#ArrowGlyphs ).
	connection instanceMethods: #('fullLineWidth' 'curveSegmentAt:' 'closestPointTo:' 'arrowScales:' 'arrows:' 'drawSegmentedCurveOnAACanvas:canvas:isShadow:' 'curveInfoNearest:' 'outerBounds' 'drawDashedBorderOn:usingEnds:' 'initialize' 'lineWidth' 'intersectionsWith:' 'defaultBackgroundColor' 'lineSegmentsDo:' 'removeShortEndSegmentsStepping:' 'lastVertex' 'drawOn:' 'to:' 'heading:' 'privateMoveBy:' 'areasRemainingToFill:' 'arrowNames:' 'closestSegmentTo:' 'segments' 'oldBorderWidth:' 'lineSegments' 'rotationCenter' 'makeNoArrows' 'lineWidth:' 'curveVertexAt:put:' 'makeForwardArrow' 'beStraightSegments' 'arrowsContainPoint:' 'close' 'insertVertexAfterEndAt:' 'defaultBitmapFillForm' 'rotationCenter:' 'nextDuplicateVertexIndex' 'lineColor' 'scale' 'reduceVertices' 'hasMouseFocus' 'vertices' 'bezierSegmentsDo:' 'arrowJoints' 'segmentsDo:' 'doesBevels' 'curveBounds' 'arrowScales' 'updateHeadVertex' 'vertices:' 'arrows' 'headConnectionPoint' 'transformedBy:' 'iconsSpecsOnClick' 'bezierPoints' 'innerBounds' 'updateArrowContours' 'arrowVertices' 'connectionPoints:' 'outsideBezierPoints' 'setVertices:' 'interiorCurveSegmentAt:put:' 'lineColor:' 'rotationDegrees:' 'connectionFactory' 'isCurve' 'insertVertexBeforeStartAt:' 'connectionFactory:' 'beSmoothCurve:' 'arrowForms' 'firstVertex' 'makeBothArrows' 'toggleSmoothing' 'tailConnectionPointCenter' 'computeContours' 'curveSegmentAt:put:' 'hasArrows' 'headConnectionPointCenter' 'nextToFirstPoint' 'canDrawBorder:' 'makeBackArrow' 'vertexAt:' 'tailConnectionPoint' 'fullBounds' 'computeBounds' 'vertexPairsDo:' 'contours' 'computeSegments' 'midpoint' 'from:to:' 'straighten' 'totalLength' 'interiorCurveVertexAt:put:' 'verticesAt:put:' 'unrotatedWidth' 'nextToLastPoint' 'defaultArrow' 'lostMouseFocus' 'dashedBorder:' 'arrowContours' 'containsPoint:' 'outsidePoints' 'canHaveFillStyles' 'extent:' 'curveHandleClass' 'contourPoints' 'dashedLine:' 'updateTailVertex' 'updateView' 'beSmoothCurve' 'couldHaveRoundedCorners' 'drawSmoothCurveOnAACanvas:canvas:isShadow:' 'curveVertexAt:' 'referencePosition' 'scale:' 'removeVertex:' 'vertices:color:borderStyle:' 'rotationDegrees' 'vertices:lineWidth:lineColor:borderStyle:' ).
	connection classMethods: #('newAssociation' 'nameForArrowGlyph:' 'clearArrowDictionary' 'newNoteConnector' 'from:to:' 'newWithArrow' 'initializeArrowDictionary' 'newStateTransition' 'initialize' 'basicArrow' 'noArrow' 'defaultArrow' 'newDirectionalAssociation' 'newImplementationRelationship' 'umlArrow' 'newHierarchyAssociation' 'openArrow' 'arrowDictionary' 'newGeneralizationRelationship' 'newCurvyConnector' 'newCurvyArrow' 'vertices:color:borderStyle:' 'showSamples' 'newInheritanceAssociation' 'vertices:lineWidth:lineColor:borderStyle:' ).
	"Positioning"
	connection position: 115 @ 13.
	handledConnection := ClassBox named: 'HandledConnection'.
	handledConnection instanceVariables: #('handles' ).
	handledConnection instanceMethods: #('handleForEvent:' 'click:' 'addHandles' 'endPointHandles' 'endPointHandles:' 'interiorHandleForEvent:' 'initializeInteraction' 'removeHandles' 'initialize' 'handleForPosition:addAllowed:' 'dragHandleStarted:' 'interiorHandleForPosition:addAllowed:' 'handles' 'dragHandleStoped:' ).
	"Positioning"
	handledConnection position: 574 @ 393.
	uMLConnection := ClassBox named: 'UMLConnection'.
	uMLConnection instanceVariables: #('label' 'cardinality' ).
	uMLConnection instanceMethods: #('clipSubmorphs' 'fitIntoDiagram:' 'goesRight' 'dettachFromConnectionPoints' 'connectionPoints' 'isConnected' 'updateLabel' 'step' 'labelText:' 'stepTime' 'goesLeft' 'target:' ).
	uMLConnection classMethods: #('newTraitsUse' 'fromRelation:forDiagram:' 'newInstanceUse' 'newImplementationAssociation' 'newInstanceAssociation' 'newInheritanceAssociation' ).
	"Positioning"
	uMLConnection position: 590 @ 16.
	referenceConnection := ClassBox named: 'ReferenceConnection'.
	referenceConnection instanceMethods: #('updateLabel' 'connectionPoints:' 'initialize' ).
	referenceConnection classMethods: #('newReference' ).
	"Positioning"
	referenceConnection position: 968 @ 139.
	"Relationships"
	handledConnection inheritsFrom: connection.
	"Relationships"
	uMLConnection inheritsFrom: connection.
	"Relationships"
	referenceConnection inheritsFrom: uMLConnection.
	d := (ClassDiagram new name: 'Inheritance for Connection') addDiagramNode: connection;
				 addDiagramNode: handledConnection;
				 addDiagramNode: uMLConnection;
				 addDiagramNode: referenceConnection.
	^ d
]

{ #category : #diagrams }
ConnectableShapesDocumentation >> inheritanceforDiagramNode [
	| d diagramNode objectNode interfaceBox traitBox classBox |
	diagramNode := ClassBox named: 'DiagramNode'.
	diagramNode instanceVariables: #('position' 'relations' 'name' ).
	diagramNode instanceMethods: #('variableNameForDescriptionCode' 'position:' 'writeRelationshipsDescriptionOn:' 'addRelationship:' 'creationCode' 'name:' 'printString' 'position' 'relationshipsCode' 'removeRelationshipsWith:' 'descriptionCodeForEdition' 'name' 'writeDefinitionDescriptionOn:' ).
	diagramNode classMethods: #('named:' ).
	"Positioning"
	diagramNode position: 10 @ 10.
	objectNode := ClassBox named: 'ObjectNode'.
	objectNode instanceVariables: #('object' ).
	objectNode instanceMethods: #('object:' 'updaterClass' 'object' 'hash' 'subject' 'variableNames' 'hasA:labeledAs:' '=' 'label' 'resetConnections' 'view' 'variableNamed:' 'descriptionCodeForEdition' 'connectToReferencesWithin:' 'realDiagramNode' ).
	objectNode classMethods: #('for:' ).
	"Positioning"
	objectNode position: 22 @ 353.
	interfaceBox := ClassBox named: 'InterfaceBox'.
	interfaceBox instanceVariables: #('classMethods' 'instanceMethods' ).
	interfaceBox instanceMethods: #('updaterClass' 'openDescriptionCode' 'instanceMethods:' 'instanceMethods' 'methods' 'boxTitle' 'classMethods' 'height' 'usesTrait:' 'descriptionCode' 'boxTitle:' 'isATypeOf:' 'classMethods:' 'view' 'inheritsFrom:' 'realDiagramNode' 'writeDescription:withValue:on:' 'writeDefinitionDescriptionOn:' ).
	interfaceBox classMethods: #('selectorsAsStrings:' 'newNamed:' ).
	"Positioning"
	interfaceBox position: 359 @ 17.
	traitBox := ClassBox named: 'TraitBox'.
	traitBox instanceMethods: #('view' ).
	traitBox classMethods: #('fromTrait:' ).
	"Positioning"
	traitBox position: 935 @ 33.
	classBox := ClassBox named: 'ClassBox'.
	classBox instanceVariables: #('instanceVariables' 'classInstanceVariables' 'classVariables' 'targetClass' ).
	classBox instanceMethods: #('instanceMethods' 'classVariables' 'implements:' 'height' 'subject' 'classInstanceVariables' 'instanceVariables:' 'classMethods:' 'variables' 'instanceVariables' 'updaterClass' 'instanceMethods:' 'classMethods' 'classInstanceVariables:' 'hasA:labeledAs:' 'targetClass:' 'usesLotsOf:labeledAs:' 'descriptionCode' 'usesA:labeledAs:' 'view' 'isATypeOf:' 'descriptionCodeForEdition' 'inheritsFrom:' 'hasLotsOf:labeledAs:' 'classVariables:' 'writeDefinitionDescriptionOn:' ).
	classBox classMethods: #('fromClass:' ).
	"Positioning"
	classBox position: 906 @ 186.
	"Relationships"
	objectNode inheritsFrom: diagramNode.
	"Relationships"
	interfaceBox inheritsFrom: diagramNode.
	"Relationships"
	traitBox inheritsFrom: interfaceBox.
	"Relationships"
	classBox inheritsFrom: interfaceBox.
	d := (ClassDiagram new name: 'Inheritance for DiagramNode') addDiagramNode: diagramNode;
				 addDiagramNode: objectNode;
				 addDiagramNode: interfaceBox;
				 addDiagramNode: traitBox;
				 addDiagramNode: classBox.
	^ d
]

{ #category : #diagrams }
ConnectableShapesDocumentation >> inheritanceforDiagramNodeMorph [
	| d diagramNodeMorph interfaceBoxMorph classBoxMorph traitBoxMorph objectNodeMorph |
	diagramNodeMorph := ClassBox named: 'DiagramNodeMorph'.
	diagramNodeMorph instanceVariables: #('container' 'diagramNode' 'dragEventHandler' ).
	diagramNodeMorph instanceMethods: #('connectTo:using:' 'update:' 'connections' 'mouseUp:' 'connectTo:' 'relations' 'handlesMouseDown:' 'diagramNode:' 'adjustPosition' 'connectableBounds' 'step' 'initialize' 'updateLayout' 'wantsToBeDroppedInto:' 'mouseDown:' 'justDroppedInto:event:' 'mouseMove:' ).
	"Positioning"
	diagramNodeMorph position: 116 @ 23.
	interfaceBoxMorph := ClassBox named: 'InterfaceBoxMorph'.
	interfaceBoxMorph instanceVariables: #('methodsBox' 'boundingBox' 'titleBox' ).
	interfaceBoxMorph instanceMethods: #('newText' 'newRectangle' 'update:' 'formattedText:' 'textMorphFor:withEmphasis:' 'addTextMorphFor:into:withEmphasis:' 'textMorphClass' 'diagramNode:' 'updateBounds' 'connectableBounds' 'initialize' 'addTextMorphFor:into:' 'initializeBoundingBox' 'updateRelationships' 'defaultBorderStyle' 'updateTitle' 'descriptionCode' 'connectionBorderNear:' 'updateMethods' 'textMorphFor:' 'fontSize' 'addBoxesToContainer' 'insideBorderStyle' 'listFrom:' ).
	interfaceBoxMorph classMethods: #('forBox:' ).
	"Positioning"
	interfaceBoxMorph position: 10 @ 376.
	classBoxMorph := ClassBox named: 'ClassBoxMorph'.
	classBoxMorph instanceVariables: #('variablesBox' ).
	classBoxMorph instanceMethods: #('diagramNode:' 'initializeBoundingBox' 'defaultBorderStyle' 'updateVariables' 'addBoxesToContainer' ).
	"Positioning"
	classBoxMorph position: 10 @ 762.
	traitBoxMorph := ClassBox named: 'TraitBoxMorph'.
	traitBoxMorph instanceMethods: #('initializeBoundingBox' ).
	"Positioning"
	traitBoxMorph position: 164 @ 762.
	objectNodeMorph := ClassBox named: 'ObjectNodeMorph'.
	objectNodeMorph instanceVariables: #('innerReferencesGuide' 'connectableBounds' 'label' ).
	objectNodeMorph instanceMethods: #('drawOn:' 'updateLabel' 'diagramNode:' 'updateBounds' 'connectableBounds' 'initialize' 'updateLayout' ).
	objectNodeMorph classMethods: #('for:' ).
	"Positioning"
	objectNodeMorph position: 228 @ 376.
	"Relationships"
	interfaceBoxMorph inheritsFrom: diagramNodeMorph.
	"Relationships"
	classBoxMorph inheritsFrom: interfaceBoxMorph.
	"Relationships"
	traitBoxMorph inheritsFrom: interfaceBoxMorph.
	"Relationships"
	objectNodeMorph inheritsFrom: diagramNodeMorph.
	d := (ClassDiagram new name: 'Inheritance for DiagramNodeMorph') addDiagramNode: diagramNodeMorph;
				 addDiagramNode: interfaceBoxMorph;
				 addDiagramNode: classBoxMorph;
				 addDiagramNode: traitBoxMorph;
				 addDiagramNode: objectNodeMorph.
	^ d
]
