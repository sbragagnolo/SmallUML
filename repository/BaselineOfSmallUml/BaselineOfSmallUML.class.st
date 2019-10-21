Class {
	#name : #BaselineOfSmallUml,
	#superclass : #BaselineOf,
	#category : #BaselineOfSmallUml
}

{ #category : #baselines }
BaselineOfSmallUml >> baseline: spec [ 
	<baseline>
	
	spec for: #common do: [
		self minimalConnectors: spec.
		spec 
			package: 'SUML-ClassDiagramModel';
			package: 'SUML-ObjectDiagramModel';
			package: 'SUML-SequenceDiagramModel';
			package: 'SUML-Tools' with: [ spec requires: 'MinimalConnectors'.  ];
			package: 'SUML-DiagramDrawing' with: [ spec requires: 'MinimalConnectors'];
			package: 'SUML-ModelExample';

			group: 'default' with: #('Model' 'Drawing');
			group: 'Model' with: #('SUML-ClassDiagramModel' 'SUML-SequenceDiagramModel' 'SUML-ObjectDiagramModel' 'SUML-ModelExample');
			group: 'Drawing' with: #('MinimalConnectors' 'SUML-DiagramDrawing' 'SUML-Tools' ).
		]
]

{ #category : #baselines }
BaselineOfSmallUml >> minimalConnectors: spec [
	spec
    	baseline: 'MinimalConnectors'
    	with: [ spec repository: 'github://sbragagnolo/MinimalConnectors/repository' ]
]
