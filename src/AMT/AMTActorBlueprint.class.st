"
What is the Actor supposed to do?
"
Class {
	#name : #AMTActorBlueprint,
	#superclass : #AMTAbstractActor,
	#category : #'AMT-Model'
}

{ #category : #initialization }
AMTActorBlueprint >> createAndSend [
	<AMTSend>
	^ self
]

{ #category : #messaging }
AMTActorBlueprint >> createAndSendMessageTo: recipient with: data and: type [
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
AMTActorBlueprint >> receive [
	<AMTReceive>
	self actorElement changeHeaderColorBack.
	^ self
]

{ #category : #initialization }
AMTActorBlueprint >> setUp [
	<AMTSetup>
	^ self
]
