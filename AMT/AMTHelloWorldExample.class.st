"
I am an example
"
Class {
	#name : #AMTHelloWorldExample,
	#superclass : #Object,
	#category : #'AMT-Examples'
}

{ #category : #example }
AMTHelloWorldExample >> sendHelloWorldBetweenTwoActors [
	<gtExample>
	| a b c |
	a := AMTActorBlueprint new.
	b := AMTActorBlueprint new.
	a createAndSendMessageTo: b with: 'Hello World.' and: 'Test'.
	c := b processsMessage.
	self inform: c
]
