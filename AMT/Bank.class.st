Class {
	#name : #Bank,
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
Bank >> actorElement [
	^ actorElement
]

{ #category : #accessing }
Bank >> actorElement: anObject [
	actorElement := anObject
]

{ #category : #accessing }
Bank >> addToMailbox: message [
	mailbox add: message.
	self actorElement changeHeaderColor
]

{ #category : #initialization }
Bank >> createAndSend [
	<AMTSend>
	^ self
]

{ #category : #messaging }
Bank >> createAndSendMessageTo: recipient with: data and: type [
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
Bank >> hasActor: anActor [
	| occurrences |
	occurrences := knownActors occurrencesOf: anActor.
	occurrences > 0
		ifTrue: [ ^ true ]
		ifFalse: [ ^ false ]
]

{ #category : #messaging }
Bank >> initialize [
	mailbox := OrderedCollection new.
	address := UUIDGenerator new nextRandom16.
	state := 0.
	knownActors := OrderedCollection new.
]

{ #category : #accessing }
Bank >> knownActors [
	^ knownActors
]

{ #category : #accessing }
Bank >> knownActors: anObject [
	knownActors := anObject
]

{ #category : #messaging }
Bank >> processsMessage [
	| message |
	message := mailbox at: 1.
	message type = 'Test'
		ifTrue: [ ^ message data ]
]

{ #category : #initialization }
Bank >> receive [
	<AMTReceive>
	| message |
	message := mailbox at: 1.
	message type = 'Withdrawal'
		ifTrue: [ state := state - message data asNumber ].
	self actorElement changeHeaderColorBack
]

{ #category : #initialization }
Bank >> setUp [ state := 5000.
]

{ #category : #accessing }
Bank >> state [
	^ state
]
