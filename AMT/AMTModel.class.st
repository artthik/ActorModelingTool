"
I am the model of the whole AMT App
"
Class {
	#name : #AMTModel,
	#superclass : #Object,
	#instVars : [
		'actors'
	],
	#category : #'AMT-Model'
}

{ #category : #adding }
AMTModel >> addActor: anActor [
	| tmpActors |
	actors add: anActor.
	tmpActors := actors.
	tmpActors do: [ :actor | actor knownActors: actors ].
	actors := tmpActors
]

{ #category : #initialization }
AMTModel >> initialize [
	actors := OrderedCollection new
]
