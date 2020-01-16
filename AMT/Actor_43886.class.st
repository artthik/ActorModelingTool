Class {
	#name : #'Actor_43886',
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
Actor_43886 >> actorElement [
	^ actorElement
]

{ #category : #accessing }
Actor_43886 >> actorElement: anObject [
	actorElement := anObject
]

{ #category : #accessing }
Actor_43886 >> addToMailbox: message [
	mailbox add: message.
	self actorElement changeHeaderColor
]

{ #category : #initialization }
Actor_43886 >> createAndSend [
	<AMTSend>
	^ self
]

{ #category : #messaging }
Actor_43886 >> createAndSendMessageTo: recipient with: data and: type [
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
Actor_43886 >> hasActor: anActor [
	| occurrences |
	occurrences := knownActors occurrencesOf: anActor.
	occurrences > 0
		ifTrue: [ ^ true ]
		ifFalse: [ ^ false ]
]

{ #category : #messaging }
Actor_43886 >> initialize [
	mailbox := OrderedCollection new.
	address := UUIDGenerator new nextRandom16.
	state := 0.
	knownActors := OrderedCollection new.
]

{ #category : #accessing }
Actor_43886 >> knownActors [
	^ knownActors
]

{ #category : #accessing }
Actor_43886 >> knownActors: anObject [
	knownActors := anObject
]

{ #category : #messaging }
Actor_43886 >> processsMessage [
	| message |
	message := mailbox at: 1.
	message type = 'Test'
		ifTrue: [ ^ message data ]
]

{ #category : #initialization }
Actor_43886 >> receive [
	<AMTReceive>
	self actorElement changeHeaderColorBack.
	^ self
]

{ #category : #initialization }
Actor_43886 >> setUp [
	<AMTSetup>
	^ self
]

{ #category : #accessing }
Actor_43886 >> state [
	^ state
]
