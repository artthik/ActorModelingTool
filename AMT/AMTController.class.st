"
I am the AMT Controller.
"
Class {
	#name : #AMTController,
	#superclass : #Object,
	#instVars : [
		'model',
		'view'
	],
	#category : #'AMT-Controller'
}

{ #category : #adding }
AMTController >> addActor [
	| name actor uuid |
	uuid := UUIDGenerator new nextRandom16 asRopedText.
	name := 'Actor_' , uuid.
	AMTActorBlueprint duplicateClassWithNewName: name.
	actor := name asClass new.
	"TODO: move the actor class to package tag 'Solution'"
	model addActor: actor.
	view addActorElement: actor
]

{ #category : #initialization }
AMTController >> initialize [
	<gtExample>
	super initialize.
	model := AMTModel new.
	view := AMTView new.
	view controller: self.
	view addActor.
	^ view
]
