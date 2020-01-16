Class {
	#name : #ATM,
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
ATM >> actorElement [
	^ actorElement
]

{ #category : #accessing }
ATM >> actorElement: anObject [
	actorElement := anObject
]

{ #category : #accessing }
ATM >> addToMailbox: message [
	mailbox add: message.
	self actorElement changeHeaderColor
]

{ #category : #initialization }
ATM >> createAndSend [ <AMTSend> | bank | state := state - 200. knownActors do: [ :actor | actor class = Bank ifTrue: [ bank := actor ] ]. self createAndSendMessageTo: bank with: '200' and: 'Withdrawal'
]

{ #category : #messaging }
ATM >> createAndSendMessageTo: recipient with: data and: type [
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
ATM >> hasActor: anActor [
	| occurrences |
	occurrences := knownActors occurrencesOf: anActor.
	occurrences > 0
		ifTrue: [ ^ true ]
		ifFalse: [ ^ false ]
]

{ #category : #messaging }
ATM >> initialize [
	mailbox := OrderedCollection new.
	address := UUIDGenerator new nextRandom16.
	state := 0.
	knownActors := OrderedCollection new.
]

{ #category : #accessing }
ATM >> knownActors [
	^ knownActors
]

{ #category : #accessing }
ATM >> knownActors: anObject [
	knownActors := anObject
]

{ #category : #messaging }
ATM >> processsMessage [
	| message |
	message := mailbox at: 1.
	message type = 'Test'
		ifTrue: [ ^ message data ]
]

{ #category : #initialization }
ATM >> receive [
	<AMTReceive>
	self actorElement changeHeaderColorBack.
	^ self
]

{ #category : #initialization }
ATM >> setUp [ state := 500.
]

{ #category : #accessing }
ATM >> state [
	^ state
]
