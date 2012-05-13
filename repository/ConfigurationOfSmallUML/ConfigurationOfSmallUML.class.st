Class {
	#name : #ConfigurationOfSmallUML,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfSmallUML
}

{ #category : #private }
ConfigurationOfSmallUML class >> bootstrapPackage: aString from: aPath [ 
	| repository version |
	repository := MCHttpRepository
				location: aPath
				user: ''
				password: ''.
	repository
		versionReaderForFileNamed: aString , '.mcz'
		do: [:reader | 
			version := reader version.
			version load.
			version workingCopy repositoryGroup addRepository: repository]
]

{ #category : #private }
ConfigurationOfSmallUML class >> ensureMetacello [
	"Bootstrap Gofer (if necessary), bootstrap ConfigurationOfMetacello (using old Gofer API), then load the latest 
	version of Metacello itself."

	Smalltalk at: #MetacelloProject ifAbsent: [
		Smalltalk at: #Gofer ifAbsent: [
			"Current version of Gofer from which to bootstrap - as of 1.0-beta.21"
			self bootstrapPackage: 'Gofer-Core-lr.115' from: 'http://seaside.gemstone.com/ss/metacello' ].
		Smalltalk at: #Gofer ifPresent: [:goferClass | | gofer |
			gofer := goferClass new
				url: 'http://seaside.gemstone.com/ss/metacello';
				yourself.
			[ gofer addPackage: 'ConfigurationOfMetacello' ] on: Warning do: [:ex | ex resume ].
			gofer load ].
		"load 'default' group of Metacello"
		(Smalltalk at: #ConfigurationOfMetacello) perform: #load ]
]

{ #category : #'metacello tool support' }
ConfigurationOfSmallUML class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #'metacello tool support' }
ConfigurationOfSmallUML class >> lastMetacelloVersionLoad [
	"Answer the last version loaded and the list of packages loaded for that version."

	LastVersionLoad == nil ifTrue: [ LastVersionLoad := nil -> 'default' ].
	^LastVersionLoad
]

{ #category : #loading }
ConfigurationOfSmallUML class >> load [
	"self load"

	^self project latestVersion load
]

{ #category : #'metacello tool support' }
ConfigurationOfSmallUML class >> metacelloVersion: versionString loads: anArrayOrString [
	"Stash the last version loaded and the list of packages loaded for that version. The list
	 of packages will be used by the tools when doing 'Load Package Version'"

	LastVersionLoad := versionString -> anArrayOrString
]

{ #category : #accessing }
ConfigurationOfSmallUML class >> project [

	^self new project
]

{ #category : #'unloading Metacello' }
ConfigurationOfSmallUML class >> unloadMetacello [

	Smalltalk at: #ConfigurationOfMetacello ifPresent: [:cls | cls unloadMetacello ]
]

{ #category : #baselines }
ConfigurationOfSmallUML >> baseline100: spec [ 
	<version: '0.1-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/smallUML'.	
		spec 
			package: 'UMLClassDiagramModel';
			package: 'UMLSequenceDiagramModel';
			package: 'Gaucho-Morphic-Core';
			package: 'MinimalConnectors-CurvesAndArrows';
			package: 'Gaucho-Morphic-Connectors'  with: [spec requires: 'Gaucho-Morphic-Core'. spec requires: 'MinimalConnectors-CurvesAndArrows']; 
			package: 'Gaucho-Morphic-InteractionPolicies';
			package: 'UMLDiagramDrawing' with: [ spec requires: 'MinimalConnectors-CurvesAndArrows'. ];
			package: 'UMLDiagramDescriptionTests' with: [ spec requires: 'UMLClassDiagramModel'. spec requires: 'UMLSequenceDiagramModel'. spec requires: 'Gaucho-Morphic-Connectors' ].
		spec
			group: 'default' with: #('Model' 'Drawing');
			group: 'Model' with: #('UMLClassDiagramModel' 'UMLSequenceDiagramModel');
			group: 'Drawing' with: #('MinimalConnectors-CurvesAndArrows' 'Gaucho-Morphic-Core' 'Gaucho-Morphic-Connectors' 'Gaucho-Morphic-InteractionPolicies' 'UMLDiagramDrawing');
			group: 'Tests' with: #('UMLDiagramDescriptionTests'). ].
]

{ #category : #baselines }
ConfigurationOfSmallUML >> baseline200: spec [ 
	<version: '0.2-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/smallUML'.	
		spec 
			package: 'UMLClassDiagramModel';
			package: 'UMLSequenceDiagramModel';
			package: 'Gaucho-Morphic-Core';
			package: 'MinimalConnectors-CurvesAndArrows';
			package: 'Gaucho-Morphic-Connectors'  with: [spec requires: 'Gaucho-Morphic-Core'. spec requires: 'MinimalConnectors-CurvesAndArrows']; 
			package: 'Gaucho-Morphic-InteractionPolicies';
			package: 'UMLDiagramsTools';
			package: 'UMLDiagramDrawing' with: [ spec requires: 'MinimalConnectors-CurvesAndArrows'. ];
			package: 'UMLDiagramDescriptionTests' with: [ spec requires: 'UMLClassDiagramModel'. spec requires: 'UMLSequenceDiagramModel'. spec requires: 'Gaucho-Morphic-Connectors' ].
		spec
			group: 'default' with: #('Model' 'Drawing');
			group: 'Model' with: #('UMLClassDiagramModel' 'UMLSequenceDiagramModel');
			group: 'Drawing' with: #('MinimalConnectors-CurvesAndArrows' 'Gaucho-Morphic-Core' 'Gaucho-Morphic-Connectors' 'Gaucho-Morphic-InteractionPolicies' 'UMLDiagramDrawing' 'UMLDiagramsTools');
			group: 'Tests' with: #('UMLDiagramDescriptionTests'). ].
]

{ #category : #baselines }
ConfigurationOfSmallUML >> baseline300: spec [ 
	<version: '0.3-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		
		spec repository: 'http://www.squeaksource.com/smallUML'.	
		spec 
			package: 'SUML-ClassDiagramModel';
			package: 'SUML-SequenceDiagramModel';
			package: 'SUML-Tools';
			project: 'MinimalConnectors' with:[spec
					className: 'ConfigurationOfMinimalConnectors';
					versionString: '0.1-baseline';
					loads: #('Core' );
					file: 'ConfigurationOfMinimalConnectors';
					repository: 'http://www.squeaksource.com/MinimalConnectors'. ];
			package: 'SUML-DiagramDrawing' with: [ spec requires: 'MinimalConnectors'.  ];

			group: 'default' with: #('Model' 'Drawing');
			group: 'Model' with: #('SUML-ClassDiagramModel' 'SUML-SequenceDiagramModel');
			group: 'Drawing' with: #('SUML-DiagramDrawing' 'SUML-Tools' 'MinimalConnectors').
		]
]

{ #category : #baselines }
ConfigurationOfSmallUML >> baseline400: spec [ 
	<version: '0.4-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		
		spec repository: 'http://www.squeaksource.com/smallUML'.	
		spec 
			package: 'SUML-ClassDiagramModel';
			package: 'SUML-ObjectDiagramModel';
			package: 'SUML-SequenceDiagramModel';
			project: 'MinimalConnectors' with:[spec
					className: 'ConfigurationOfMinimalConnectors';
					versionString: '0.2';
					loads: #('Core' );
					file: 'ConfigurationOfMinimalConnectors';
					repository: 'http://www.squeaksource.com/MinimalConnectors'. ];
			package: 'SUML-Tools' with: [ spec requires: 'MinimalConnectors'.  ];
			package: 'SUML-DiagramDrawing' with: [ spec requires: 'MinimalConnectors'.  ];

			group: 'default' with: #('Model' 'Drawing');
			group: 'Model' with: #('SUML-ClassDiagramModel' 'SUML-SequenceDiagramModel' 'SUML-ObjectDiagramModel');
			group: 'Drawing' with: #('SUML-DiagramDrawing' 'SUML-Tools' 'MinimalConnectors').
		]
]

{ #category : #baselines }
ConfigurationOfSmallUML >> baseline500: spec [ 
	<version: '0.5-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		
		spec repository: 'http://www.squeaksource.com/smallUML'.	
		spec 
			package: 'SUML-ClassDiagramModel';
			package: 'SUML-ObjectDiagramModel';
			package: 'SUML-SequenceDiagramModel';
			project: 'MinimalConnectors' with:[spec
					className: 'ConfigurationOfMinimalConnectors';
					versionString: '0.5';
					loads: #('Core' );
					file: 'ConfigurationOfMinimalConnectors';
					repository: 'http://www.squeaksource.com/MinimalConnectors'. ];
			package: 'SUML-Tools' with: [ spec requires: 'MinimalConnectors'.  ];
			package: 'SUML-DiagramDrawing' with: [ spec requires: 'MinimalConnectors'.  ];

			group: 'default' with: #('Model' 'Drawing');
			group: 'Model' with: #('SUML-ClassDiagramModel' 'SUML-SequenceDiagramModel' 'SUML-ObjectDiagramModel');
			group: 'Drawing' with: #('MinimalConnectors' 'SUML-DiagramDrawing' 'SUML-Tools' ).
		]
]

{ #category : #baselines }
ConfigurationOfSmallUML >> baseline600: spec [ 
	<version: '0.6-baseline'>
	
	spec for: #common do: [
		spec blessing: #release.
		
		spec repository: 'http://www.squeaksource.com/smallUML'.	
		spec 
			package: 'SUML-ClassDiagramModel';
			package: 'SUML-ObjectDiagramModel';
			package: 'SUML-SequenceDiagramModel';
			project: 'MinimalConnectors' with:[spec
					className: 'ConfigurationOfMinimalConnectors';
					versionString: '0.6';
					loads: #('Core' );
					file: 'ConfigurationOfMinimalConnectors';
					repository: 'http://www.squeaksource.com/MinimalConnectors'. ];
			package: 'SUML-Tools' with: [ spec requires: 'MinimalConnectors'.  ];
			package: 'SUML-DiagramDrawing' with: [ spec requires: 'MinimalConnectors'.  ];

			group: 'default' with: #('Model' 'Drawing');
			group: 'Model' with: #('SUML-ClassDiagramModel' 'SUML-SequenceDiagramModel' 'SUML-ObjectDiagramModel');
			group: 'Drawing' with: #('MinimalConnectors' 'SUML-DiagramDrawing' 'SUML-Tools' ).
		]
]

{ #category : #baselines }
ConfigurationOfSmallUML >> baseline700: spec [ 
	<version: '0.7-baseline'>
	
	spec for: #common do: [
		spec blessing: #release.
		
		spec repository: 'http://www.squeaksource.com/smallUML'.	
		spec 
			package: 'SUML-ClassDiagramModel';
			package: 'SUML-ObjectDiagramModel';
			package: 'SUML-SequenceDiagramModel';
			project: 'MinimalConnectors' with:[spec
					className: 'ConfigurationOfMinimalConnectors';
					versionString: '0.6';
					loads: #('Core' );
					file: 'ConfigurationOfMinimalConnectors';
					repository: 'http://www.squeaksource.com/MinimalConnectors'. ];
			package: 'SUML-Tools' with: [ spec requires: 'MinimalConnectors'.  ];
			package: 'SUML-DiagramDrawing' with: [ spec requires: 'MinimalConnectors'];
			package: 'SUML-ModelExample';

			group: 'default' with: #('Model' 'Drawing');
			group: 'Model' with: #('SUML-ClassDiagramModel' 'SUML-SequenceDiagramModel' 'SUML-ObjectDiagramModel' 'SUML-ModelExample');
			group: 'Drawing' with: #('MinimalConnectors' 'SUML-DiagramDrawing' 'SUML-Tools' ).
		]
]

{ #category : #accessing }
ConfigurationOfSmallUML >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #versions }
ConfigurationOfSmallUML >> stable: spec [  
	<symbolicVersion: #stable>
	
	spec for: #'pharo1.2.x' version: '1.1.3'.
	spec for: #'pharo1.3.x' version: '1.1.4'.
	spec for: #'pharo1.4.x' version: '1.1.5'.
]

{ #category : #versions }
ConfigurationOfSmallUML >> version01: spec [ 
	<version: '0.1' imports: #('0.1-baseline') >
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec 
			package: 'UMLClassDiagramModel' with:'UMLClassDiagramModel-carlaGriggio.3';
			package: 'UMLSequenceDiagramModel' with: 'UMLSequenceDiagramModel-carlaGriggio.3';
			package: 'MinimalConnectors-CurvesAndArrows' with:'MinimalConnectors-CurvesAndArrows-carlaGriggio.5';
			package: 'Gaucho-Morphic-Connectors' with:'Gaucho-Morphic-Connectors-carlaGriggio.25'; 
			package: 'Gaucho-Morphic-Core' with:'Gaucho-Morphic-Core-carlaGriggio.214';
			package: 'Gaucho-Morphic-InteractionPolicies' with: 'Gaucho-Morphic-InteractionPolicies-carlaGriggio.174';
			package: 'UMLDiagramDrawing' with: 'UMLDiagramDrawing-carlaGriggio.6';
			package: 'UMLDiagramDescriptionTests' with: 'UMLDiagramDescriptionTests-carlaGriggio.3'].
]

{ #category : #versions }
ConfigurationOfSmallUML >> version02: spec [ 
	<version: '0.2' imports: #('0.2-baseline') >
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec 
			package: 'UMLClassDiagramModel' with:'UMLClassDiagramModel-carlaGriggio.5';
			package: 'UMLSequenceDiagramModel' with: 'UMLSequenceDiagramModel-carlaGriggio.3';
			package: 'MinimalConnectors-CurvesAndArrows' with:'MinimalConnectors-CurvesAndArrows-carlaGriggio.5';
			package: 'Gaucho-Morphic-Connectors' with:'Gaucho-Morphic-Connectors-carlaGriggio.25'; 
			package: 'Gaucho-Morphic-Core' with:'Gaucho-Morphic-Core-carlaGriggio.214';
			package: 'Gaucho-Morphic-InteractionPolicies' with: 'Gaucho-Morphic-InteractionPolicies-carlaGriggio.174';
			package: 'UMLDiagramDrawing' with: 'UMLDiagramDrawing-carlaGriggio.9';
			package: 'UMLDiagramDescriptionTests' with: 'UMLDiagramDescriptionTests-carlaGriggio.3';
			package: 'UMLDiagramsTools' with: 'UMLDiagramsTools-carlaGriggio.1'].
]

{ #category : #versions }
ConfigurationOfSmallUML >> version03: spec [ 
	<version: '0.3' imports: #('0.2-baseline') >
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec 
			package: 'UMLClassDiagramModel' with:'UMLClassDiagramModel-carlaGriggio.5';
			package: 'UMLSequenceDiagramModel' with: 'UMLSequenceDiagramModel-carlaGriggio.3';
			package: 'MinimalConnectors-CurvesAndArrows' with:'MinimalConnectors-CurvesAndArrows-carlaGriggio.5';
			package: 'Gaucho-Morphic-Connectors' with:'Gaucho-Morphic-Connectors-carlaGriggio.25'; 
			package: 'Gaucho-Morphic-Core' with:'Gaucho-Morphic-Core-carlaGriggio.214';
			package: 'Gaucho-Morphic-InteractionPolicies' with: 'Gaucho-Morphic-InteractionPolicies-carlaGriggio.174';
			package: 'UMLDiagramDrawing' with: 'UMLDiagramDrawing-carlaGriggio.10';
			package: 'UMLDiagramDescriptionTests' with: 'UMLDiagramDescriptionTests-carlaGriggio.3';
			package: 'UMLDiagramsTools' with: 'UMLDiagramsTools-carlaGriggio.4'].
]

{ #category : #versions }
ConfigurationOfSmallUML >> version04: spec [ 
	<version: '0.4' imports: #('0.2-baseline') >
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec 
			package: 'UMLClassDiagramModel' with:'UMLClassDiagramModel-carlaGriggio.7';
			package: 'UMLSequenceDiagramModel' with: 'UMLSequenceDiagramModel-carlaGriggio.3';
			package: 'MinimalConnectors-CurvesAndArrows' with:'MinimalConnectors-CurvesAndArrows-carlaGriggio.5';
			package: 'Gaucho-Morphic-Connectors' with:'Gaucho-Morphic-Connectors-carlaGriggio.25'; 
			package: 'Gaucho-Morphic-Core' with:'Gaucho-Morphic-Core-carlaGriggio.214';
			package: 'Gaucho-Morphic-InteractionPolicies' with: 'Gaucho-Morphic-InteractionPolicies-carlaGriggio.174';
			package: 'UMLDiagramDrawing' with: 'UMLDiagramDrawing-carlaGriggio.12';
			package: 'UMLDiagramDescriptionTests' with: 'UMLDiagramDescriptionTests-carlaGriggio.3';
			package: 'UMLDiagramsTools' with: 'UMLDiagramsTools-carlaGriggio.5'].
]

{ #category : #versions }
ConfigurationOfSmallUML >> version05: spec [ 
	<version: '0.5' imports: #('0.2-baseline') >
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec 
			package: 'UMLClassDiagramModel' with:'UMLClassDiagramModel-carlaGriggio.8';
			package: 'UMLSequenceDiagramModel' with: 'UMLSequenceDiagramModel-carlaGriggio.3';
			package: 'MinimalConnectors-CurvesAndArrows' with:'MinimalConnectors-CurvesAndArrows-carlaGriggio.5';
			package: 'Gaucho-Morphic-Connectors' with:'Gaucho-Morphic-Connectors-carlaGriggio.25'; 
			package: 'Gaucho-Morphic-Core' with:'Gaucho-Morphic-Core-carlaGriggio.214';
			package: 'Gaucho-Morphic-InteractionPolicies' with: 'Gaucho-Morphic-InteractionPolicies-carlaGriggio.174';
			package: 'UMLDiagramDrawing' with: 'UMLDiagramDrawing-carlaGriggio.13';
			package: 'UMLDiagramDescriptionTests' with: 'UMLDiagramDescriptionTests-carlaGriggio.3';
			package: 'UMLDiagramsTools' with: 'UMLDiagramsTools-carlaGriggio.6'].
]

{ #category : #versions }
ConfigurationOfSmallUML >> version061: spec [ 
	<version: '0.6.1' imports: #('0.2-baseline') >
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec 
			package: 'UMLClassDiagramModel' with:'UMLClassDiagramModel-carlaGriggio.10';
			package: 'UMLSequenceDiagramModel' with: 'UMLSequenceDiagramModel-carlaGriggio.3';
			package: 'MinimalConnectors-CurvesAndArrows' with:'MinimalConnectors-CurvesAndArrows-carlaGriggio.5';
			package: 'Gaucho-Morphic-Connectors' with:'Gaucho-Morphic-Connectors-carlaGriggio.25'; 
			package: 'Gaucho-Morphic-Core' with:'Gaucho-Morphic-Core-carlaGriggio.214';
			package: 'Gaucho-Morphic-InteractionPolicies' with: 'Gaucho-Morphic-InteractionPolicies-carlaGriggio.174';
			package: 'UMLDiagramDrawing' with: 'UMLDiagramDrawing-carlaGriggio.16';
			package: 'UMLDiagramDescriptionTests' with: 'UMLDiagramDescriptionTests-carlaGriggio.3';
			package: 'UMLDiagramsTools' with: 'UMLDiagramsTools-carlaGriggio.8'].
]

{ #category : #versions }
ConfigurationOfSmallUML >> version06: spec [ 
	<version: '0.6' imports: #('0.2-baseline') >
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec 
			package: 'UMLClassDiagramModel' with:'UMLClassDiagramModel-carlaGriggio.9';
			package: 'UMLSequenceDiagramModel' with: 'UMLSequenceDiagramModel-carlaGriggio.3';
			package: 'MinimalConnectors-CurvesAndArrows' with:'MinimalConnectors-CurvesAndArrows-carlaGriggio.5';
			package: 'Gaucho-Morphic-Connectors' with:'Gaucho-Morphic-Connectors-carlaGriggio.25'; 
			package: 'Gaucho-Morphic-Core' with:'Gaucho-Morphic-Core-carlaGriggio.214';
			package: 'Gaucho-Morphic-InteractionPolicies' with: 'Gaucho-Morphic-InteractionPolicies-carlaGriggio.174';
			package: 'UMLDiagramDrawing' with: 'UMLDiagramDrawing-carlaGriggio.14';
			package: 'UMLDiagramDescriptionTests' with: 'UMLDiagramDescriptionTests-carlaGriggio.3';
			package: 'UMLDiagramsTools' with: 'UMLDiagramsTools-carlaGriggio.7'].
]

{ #category : #versions }
ConfigurationOfSmallUML >> version07: spec [ 
	<version: '0.7' imports: #('0.2-baseline') >
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec 
			package: 'UMLClassDiagramModel' with:'UMLClassDiagramModel-carlaGriggio.13';
			package: 'UMLSequenceDiagramModel' with: 'UMLSequenceDiagramModel-carlaGriggio.3';
			package: 'MinimalConnectors-CurvesAndArrows' with:'MinimalConnectors-CurvesAndArrows-carlaGriggio.5';
			package: 'Gaucho-Morphic-Connectors' with:'Gaucho-Morphic-Connectors-carlaGriggio.25'; 
			package: 'Gaucho-Morphic-Core' with:'Gaucho-Morphic-Core-carlaGriggio.214';
			package: 'Gaucho-Morphic-InteractionPolicies' with: 'Gaucho-Morphic-InteractionPolicies-carlaGriggio.174';
			package: 'UMLDiagramDrawing' with: 'UMLDiagramDrawing-carlaGriggio.23';
			package: 'UMLDiagramDescriptionTests' with: 'UMLDiagramDescriptionTests-carlaGriggio.3';
			package: 'UMLDiagramsTools' with: 'UMLDiagramsTools-carlaGriggio.16'].
]

{ #category : #versions }
ConfigurationOfSmallUML >> version08: spec [ 
	<version: '0.8' imports: #('0.3-baseline') >
	
	spec for: #common do: [
		spec blessing: #release.
		spec author: 'Carla Griggio'.
		spec
			project: 'MinimalConnectors' with: '0.1'.
	]
"spec 
			package: 'UMLClassDiagramModel' with:'UMLClassDiagramModel-carlaGriggio.13';
			package: 'UMLSequenceDiagramModel' with: 'UMLSequenceDiagramModel-carlaGriggio.3';
			package: 'MinimalConnectors-CurvesAndArrows' with:'MinimalConnectors-CurvesAndArrows-carlaGriggio.5';
			package: 'Gaucho-Morphic-Connectors' with:'Gaucho-Morphic-Connectors-carlaGriggio.25'; 
			package: 'Gaucho-Morphic-Core' with:'Gaucho-Morphic-Core-carlaGriggio.214';
			package: 'Gaucho-Morphic-InteractionPolicies' with: 'Gaucho-Morphic-InteractionPolicies-carlaGriggio.174';
			package: 'UMLDiagramDrawing' with: 'UMLDiagramDrawing-carlaGriggio.23';
			package: 'UMLDiagramDescriptionTests' with: 'UMLDiagramDescriptionTests-carlaGriggio.3';
			package: 'UMLDiagramsTools' with: 'UMLDiagramsTools-carlaGriggio.16']."
]

{ #category : #versions }
ConfigurationOfSmallUML >> version09: spec [ 
	<version: '0.9' imports: #('0.4-baseline') >
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec author: 'Carla Griggio'.
		spec
			project: 'MinimalConnectors' with: '0.2'.
	]
"spec 
			package: 'UMLClassDiagramModel' with:'UMLClassDiagramModel-carlaGriggio.13';
			package: 'UMLSequenceDiagramModel' with: 'UMLSequenceDiagramModel-carlaGriggio.3';
			package: 'MinimalConnectors-CurvesAndArrows' with:'MinimalConnectors-CurvesAndArrows-carlaGriggio.5';
			package: 'Gaucho-Morphic-Connectors' with:'Gaucho-Morphic-Connectors-carlaGriggio.25'; 
			package: 'Gaucho-Morphic-Core' with:'Gaucho-Morphic-Core-carlaGriggio.214';
			package: 'Gaucho-Morphic-InteractionPolicies' with: 'Gaucho-Morphic-InteractionPolicies-carlaGriggio.174';
			package: 'UMLDiagramDrawing' with: 'UMLDiagramDrawing-carlaGriggio.23';
			package: 'UMLDiagramDescriptionTests' with: 'UMLDiagramDescriptionTests-carlaGriggio.3';
			package: 'UMLDiagramsTools' with: 'UMLDiagramsTools-carlaGriggio.16']."
]

{ #category : #versions }
ConfigurationOfSmallUML >> version111: spec [ 
	<version: '1.1.1' imports: #('0.6-baseline') >
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec author: 'Carla Griggio'.
		spec
			project: 'MinimalConnectors' with: '0.6'.
	
spec 
			package: 'SUML-ClassDiagramModel' with:'SUML-ClassDiagramModel-carlaGriggio.17';
			package: 'SUML-DiagramDrawing' with: 'SUML-DiagramDrawing-carlaGriggio.24';
			package: 'SUML-ObjectDiagramModel' with:'SUML-ObjectDiagramModel-carlaGriggio.17';
			package: 'SUML-SequenceDiagramModel' with:'SUML-SequenceDiagramModel-carlaGriggio.1'; 
			package: 'SUML-Tools' with:'SUML-Tools-carlaGriggio.27'].
]

{ #category : #versions }
ConfigurationOfSmallUML >> version112: spec [ 
	<version: '1.1.2' imports: #('0.6-baseline') >
	
	spec for: #common do: [
		spec blessing: #release.
		spec author: 'Carla Griggio'.
		spec
			project: 'MinimalConnectors' with: '0.6'.
	
spec 
			package: 'SUML-ClassDiagramModel' with:'SUML-ClassDiagramModel-carlaGriggio.17';
			package: 'SUML-DiagramDrawing' with: 'SUML-DiagramDrawing-carlaGriggio.28';
			package: 'SUML-ObjectDiagramModel' with:'SUML-ObjectDiagramModel-carlaGriggio.17';
			package: 'SUML-SequenceDiagramModel' with:'SUML-SequenceDiagramModel-carlaGriggio.1'; 
			package: 'SUML-Tools' with:'SUML-Tools-carlaGriggio.33'].
]

{ #category : #versions }
ConfigurationOfSmallUML >> version113: spec [ 
	<version: '1.1.3' imports: #('0.6-baseline') >
	
	spec for: #common do: [
		spec blessing: #release.
		spec author: 'Carla Griggio'.
		spec
			project: 'MinimalConnectors' with: '0.6'.
	
spec 
			package: 'SUML-ClassDiagramModel' with:'SUML-ClassDiagramModel-carlaGriggio.20';
			package: 'SUML-DiagramDrawing' with: 'SUML-DiagramDrawing-carlaGriggio.28';
			package: 'SUML-ObjectDiagramModel' with:'SUML-ObjectDiagramModel-carlaGriggio.17';
			package: 'SUML-SequenceDiagramModel' with:'SUML-SequenceDiagramModel-carlaGriggio.1'; 
			package: 'SUML-Tools' with:'SUML-Tools-carlaGriggio.36'].
]

{ #category : #versions }
ConfigurationOfSmallUML >> version114: spec [ 
	<version: '1.1.4' imports: #('0.6-baseline') >
	
	spec for: #common do: [
		spec blessing: #release.
		spec author: 'Carla Griggio'.
		spec
			project: 'MinimalConnectors' with: '0.7'.
	
spec 
			package: 'SUML-ClassDiagramModel' with:'SUML-ClassDiagramModel-carlaGriggio.22';
			package: 'SUML-DiagramDrawing' with: 'SUML-DiagramDrawing-carlaGriggio.33';
			package: 'SUML-ObjectDiagramModel' with:'SUML-ObjectDiagramModel-carlaGriggio.17';
			package: 'SUML-SequenceDiagramModel' with:'SUML-SequenceDiagramModel-carlaGriggio.1'; 
			package: 'SUML-Tools' with:'SUML-Tools-carlaGriggio.39'].
]

{ #category : #versions }
ConfigurationOfSmallUML >> version115: spec [ 
	<version: '1.1.5' imports: #('0.6-baseline') >
	
	spec for: #common do: [
		spec blessing: #development.
		spec author: 'Carla Griggio'.
		spec
			project: 'MinimalConnectors' with: '0.7'.
	
spec 
			package: 'SUML-ClassDiagramModel' with:'SUML-ClassDiagramModel-carlaGriggio.23';
			package: 'SUML-DiagramDrawing' with: 'SUML-DiagramDrawing-carlaGriggio.33';
			package: 'SUML-ObjectDiagramModel' with:'SUML-ObjectDiagramModel-carlaGriggio.17';
			package: 'SUML-SequenceDiagramModel' with:'SUML-SequenceDiagramModel-carlaGriggio.1'; 
			package: 'SUML-Tools' with:'SUML-Tools-carlaGriggio.39'].
]

{ #category : #versions }
ConfigurationOfSmallUML >> version116: spec [ 
	<version: '1.1.6' imports: #('0.7-baseline') >
	
	spec for: #common do: [
		spec blessing: #development.
		spec author: 'Carla Griggio'.
		spec
			project: 'MinimalConnectors' with: '0.8'.
	
spec 
			package: 'SUML-ClassDiagramModel' with:'SUML-ClassDiagramModel-carlaGriggio.30';
			package: 'SUML-DiagramDrawing' with: 'SUML-DiagramDrawing-carlaGriggio.33';
			package: 'SUML-ObjectDiagramModel' with:'SUML-ObjectDiagramModel-carlaGriggio.17';
			package: 'SUML-SequenceDiagramModel' with:'SUML-SequenceDiagramModel-carlaGriggio.1'; 
			package: 'SUML-Tools' with:'SUML-Tools-carlaGriggio.42';
			package: 'SUML-ModelExample' with:'SUML-ModelExample-carlaGriggio.1'.]
			
]

{ #category : #versions }
ConfigurationOfSmallUML >> version117: spec [ 
	<version: '1.1.7' imports: #('0.7-baseline') >
	
	spec for: #common do: [
		spec blessing: #development.
		spec author: 'Carla Griggio'.
		spec
			project: 'MinimalConnectors' with: '0.8'.
	
spec 
			package: 'SUML-ClassDiagramModel' with:'SUML-ClassDiagramModel-carlaGriggio.32';
			package: 'SUML-DiagramDrawing' with: 'SUML-DiagramDrawing-carlaGriggio.34';
			package: 'SUML-ObjectDiagramModel' with:'SUML-ObjectDiagramModel-carlaGriggio.17';
			package: 'SUML-SequenceDiagramModel' with:'SUML-SequenceDiagramModel-carlaGriggio.1'; 
			package: 'SUML-Tools' with:'SUML-Tools-carlaGriggio.45';
			package: 'SUML-ModelExample' with:'SUML-ModelExample-carlaGriggio.2'.]
			
]

{ #category : #versions }
ConfigurationOfSmallUML >> version11: spec [ 
	<version: '1.1' imports: #('0.6-baseline') >
	
	spec for: #common do: [
		spec blessing: #release.
		spec author: 'Carla Griggio'.
		spec
			project: 'MinimalConnectors' with: '0.6'.
	
spec 
			package: 'SUML-ClassDiagramModel' with:'SUML-ClassDiagramModel-carlaGriggio.17';
			package: 'SUML-DiagramDrawing' with: 'SUML-DiagramDrawing-carlaGriggio.23';
			package: 'SUML-ObjectDiagramModel' with:'SUML-ObjectDiagramModel-carlaGriggio.17';
			package: 'SUML-SequenceDiagramModel' with:'SUML-SequenceDiagramModel-carlaGriggio.1'; 
			package: 'SUML-Tools' with:'SUML-Tools-carlaGriggio.26'].
]

{ #category : #versions }
ConfigurationOfSmallUML >> version1: spec [ 
	<version: '1.0' imports: #('0.5-baseline') >
	
	spec for: #common do: [
		spec blessing: #release.
		spec author: 'Carla Griggio'.
		spec
			project: 'MinimalConnectors' with: '0.5'.
	]
"spec 
			package: 'UMLClassDiagramModel' with:'UMLClassDiagramModel-carlaGriggio.13';
			package: 'UMLSequenceDiagramModel' with: 'UMLSequenceDiagramModel-carlaGriggio.3';
			package: 'MinimalConnectors-CurvesAndArrows' with:'MinimalConnectors-CurvesAndArrows-carlaGriggio.5';
			package: 'Gaucho-Morphic-Connectors' with:'Gaucho-Morphic-Connectors-carlaGriggio.25'; 
			package: 'Gaucho-Morphic-Core' with:'Gaucho-Morphic-Core-carlaGriggio.214';
			package: 'Gaucho-Morphic-InteractionPolicies' with: 'Gaucho-Morphic-InteractionPolicies-carlaGriggio.174';
			package: 'UMLDiagramDrawing' with: 'UMLDiagramDrawing-carlaGriggio.23';
			package: 'UMLDiagramDescriptionTests' with: 'UMLDiagramDescriptionTests-carlaGriggio.3';
			package: 'UMLDiagramsTools' with: 'UMLDiagramsTools-carlaGriggio.16']."
]
