"
I am the Bank, doing Bank stuff
"
Class {
	#name : #Bank,
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
Bank >> actorElement [
	^ actorElement
]

{ #category : #accessing }
Bank >> actorElement: anObject [
	actorElement := anObject
]

{ #category : #accessing }
Bank >> addHandler: handler [
	messageHandlers add: handler
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

{ #category : #'as yet unclassified' }
Bank >> decreaseBy: number [
	<AMTReceive>
	| message |
	message := mailbox at: 1.
	state := state - number.
]

{ #category : #initialization }
Bank >> executeMessages [
	mailbox copy
		do: [ :m | 
			| matchingHandlers |
			matchingHandlers := messageHandlers
				select: [ :h | h appliesToMessage: m ].
			matchingHandlers do: [ :handler | handler executeForMessage: m ].
			mailbox remove: m ]
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

{ #category : #messaging }
Bank >> initializeHandlers [
	self addHandler: (WithdrawalHandler new actor: self).
]

{ #category : #accessing }
Bank >> knownActors [
	^ knownActors
]

{ #category : #accessing }
Bank >> knownActors: anObject [
	knownActors := anObject
]

{ #category : #initialization }
Bank >> receive [
	<AMTReceive>
	self actorElement changeHeaderColorBack.
	^ self
]

{ #category : #'as yet unclassified' }
Bank >> receiveWithdrawal [
	<AMTReceive>
	| message |
	message := mailbox at: 1.
	self
		when: message type = 'Withdrawal'
		and: 2 = 2
		do: [ state := state - message data asNumber ].
	self receive
]

{ #category : #initialization }
Bank >> setUp [ state := 5000.
]

{ #category : #accessing }
Bank >> state [
	^ state
]

{ #category : #initialization }
Bank >> when: condition and: conditions2 do: statement [
	condition & conditions2 
		ifTrue: [ ^ statement value ]
]

{ #category : #initialization }
Bank >> when: condition do: statement [
	condition
		ifTrue: [ ^ statement value ]
]
