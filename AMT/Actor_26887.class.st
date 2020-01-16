Class {
	#name : #'Actor_26887',
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
Actor_26887 >> actorCard [
	^ actorCard
]

{ #category : #accessing }
Actor_26887 >> actorCard: anObject [
	actorCard := anObject
]

{ #category : #accessing }
Actor_26887 >> addToMailbox: message [
	mailbox add: message.
	self actorCard changeColor.
]

{ #category : #initialization }
Actor_26887 >> createAndSend [
	^ self
]

{ #category : #messaging }
Actor_26887 >> createAndSendMessageTo: recipient with: data and: type [
	| message |
	message := AMTMessageBlueprint new.
	message sender: self.
	message recipient: recipient.
	message data: data.
	message type: type.
	recipient addToMailbox: message.
]

{ #category : #'as yet unclassified' }
Actor_26887 >> gtMethodsFor: aView [
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
Actor_26887 >> hasActor: anActor [
	| occurrences |
	occurrences := knownActors occurrencesOf: anActor.
	occurrences > 0
		ifTrue: [ ^ true ]
		ifFalse: [ ^ false ]
]

{ #category : #messaging }
Actor_26887 >> initialize [
	mailbox := OrderedCollection new.
	address := UUIDGenerator new nextRandom16.
	state := 0.
	knownActors := OrderedCollection new.
]

{ #category : #accessing }
Actor_26887 >> knownActors [
	^ knownActors
]

{ #category : #accessing }
Actor_26887 >> knownActors: anObject [
	knownActors := anObject
]

{ #category : #messaging }
Actor_26887 >> processsMessage [
	| message |
	message := mailbox at: 1.
	message type = 'Test'
		ifTrue: [ ^ message data ]
]

{ #category : #initialization }
Actor_26887 >> receive [
	self actorCard changeColorBack.
	^ self
]

{ #category : #initialization }
Actor_26887 >> setUp [
	^ self
]

{ #category : #accessing }
Actor_26887 >> state [
	^ state
]
