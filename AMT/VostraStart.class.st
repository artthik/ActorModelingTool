Class {
	#name : #VostraStart,
	#superclass : #AMTAbstractActor,
	#category : #'AMT-Model'
}

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
