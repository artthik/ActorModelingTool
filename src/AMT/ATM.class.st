"
I am the ATM, doing all the ATM stuff
"
Class {
	#name : #ATM,
	#superclass : #AMTAbstractActor,
	#category : #'AMT-Model'
}

{ #category : #initialization }
ATM >> createAndSend [ <AMTSend> 
				| bank | 
				state := state - 200. 
				knownActors do: [ :actor | actor class = Bank 
					ifTrue: [ bank := actor ] ]. 
				self createAndSendMessageTo: bank with: '200' and: 'Withdrawal'
]

{ #category : #messaging }
ATM >> createAndSendMessageTo: recipient with: data and: type [
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
ATM >> receive [
	<AMTReceive>
	self actorElement changeHeaderColorBack.
	^ self
]

{ #category : #initialization }
ATM >> setUp [ state := 500.
]
