Class {
	#name : #BaselineOfAMT,
	#superclass : #BaselineOf,
	#category : #BaselineOfAMT
}

{ #category : #baselines }
BaselineOfAMT >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: #'AMT';
				package: #'AMT-Examples' ]
]
