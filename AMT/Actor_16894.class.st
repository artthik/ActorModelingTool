Class {
	#name : #'Actor_16894',
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
Actor_16894 >> actorElement [
	^ actorElement
]

{ #category : #accessing }
Actor_16894 >> actorElement: anObject [
	actorElement := anObject
]

{ #category : #accessing }
Actor_16894 >> addToMailbox: message [
	mailbox add: message.
	self actorElement changeHeaderColor
]

{ #category : #initialization }
Actor_16894 >> createAndSend [
	<AMTSend>
	^ self
]

{ #category : #messaging }
Actor_16894 >> createAndSendMessageTo: recipient with: data and: type [
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
Actor_16894 >> hasActor: anActor [
	| occurrences |
	occurrences := knownActors occurrencesOf: anActor.
	occurrences > 0
		ifTrue: [ ^ true ]
		ifFalse: [ ^ false ]
]

{ #category : #messaging }
Actor_16894 >> initialize [
	mailbox := OrderedCollection new.
	address := UUIDGenerator new nextRandom16.
	state := 0.
	knownActors := OrderedCollection new.
]

{ #category : #accessing }
Actor_16894 >> knownActors [
	^ knownActors
]

{ #category : #accessing }
Actor_16894 >> knownActors: anObject [
	knownActors := anObject
]

{ #category : #messaging }
Actor_16894 >> processsMessage [
	| message |
	message := mailbox at: 1.
	message type = 'Test'
		ifTrue: [ ^ message data ]
]

{ #category : #initialization }
Actor_16894 >> receive [
	<AMTReceive>
	self actorElement changeHeaderColorBack.
	^ self
]

{ #category : #initialization }
Actor_16894 >> setUp [
	<AMTSetup>
	^ self
]

{ #category : #accessing }
Actor_16894 >> state [
	^ state
]
