Class {
	#name : #VostraEnd,
	#superclass : #AMTAbstractActor,
	#category : #'AMT-Model'
}

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
