Class {
	#name : #VostraEnd,
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
VostraEnd >> actorElement [
	^ actorElement
]

{ #category : #accessing }
VostraEnd >> actorElement: anObject [
	actorElement := anObject
]

{ #category : #accessing }
VostraEnd >> addToMailbox: message [
	mailbox add: message.
	self actorElement changeHeaderColor
]

{ #category : #initialization }
VostraEnd >> createAndSend [
	<AMTSend>
	^ self
]

{ #category : #messaging }
VostraEnd >> createAndSendMessageTo: recipient with: data and: type [
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
VostraEnd >> hasActor: anActor [
	| occurrences |
	occurrences := knownActors occurrencesOf: anActor.
	occurrences > 0
		ifTrue: [ ^ true ]
		ifFalse: [ ^ false ]
]

{ #category : #messaging }
VostraEnd >> initialize [
	mailbox := OrderedCollection new.
	address := UUIDGenerator new nextRandom16.
	state := 0.
	knownActors := OrderedCollection new.
]

{ #category : #accessing }
VostraEnd >> knownActors [
	^ knownActors
]

{ #category : #accessing }
VostraEnd >> knownActors: anObject [
	knownActors := anObject
]

{ #category : #messaging }
VostraEnd >> processsMessage [
	| message |
	message := mailbox at: 1.
	message type = 'Test'
		ifTrue: [ ^ message data ]
]

{ #category : #initialization }
VostraEnd >> receive [
			<AMTReceive>
	| message |
	message := mailbox at: 1.
	mailbox remove: message.
	message type = 'End'
		ifTrue: [ self inform: 'Criminal record of ',(message data at: 1),' needs to be stored for ',(message data at: 7),' years' ].
self actorElement changeHeaderColorBack.
]

{ #category : #initialization }
VostraEnd >> setUp [
	<AMTSetup>
	^ self
]

{ #category : #accessing }
VostraEnd >> state [
	^ state
]
