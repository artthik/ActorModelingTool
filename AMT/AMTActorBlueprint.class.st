"
What is the Actor supposed to do?
"
Class {
	#name : #AMTActorBlueprint,
	#superclass : #Object,
	#instVars : [
		'mailbox',
		'address',
		'state',
		'knownActors',
		'actorElement'
	],
	#category : #'AMT-Model'
}

{ #category : #accessing }
AMTActorBlueprint >> actorElement [
	^ actorElement
]

{ #category : #accessing }
AMTActorBlueprint >> actorElement: anObject [
	actorElement := anObject
]

{ #category : #accessing }
AMTActorBlueprint >> addToMailbox: message [
	mailbox add: message.
	self actorElement changeHeaderColor
]

{ #category : #initialization }
AMTActorBlueprint >> createAndSend [
	<AMTSend>
	^ self
]

{ #category : #messaging }
AMTActorBlueprint >> createAndSendMessageTo: recipient with: data and: type [
	<AMTSend>
	| message |
	message := AMTMessageBlueprint new.
	message sender: self.
	message recipient: recipient.
	message data: data.
	message type: type.
	recipient addToMailbox: message
]

{ #category : #accessing }
AMTActorBlueprint >> hasActor: anActor [
	| occurrences |
	occurrences := knownActors occurrencesOf: anActor.
	occurrences > 0
		ifTrue: [ ^ true ]
		ifFalse: [ ^ false ]
]

{ #category : #messaging }
AMTActorBlueprint >> initialize [
	mailbox := OrderedCollection new.
	address := UUIDGenerator new nextRandom16.
	state := 0.
	knownActors := OrderedCollection new.
]

{ #category : #accessing }
AMTActorBlueprint >> knownActors [
	^ knownActors
]

{ #category : #accessing }
AMTActorBlueprint >> knownActors: anObject [
	knownActors := anObject
]

{ #category : #initialization }
AMTActorBlueprint >> receive [
	<AMTReceive>
	self actorElement changeHeaderColorBack.
	^ self
]

{ #category : #initialization }
AMTActorBlueprint >> setUp [
	<AMTSetup>
	^ self
]

{ #category : #accessing }
AMTActorBlueprint >> state [
	^ state
]

{ #category : #initialization }
AMTActorBlueprint >> when: condition and: conditions2 do: statement [
	condition & conditions2 
		ifTrue: [ ^ statement value ]
]

{ #category : #initialization }
AMTActorBlueprint >> when: condition do: statement [
	condition
		ifTrue: [ ^ statement value ]
]
