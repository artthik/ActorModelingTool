"
I am the Bank, doing Bank stuff
"
Class {
	#name : #Bank,
	#superclass : #AMTAbstractActor,
	#category : #'AMT-Model'
}

{ #category : #initialization }
Bank >> createAndSend [
	<AMTSend>
	^ self
]

{ #category : #messaging }
Bank >> createAndSendMessageTo: recipient with: data and: type [
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
Bank >> receive [
	<AMTReceive>
	self actorElement changeHeaderColorBack.
	^ self
]

{ #category : #'as yet unclassified' }
Bank >> receiveWithdrawal [ <AMTReceive>
			|message|
			message := mailbox at: 1.
				 self when: (message type = 'Withdrawal' )
					  do: [ state := state - message data asNumber]. 
				self receive
]

{ #category : #initialization }
Bank >> setUp [ state := 5000.
]
