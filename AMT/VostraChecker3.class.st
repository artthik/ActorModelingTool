Class {
	#name : #VostraChecker3,
	#superclass : #Object,
	#instVars : [
		'mailbox',
		'address',
		'state',
		'knownActors',
		'actorCard'
	],
	#category : #'AMT-Model'
}

{ #category : #accessing }
VostraChecker3 >> actorCard [
	^ actorCard
]

{ #category : #accessing }
VostraChecker3 >> actorCard: anObject [
	actorCard := anObject
]

{ #category : #accessing }
VostraChecker3 >> addToMailbox: message [
	mailbox add: message.
	self actorCard changeColor.
]

{ #category : #initialization }
VostraChecker3 >> createAndSend [
	^ self
]

{ #category : #messaging }
VostraChecker3 >> createAndSendMessageTo: recipient with: data and: type [
	| message |
	message := AMTMessageBlueprint new.
	message sender: self.
	message recipient: recipient.
	message data: data.
	message type: type.
	recipient addToMailbox: message.
]

{ #category : #'as yet unclassified' }
VostraChecker3 >> gtMethodsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Methods' translated;
		priority: 50;
		stencil: [ BrSimpleList new
				padding: (BlInsets all: 5);
				hMatchParent;
				vMatchParent;
				items: self class methods;
				stencil: [ :m | 
					(AMTMethodCoder forMethod: m)
						object: self;
						yourself ];
				yourself ]
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
					self actorCard changeColorBack.
					^ self ].
			((message data at: 5) ~= 'deportation'
				or: [ (message data at: 6) ~= 'yes' ])
				ifTrue: [ message data at: 7 put: (message data at: 3).
					self
						createAndSendMessageTo: vostraEnd
						with: message data
						and: 'End' ] ].
	self actorCard changeColorBack
]

{ #category : #initialization }
VostraChecker3 >> setUp [
	^ self
]

{ #category : #accessing }
VostraChecker3 >> state [
	^ state
]
