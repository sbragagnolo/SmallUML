Class {
	#name : #DiagramDrawingDocumentation,
	#superclass : #CategoryDiagramsHolder,
	#category : #'SUML-DiagramDrawing'
}

{ #category : #diagrams }
DiagramDrawingDocumentation >> connectableShapes [
	| d interfaceBoxMorph connectableShape |
	interfaceBoxMorph := ClassBox named: 'InterfaceBoxMorph'.
	interfaceBoxMorph instanceMethods: #('connectableBoundingBox' ).
	"Positioning"
	interfaceBoxMorph position: 257 @ 286.
	connectableShape := TraitBox named: 'ConnectableShape'.
	connectableShape instanceMethods: #('connectableBoundingBox' 'connectTo:using:' 'connections' 'connectionBorderNear:' ).
	"Positioning"
	connectableShape position: 238 @ 71.
	"Relationships"
	interfaceBoxMorph usesTrait: connectableShape.
	d := (ClassDiagram new name: 'Connectable Shapes') addDiagramNode: interfaceBoxMorph;
				 addDiagramNode: connectableShape.
	^ d
]

{ #category : #diagrams }
DiagramDrawingDocumentation >> inheritanceforConnection [
	| d connection handledConnection uMLConnection referenceConnection |
	connection := ClassBox named: 'Connection'.
	connection instanceVariables: #('lineWidth' 'smoothCurve' 'vertices' 'segments' 'contours' 'arrows' 'arrowForms' 'arrowScales' 'arrowJoints' 'connectionPoints' 'type' 'borderDashSpec' 'connectionFactory' ).
	connection classVariables: #(#ArrowGlyphs ).
	connection instanceMethods: #('fullLineWidth' 'curveSegmentAt:' 'closestPointTo:' 'arrowScales:' 'arrows:' 'drawSegmentedCurveOnAACanvas:canvas:isShadow:' 'curveInfoNearest:' 'outerBounds' 'drawDashedBorderOn:usingEnds:' 'initialize' 'lineWidth' 'intersectionsWith:' 'defaultBackgroundColor' 'lineSegmentsDo:' 'removeShortEndSegmentsStepping:' 'lastVertex' 'drawOn:' 'to:' 'heading:' 'privateMoveBy:' 'areasRemainingToFill:' 'arrowNames:' 'closestSegmentTo:' 'segments' 'oldBorderWidth:' 'lineSegments' 'rotationCenter' 'makeNoArrows' 'lineWidth:' 'curveVertexAt:put:' 'makeForwardArrow' 'beStraightSegments' 'arrowsContainPoint:' 'close' 'insertVertexAfterEndAt:' 'defaultBitmapFillForm' 'rotationCenter:' 'nextDuplicateVertexIndex' 'lineColor' 'scale' 'reduceVertices' 'hasMouseFocus' 'vertices' 'bezierSegmentsDo:' 'arrowJoints' 'segmentsDo:' 'doesBevels' 'curveBounds' 'arrowScales' 'updateHeadVertex' 'vertices:' 'arrows' 'headConnectionPoint' 'transformedBy:' 'iconsSpecsOnClick' 'bezierPoints' 'innerBounds' 'updateArrowContours' 'arrowVertices' 'connectionPoints:' 'outsideBezierPoints' 'setVertices:' 'interiorCurveSegmentAt:put:' 'lineColor:' 'rotationDegrees:' 'connectionFactory' 'isCurve' 'insertVertexBeforeStartAt:' 'connectionFactory:' 'beSmoothCurve:' 'arrowForms' 'firstVertex' 'makeBothArrows' 'toggleSmoothing' 'tailConnectionPointCenter' 'computeContours' 'curveSegmentAt:put:' 'hasArrows' 'headConnectionPointCenter' 'nextToFirstPoint' 'canDrawBorder:' 'makeBackArrow' 'vertexAt:' 'tailConnectionPoint' 'fullBounds' 'computeBounds' 'vertexPairsDo:' 'contours' 'computeSegments' 'midpoint' 'from:to:' 'straighten' 'totalLength' 'interiorCurveVertexAt:put:' 'verticesAt:put:' 'unrotatedWidth' 'nextToLastPoint' 'defaultArrow' 'lostMouseFocus' 'dashedBorder:' 'arrowContours' 'containsPoint:' 'outsidePoints' 'canHaveFillStyles' 'extent:' 'curveHandleClass' 'contourPoints' 'dashedLine:' 'updateTailVertex' 'updateView' 'beSmoothCurve' 'couldHaveRoundedCorners' 'drawSmoothCurveOnAACanvas:canvas:isShadow:' 'curveVertexAt:' 'referencePosition' 'scale:' 'removeVertex:' 'vertices:color:borderStyle:' 'rotationDegrees' 'vertices:lineWidth:lineColor:borderStyle:' ).
	connection classMethods: #('newAssociation' 'nameForArrowGlyph:' 'clearArrowDictionary' 'newNoteConnector' 'from:to:' 'newWithArrow' 'initializeArrowDictionary' 'newStateTransition' 'initialize' 'basicArrow' 'noArrow' 'defaultArrow' 'newDirectionalAssociation' 'newImplementationRelationship' 'umlArrow' 'newHierarchyAssociation' 'openArrow' 'arrowDictionary' 'newGeneralizationRelationship' 'newCurvyConnector' 'newCurvyArrow' 'vertices:color:borderStyle:' 'showSamples' 'newInheritanceAssociation' 'vertices:lineWidth:lineColor:borderStyle:' ).
	"Positioning"
	connection position: 10 @ 10.
	handledConnection := ClassBox named: 'HandledConnection'.
	handledConnection instanceVariables: #('handles' ).
	handledConnection instanceMethods: #('handleForEvent:' 'click:' 'addHandles' 'endPointHandles' 'endPointHandles:' 'interiorHandleForEvent:' 'initializeInteraction' 'removeHandles' 'initialize' 'handleForPosition:addAllowed:' 'dragHandleStarted:' 'interiorHandleForPosition:addAllowed:' 'handles' 'dragHandleStoped:' ).
	"Positioning"
	handledConnection position: 10 @ 712.
	uMLConnection := ClassBox named: 'UMLConnection'.
	uMLConnection instanceVariables: #('label' 'cardinality' ).
	uMLConnection instanceMethods: #('clipSubmorphs' 'fitIntoDiagram:' 'goesRight' 'dettachFromConnectionPoints' 'connectionPoints' 'isConnected' 'updateLabel' 'step' 'labelText:' 'stepTime' 'goesLeft' 'target:' ).
	uMLConnection classMethods: #('newTraitsUse' 'fromRelation:forDiagram:' 'newInstanceUse' 'newImplementationAssociation' 'newInstanceAssociation' 'newInheritanceAssociation' ).
	"Positioning"
	uMLConnection position: 235 @ 712.
	referenceConnection := ClassBox named: 'ReferenceConnection'.
	referenceConnection instanceMethods: #('updateLabel' 'connectionPoints:' 'initialize' ).
	referenceConnection classMethods: #('newReference' ).
	"Positioning"
	referenceConnection position: 10 @ 1110.
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
