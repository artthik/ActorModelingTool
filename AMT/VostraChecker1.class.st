Class {
	#name : #VostraChecker1,
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
VostraChecker1 >> actorCard [
	^ actorCard
]

{ #category : #accessing }
VostraChecker1 >> actorCard: anObject [
	actorCard := anObject
]

{ #category : #accessing }
VostraChecker1 >> addToMailbox: message [
	mailbox add: message.
	self actorCard changeColor.
]

{ #category : #initialization }
VostraChecker1 >> createAndSend [
	^ self
]

{ #category : #messaging }
VostraChecker1 >> createAndSendMessageTo: recipient with: data and: type [
	| message |
	message := AMTMessageBlueprint new.
	message sender: self.
	message recipient: recipient.
	message data: data.
	message type: type.
	recipient addToMailbox: message.
]

{ #category : #'as yet unclassified' }
VostraChecker1 >> gtMethodsFor: aView [
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
						self actorCard changeColorBack.
						^self. ].
			(message data at: 3) asNumber > 25
				ifTrue: [ message data at: 7 put: 'indefinitely'.
					self
						createAndSendMessageTo: vostraEnd
						with: message data
						and: 'End'.
						self actorCard changeColorBack.
						^self. ].
			((message data at: 2) ~= '2'
				or: [ (message data at: 3) asNumber <= 25 ])
				ifTrue: [ self
						createAndSendMessageTo: vostraChecker2
						with: message data
						and: 'Check2' ] ].
	self actorCard changeColorBack
]

{ #category : #initialization }
VostraChecker1 >> setUp [
	^ self
]

{ #category : #accessing }
VostraChecker1 >> state [
	^ state
]
