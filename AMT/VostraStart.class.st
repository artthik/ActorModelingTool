Class {
	#name : #VostraStart,
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
VostraStart >> actorElement [
	^ actorElement
]

{ #category : #accessing }
VostraStart >> actorElement: anObject [
	actorElement := anObject
]

{ #category : #accessing }
VostraStart >> addToMailbox: message [
	mailbox add: message.
	self actorElement changeHeaderColor
]

{ #category : #initialization }
VostraStart >> createAndSend [
			<AMTSend>
	| vostraChecker1 data |
	state := state - 200.
	knownActors
		do: [ :actor | 
			actor class = VostraChecker1
				ifTrue: [ vostraChecker1 := actor ] ].
	data := OrderedCollection new.
	data add: 'Sherlock Holmes, 221b Baker street, London, January 6th 1854'.
	data add: '1'.
	data add: '20'.
	data add: 'no'.
	data add: 'prison'.
	data add: 'no'.
	data add: '0'.
	self createAndSendMessageTo: vostraChecker1 with: data and: 'Check1'
]

{ #category : #messaging }
VostraStart >> createAndSendMessageTo: recipient with: data and: type [
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
VostraStart >> hasActor: anActor [
	| occurrences |
	occurrences := knownActors occurrencesOf: anActor.
	occurrences > 0
		ifTrue: [ ^ true ]
		ifFalse: [ ^ false ]
]

{ #category : #messaging }
VostraStart >> initialize [
	mailbox := OrderedCollection new.
	address := UUIDGenerator new nextRandom16.
	state := 0.
	knownActors := OrderedCollection new.
]

{ #category : #accessing }
VostraStart >> knownActors [
	^ knownActors
]

{ #category : #accessing }
VostraStart >> knownActors: anObject [
	knownActors := anObject
]

{ #category : #messaging }
VostraStart >> processsMessage [
	| message |
	message := mailbox at: 1.
	message type = 'Test'
		ifTrue: [ ^ message data ]
]

{ #category : #initialization }
VostraStart >> receive [
	<AMTReceive>
	self actorElement changeHeaderColorBack.
	^ self
]

{ #category : #initialization }
VostraStart >> setUp [
	<AMTSetup>
	^ self
]

{ #category : #accessing }
VostraStart >> state [
	^ state
]
