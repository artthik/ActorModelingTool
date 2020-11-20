Class {
	#name : #VostraChecker3,
	#superclass : #AMTAbstractActor,
	#category : #'AMT-Model'
}

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
