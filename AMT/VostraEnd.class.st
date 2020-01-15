Class {
	#name : #VostraEnd,
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
VostraEnd >> actorCard [
	^ actorCard
]

{ #category : #accessing }
VostraEnd >> actorCard: anObject [
	actorCard := anObject
]

{ #category : #accessing }
VostraEnd >> addToMailbox: message [
	mailbox add: message.
	self actorCard changeColor.
]

{ #category : #initialization }
VostraEnd >> createAndSend [
	^ self
]

{ #category : #messaging }
VostraEnd >> createAndSendMessageTo: recipient with: data and: type [
	| message |
	message := AMTMessageBlueprint new.
	message sender: self.
	message recipient: recipient.
	message data: data.
	message type: type.
	recipient addToMailbox: message.
]

{ #category : #'as yet unclassified' }
VostraEnd >> gtMethodsFor: aView [
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
VostraEnd >> hasActor: anActor [
	| occurrences |
	occurrences := knownActors occurrencesOf: anActor.
	occurrences > 0
		ifTrue: [ ^ true ]
		ifFalse: [ ^ false ]
]

{ #category : #messaging }
VostraEnd >> initialize [
	mailbox := OrderedCollection new.
	address := UUIDGenerator new nextRandom16.
	state := 0.
	knownActors := OrderedCollection new.
]

{ #category : #accessing }
VostraEnd >> knownActors [
	^ knownActors
]

{ #category : #accessing }
VostraEnd >> knownActors: anObject [
	knownActors := anObject
]

{ #category : #messaging }
VostraEnd >> processsMessage [
	| message |
	message := mailbox at: 1.
	message type = 'Test'
		ifTrue: [ ^ message data ]
]

{ #category : #initialization }
VostraEnd >> receive [
	| message |
	message := mailbox at: 1.
	mailbox remove: message.
	message type = 'End'
		ifTrue: [ self inform: 'Criminal record of ',(message data at: 1),' needs to be stored for ',(message data at: 7),' years' ].
	self actorCard changeColorBack
]

{ #category : #initialization }
VostraEnd >> setUp [
	^ self
]

{ #category : #accessing }
VostraEnd >> state [
	^ state
]
