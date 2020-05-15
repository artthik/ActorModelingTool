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
]

{ #category : #initialization }
AMTModel >> initialize [
	actors := OrderedCollection new
]
