Class {
	#name : #VostraStart,
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
VostraStart >> actorCard [
	^ actorCard
]

{ #category : #accessing }
VostraStart >> actorCard: anObject [
	actorCard := anObject
]

{ #category : #accessing }
VostraStart >> addToMailbox: message [
	mailbox add: message.
	self actorCard changeColor.
]

{ #category : #initialization }
VostraStart >> createAndSend [
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
	| message |
	message := AMTMessageBlueprint new.
	message sender: self.
	message recipient: recipient.
	message data: data.
	message type: type.
	recipient addToMailbox: message.
]

{ #category : #'as yet unclassified' }
VostraStart >> gtMethodsFor: aView [
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
VostraStart >> hasActor: anActor [
	| occurrences |
	occurrences := knownActors occurrencesOf: anActor.
	occurrences > 0
		ifTrue: [ ^ true ]
		ifFalse: [ ^ false ]
]

{ #category : #messaging }
VostraStart >> initialize [
	mailbox := OrderedCollection new.
	address := UUIDGenerator new nextRandom16.
	state := 0.
	knownActors := OrderedCollection new.
]

{ #category : #accessing }
VostraStart >> knownActors [
	^ knownActors
]

{ #category : #accessing }
VostraStart >> knownActors: anObject [
	knownActors := anObject
]

{ #category : #messaging }
VostraStart >> processsMessage [
	| message |
	message := mailbox at: 1.
	message type = 'Test'
		ifTrue: [ ^ message data ]
]

{ #category : #initialization }
VostraStart >> receive [
	self actorCard changeColorBack.
	^ self
]

{ #category : #initialization }
VostraStart >> setUp [
	^ self
]

{ #category : #accessing }
VostraStart >> state [
	^ state
]
