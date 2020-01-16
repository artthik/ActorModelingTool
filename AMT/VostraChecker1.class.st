Class {
	#name : #VostraChecker1,
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
VostraChecker1 >> actorElement [
	^ actorElement
]

{ #category : #accessing }
VostraChecker1 >> actorElement: anObject [
	actorElement := anObject
]

{ #category : #accessing }
VostraChecker1 >> addToMailbox: message [
	mailbox add: message.
	self actorElement changeHeaderColor
]

{ #category : #initialization }
VostraChecker1 >> createAndSend [
	<AMTSend>
	^ self
]

{ #category : #messaging }
VostraChecker1 >> createAndSendMessageTo: recipient with: data and: type [
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
VostraChecker1 >> hasActor: anActor [
	| occurrences |
	occurrences := knownActors occurrencesOf: anActor.
	occurrences > 0
		ifTrue: [ ^ true ]
		ifFalse: [ ^ false ]
]

{ #category : #messaging }
VostraChecker1 >> initialize [
	mailbox := OrderedCollection new.
	address := UUIDGenerator new nextRandom16.
	state := 0.
	knownActors := OrderedCollection new.
]

{ #category : #accessing }
VostraChecker1 >> knownActors [
	^ knownActors
]

{ #category : #accessing }
VostraChecker1 >> knownActors: anObject [
	knownActors := anObject
]

{ #category : #messaging }
VostraChecker1 >> processsMessage [
	| message |
	message := mailbox at: 1.
	message type = 'Test'
		ifTrue: [ ^ message data ]
]

{ #category : #initialization }
VostraChecker1 >> receive [
			<AMTReceive>
	| message vostraChecker2 vostraEnd |
	knownActors
		do: [ :actor | 
			actor class = VostraChecker2
				ifTrue: [ vostraChecker2 := actor ] ].
	knownActors
		do: [ :actor | 
			actor class = VostraEnd
				ifTrue: [ vostraEnd := actor ] ].
	message := mailbox at: 1.
	mailbox remove: message.
	message type = 'Check1'
		ifTrue: [ (message data at: 2) = '2'
				ifTrue: [ message data at: 7 put: 'indefinitely'.
					self
						createAndSendMessageTo: vostraEnd
						with: message data
						and: 'End'.
						self actorElement changeHeaderColorBack.
						^self. ].
			(message data at: 3) asNumber > 25
				ifTrue: [ message data at: 7 put: 'indefinitely'.
					self
						createAndSendMessageTo: vostraEnd
						with: message data
						and: 'End'.
						self actorElement changeHeaderColorBack.
						^self. ].
			((message data at: 2) ~= '2'
				or: [ (message data at: 3) asNumber <= 25 ])
				ifTrue: [ self
						createAndSendMessageTo: vostraChecker2
						with: message data
						and: 'Check2' ] ].
	self actorElement changeHeaderColorBack.
]

{ #category : #initialization }
VostraChecker1 >> setUp [
	<AMTSetup>
	^ self
]

{ #category : #accessing }
VostraChecker1 >> state [
	^ state
]
