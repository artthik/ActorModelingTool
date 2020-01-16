Class {
	#name : #VostraChecker2,
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
VostraChecker2 >> actorElement [
	^ actorElement
]

{ #category : #accessing }
VostraChecker2 >> actorElement: anObject [
	actorElement := anObject
]

{ #category : #accessing }
VostraChecker2 >> addToMailbox: message [
	mailbox add: message.
	self actorElement changeHeaderColor
]

{ #category : #initialization }
VostraChecker2 >> createAndSend [
	<AMTSend>
	^ self
]

{ #category : #messaging }
VostraChecker2 >> createAndSendMessageTo: recipient with: data and: type [
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
VostraChecker2 >> hasActor: anActor [
	| occurrences |
	occurrences := knownActors occurrencesOf: anActor.
	occurrences > 0
		ifTrue: [ ^ true ]
		ifFalse: [ ^ false ]
]

{ #category : #messaging }
VostraChecker2 >> initialize [
	mailbox := OrderedCollection new.
	address := UUIDGenerator new nextRandom16.
	state := 0.
	knownActors := OrderedCollection new.
]

{ #category : #accessing }
VostraChecker2 >> knownActors [
	^ knownActors
]

{ #category : #accessing }
VostraChecker2 >> knownActors: anObject [
	knownActors := anObject
]

{ #category : #messaging }
VostraChecker2 >> processsMessage [
	| message |
	message := mailbox at: 1.
	message type = 'Test'
		ifTrue: [ ^ message data ]
]

{ #category : #initialization }
VostraChecker2 >> receive [
			<AMTReceive>
	| message vostraChecker3 vostraEnd |
	knownActors
		do: [ :actor | 
			actor class = VostraChecker3
				ifTrue: [ vostraChecker3 := actor ] ].
	knownActors
		do: [ :actor | 
			actor class = VostraEnd
				ifTrue: [ vostraEnd := actor ] ].
	message := mailbox at: 1.
	mailbox remove: message.
	message type = 'Check2'
		ifTrue: [ (message data at: 4) = 'yes'
				ifTrue: [ message data at: 7 put: 'indefinitely'.
					self
						createAndSendMessageTo: vostraEnd
						with: message data
						and: 'End'.
					self actorElement changeHeaderColorBack.
					^ self ].
			(message data at: 5) = 'life sentance'
				ifTrue: [ message data at: 7 put: 'indefinitely'.
					self
						createAndSendMessageTo: vostraChecker3
						with: message data
						and: 'End'.
					self actorElement changeHeaderColorBack.
					^ self ].
			((message data at: 4) ~= 'yes'
				or: [ (message data at: 5) ~= 'life sentance' ])
				ifTrue: [ self
						createAndSendMessageTo: vostraChecker3
						with: message data
						and: 'Check3' ] ].
self actorElement changeHeaderColorBack.
]

{ #category : #initialization }
VostraChecker2 >> setUp [
	<AMTSetup>
	^ self
]

{ #category : #accessing }
VostraChecker2 >> state [
	^ state
]
