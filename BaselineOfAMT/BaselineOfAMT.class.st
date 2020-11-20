"
Adding this class allows the project to be loaded by executing this snippet:

	Metacello new
		baseline: 'AMT';
		repository: 'https://github.com/artthik/ActorModelingTool';
		load
"
Class {
	#name : #BaselineOfAMT,
	#superclass : #Object,
	#category : #BaselineOfAMT
}

{ #category : #baselines }
BaselineOfAMT >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: #AMT;
				package: #'AMT-Examples' ]
]
