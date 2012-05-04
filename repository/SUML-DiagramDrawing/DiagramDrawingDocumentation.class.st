Class {
	#name : #DiagramDrawingDocumentation,
	#superclass : #CategoryDiagramsHolder,
	#category : #'SUML-DiagramDrawing'
}

{ #category : #diagrams }
DiagramDrawingDocumentation >> connectableshapes [
	| d interfaceBoxMorph connectableShape |
	interfaceBoxMorph := ClassBox named: 'InterfaceBoxMorph'.
	interfaceBoxMorph instanceVariables: #('methodsBox' 'boundingBox' 'titleBox' 'instanceMethods' 'classMethods' ).
	interfaceBoxMorph instanceMethods: #('connectableBounds' 'asdfasf' ).
	interfaceBoxMorph classMethods: #('forBox:' ).
	"forBox:"
	interfaceBoxMorph position: 145.0 @ 89.0.
	connectableShape := TraitBox named: 'ConnectableShape'.
	connectableShape instanceMethods: #('connectableBoundingBox' 'connectTo:using:' 'connections' 'connectionBorderNear:' ).
	"connectionBorderNear:"
	connectableShape position: 632.0 @ 138.0.
	"position:"
	interfaceBoxMorph usesTrait: connectableShape.
	d := (ClassDiagram new name: 'Connectable shapes') addDiagramNode: interfaceBoxMorph;
				 addDiagramNode: connectableShape.
	^ d
]

{ #category : #diagrams }
DiagramDrawingDocumentation >> inheritanceforConnection [
	| d connection handledConnection uMLConnection referenceConnection |
	connection := ClassBox named: 'Connection'.
	connection instanceVariables: #('lineWidth' 'smoothCurve' 'vertices' 'segments' 'contours' 'arrows' 'arrowForms' 'arrowScales' 'arrowJoints' 'connectionPoints' 'type' 'borderDashSpec' 'connectionFactory' ).
	connection classVariables: #(#ArrowGlyphs ).
	connection instanceMethods: #('canHaveFillStyles' 'closestPointTo:' 'bezierSegmentsDo:' 'outerBounds' 'drawDashedBorderOn:usingEnds:' 'initialize' 'insertVertexAfterEndAt:' 'lineWidth' 'intersectionsWith:' 'curveVertexAt:put:' 'defaultBackgroundColor' 'lineSegmentsDo:' 'lastVertex' 'drawOn:' 'to:' 'tailConnectionPointCenter' 'privateMoveBy:' 'areasRemainingToFill:' 'curveHandleClass' 'connectionFactory:' 'closestSegmentTo:' 'segments' 'lineSegments' 'rotationCenter' 'arrowNames:' 'updateHeadVertex' 'makeNoArrows' 'lineWidth:' 'makeForwardArrow' 'beStraightSegments' 'arrowsContainPoint:' 'close' 'removeShortEndSegmentsStepping:' 'defaultBitmapFillForm' 'interiorCurveSegmentAt:put:' 'rotationCenter:' 'dashedLine:' 'insertVertexBeforeStartAt:' 'nextDuplicateVertexIndex' 'lineColor' 'connectionPoints:' 'scale' 'beSmoothCurve:' 'vertexPairsDo:' 'curveInfoNearest:' 'reduceVertices' 'vertices' 'heading:' 'arrows:' 'vertices:color:borderStyle:' 'arrowVertices' 'vertices:lineWidth:lineColor:borderStyle:' 'hasMouseFocus' 'segmentsDo:' 'arrowScales' 'doesBevels' 'curveBounds' 'drawSmoothCurveOnAACanvas:canvas:isShadow:' 'headConnectionPointCenter' 'tailConnectionPoint' 'arrows' 'vertices:' 'transformedBy:' 'bezierPoints' 'connectionFactory' 'headConnectionPoint' 'innerBounds' 'setVertices:' 'updateTailVertex' 'lostMouseFocus' 'lineColor:' 'curveVertexAt:' 'rotationDegrees:' 'drawSegmentedCurveOnAACanvas:canvas:isShadow:' 'arrowJoints' 'defaultArrow' 'isCurve' 'makeBothArrows' 'oldBorderWidth:' 'iconsSpecsOnClick' 'arrowForms' 'curveSegmentAt:' 'firstVertex' 'outsideBezierPoints' 'toggleSmoothing' 'computeContours' 'updateArrowContours' 'hasArrows' 'nextToFirstPoint' 'canDrawBorder:' 'makeBackArrow' 'vertexAt:' 'fullBounds' 'arrowContours' 'computeBounds' 'outsidePoints' 'interiorCurveVertexAt:put:' 'computeSegments' 'contours' 'midpoint' 'from:to:' 'straighten' 'totalLength' 'verticesAt:put:' 'arrowScales:' 'nextToLastPoint' 'unrotatedWidth' 'curveSegmentAt:put:' 'contourPoints' 'dashedBorder:' 'containsPoint:' 'extent:' 'updateView' 'beSmoothCurve' 'couldHaveRoundedCorners' 'referencePosition' 'scale:' 'removeVertex:' 'fullLineWidth' 'rotationDegrees' ).
	connection classMethods: #('nameForArrowGlyph:' 'newGeneralizationRelationship' 'initializeArrowDictionary' 'newCurvyConnector' 'newStateTransition' 'from:to:' 'newAssociation' 'newCurvyArrow' 'noArrow' 'initialize' 'openArrow' 'vertices:color:borderStyle:' 'defaultArrow' 'newDirectionalAssociation' 'umlArrow' 'vertices:lineWidth:lineColor:borderStyle:' 'newNoteConnector' 'newImplementationRelationship' 'arrowDictionary' 'basicArrow' 'clearArrowDictionary' 'newHierarchyAssociation' 'newInheritanceAssociation' 'showSamples' 'newWithArrow' ).
	"newWithArrow"
	connection position: 372.0 @ 3.0.
	handledConnection := ClassBox named: 'HandledConnection'.
	handledConnection instanceVariables: #('handles' ).
	handledConnection instanceMethods: #('handleForPosition:addAllowed:' 'interiorHandleForPosition:addAllowed:' 'click:' 'addHandles' 'dragHandleStoped:' 'endPointHandles:' 'handleForEvent:' 'initializeInteraction' 'removeHandles' 'initialize' 'endPointHandles' 'interiorHandleForEvent:' 'handles' 'dragHandleStarted:' ).
	"dragHandleStarted:"
	handledConnection position: 6.0 @ 104.0.
	uMLConnection := ClassBox named: 'UMLConnection'.
	uMLConnection instanceVariables: #('label' 'cardinality' ).
	uMLConnection instanceMethods: #('clipSubmorphs' 'dettachFromConnectionPoints' 'destinationDiagramNodeMorphIn:' 'goesLeft' 'mouseUp:' 'connectionPoints' 'fitIntoDiagram:' 'isConnected' 'goesRight' 'handlesMouseDown:' 'step' 'originDiagramNodeMorphIn:' 'labelText:' 'mouseDown:' 'updateLabel' 'target:' ).
	uMLConnection classMethods: #('newImplementationAssociation' 'fromRelation:forDiagram:' 'newTraitsUse' 'newInheritanceAssociation' 'newInstanceUse' 'newInstanceAssociation' ).
	"newInstanceAssociation"
	uMLConnection position: 711.0 @ 61.0.
	referenceConnection := ClassBox named: 'ReferenceConnection'.
	referenceConnection instanceMethods: #('center' 'mouseDown:' 'updateLabel' ).
	referenceConnection classMethods: #('newReference' ).
	"newReference"
	referenceConnection position: 456.0 @ 219.0.
	"position:"
	handledConnection inheritsFrom: connection.
	"connection"
	uMLConnection inheritsFrom: connection.
	"connection"
	referenceConnection inheritsFrom: uMLConnection.
	d := (ClassDiagram new name: 'Inheritance for Connection') addDiagramNode: connection;
				 addDiagramNode: handledConnection;
				 addDiagramNode: uMLConnection;
				 addDiagramNode: referenceConnection.
	^ d
]
