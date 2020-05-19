Class {
	#name : #AMTAbstractActor,
	#superclass : #Object,
	#instVars : [
		'mailbox',
		'address',
		'state',
		'knownActors',
		'actorElement',
		'messageHandlers'
	],
	#category : #'AMT-Model'
}

{ #category : #accessing }
AMTAbstractActor >> actorElement [
	^ actorElement
]

{ #category : #accessing }
AMTAbstractActor >> actorElement: anObject [
	actorElement := anObject
]

{ #category : #accessing }
AMTAbstractActor >> addToKnownActors: anActor [
	self knownActors add: anActor
]

{ #category : #accessing }
AMTAbstractActor >> addToMailbox: message [
	mailbox add: message.
	self actorElement changeHeaderColor
]

{ #category : #initialization }
AMTAbstractActor >> executeMessages [
	mailbox copy
		do: [ :m | 
			| matchingHandlers |
			matchingHandlers := messageHandlers
				select: [ :h | h appliesToMessage: m ].
			matchingHandlers do: [ :handler | handler executeForMessage: m ].
			mailbox remove: m ]
]

{ #category : #'gt-extensions' }
AMTAbstractActor >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		priority: 0;
		stencil: [ AMTActorElement new actor: self ]
]

{ #category : #accessing }
AMTAbstractActor >> hasActor: anActor [
	| occurrences |
	occurrences := knownActors occurrencesOf: anActor.
	occurrences > 0
		ifTrue: [ ^ true ]
		ifFalse: [ ^ false ]
]

{ #category : #messaging }
AMTAbstractActor >> initialize [
	mailbox := OrderedCollection new.
	address := UUIDGenerator new nextRandom16.
	state := 0.
	knownActors := OrderedCollection new.
]

{ #category : #accessing }
AMTAbstractActor >> knownActors [
	^ knownActors
]

{ #category : #accessing }
AMTAbstractActor >> knownActors: anObject [
	knownActors := anObject.
]

{ #category : #accessing }
AMTAbstractActor >> state [
	^ state
]

{ #category : #initialization }
AMTAbstractActor >> when: condition and: conditions2 do: statement [
	condition & conditions2 
		ifTrue: [ ^ statement value ]
]

{ #category : #initialization }
AMTAbstractActor >> when: condition do: statement [
	condition
		ifTrue: [ ^ statement value ]
]
