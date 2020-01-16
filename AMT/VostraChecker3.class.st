Class {
	#name : #VostraChecker3,
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
VostraChecker3 >> actorElement [
	^ actorElement
]

{ #category : #accessing }
VostraChecker3 >> actorElement: anObject [
	actorElement := anObject
]

{ #category : #accessing }
VostraChecker3 >> addToMailbox: message [
	mailbox add: message.
	self actorElement changeHeaderColor
]

{ #category : #initialization }
VostraChecker3 >> createAndSend [
	<AMTSend>
	^ self
]

{ #category : #messaging }
VostraChecker3 >> createAndSendMessageTo: recipient with: data and: type [
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
VostraChecker3 >> hasActor: anActor [
	| occurrences |
	occurrences := knownActors occurrencesOf: anActor.
	occurrences > 0
		ifTrue: [ ^ true ]
		ifFalse: [ ^ false ]
]

{ #category : #messaging }
VostraChecker3 >> initialize [
	mailbox := OrderedCollection new.
	address := UUIDGenerator new nextRandom16.
	state := 0.
	knownActors := OrderedCollection new.
]

{ #category : #accessing }
VostraChecker3 >> knownActors [
	^ knownActors
]

{ #category : #accessing }
VostraChecker3 >> knownActors: anObject [
	knownActors := anObject
]

{ #category : #messaging }
VostraChecker3 >> processsMessage [
	| message |
	message := mailbox at: 1.
	message type = 'Test'
		ifTrue: [ ^ message data ]
]

{ #category : #initialization }
VostraChecker3 >> receive [
			<AMTReceive>
	| message vostraEnd |
	knownActors
		do: [ :actor | 
			actor class = VostraEnd
				ifTrue: [ vostraEnd := actor ] ].
	message := mailbox at: 1.
	mailbox remove: message.
	message type = 'Check3'
		ifTrue: [ (message data at: 5) = 'deportation'
				ifTrue: [ message data at: 7 put: (message data at: 3) ].
			(message data at: 6) = 'yes'
				ifTrue: [ message data at: 7 put: 0.
					self
						createAndSendMessageTo: vostraEnd
						with: message data
						and: 'End'.
					self actorElement changeHeaderColorBack.
					^ self ].
			((message data at: 5) ~= 'deportation'
				or: [ (message data at: 6) ~= 'yes' ])
				ifTrue: [ message data at: 7 put: (message data at: 3).
					self
						createAndSendMessageTo: vostraEnd
						with: message data
						and: 'End' ] ].
	self actorElement changeHeaderColorBack.
]

{ #category : #initialization }
VostraChecker3 >> setUp [
	<AMTSetup>
	^ self
]

{ #category : #accessing }
VostraChecker3 >> state [
	^ state
]
