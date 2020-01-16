"
What is the Actor supposed to do?
"
Class {
	#name : #AMTActorBlueprint,
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
AMTActorBlueprint >> actorCard [
	^ actorCard
]

{ #category : #accessing }
AMTActorBlueprint >> actorCard: anObject [
	actorCard := anObject
]

{ #category : #accessing }
AMTActorBlueprint >> addToMailbox: message [
	mailbox add: message.
	self actorCard changeColor.
]

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

{ #category : #'as yet unclassified' }
AMTActorBlueprint >> gtMethodsFor: aView [
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
AMTActorBlueprint >> hasActor: anActor [
	| occurrences |
	occurrences := knownActors occurrencesOf: anActor.
	occurrences > 0
		ifTrue: [ ^ true ]
		ifFalse: [ ^ false ]
]

{ #category : #messaging }
AMTActorBlueprint >> initialize [
	mailbox := OrderedCollection new.
	address := UUIDGenerator new nextRandom16.
	state := 0.
	knownActors := OrderedCollection new.
]

{ #category : #accessing }
AMTActorBlueprint >> knownActors [
	^ knownActors
]

{ #category : #accessing }
AMTActorBlueprint >> knownActors: anObject [
	knownActors := anObject
]

{ #category : #messaging }
AMTActorBlueprint >> processsMessage [
	| message |
	message := mailbox at: 1.
	message type = 'Test'
		ifTrue: [ ^ message data ]
]

{ #category : #initialization }
AMTActorBlueprint >> receive [
	<AMTReceive>
	self actorCard changeColorBack.
	^ self
]

{ #category : #initialization }
AMTActorBlueprint >> setUp [
	<AMTSetup>
	^ self
]

{ #category : #accessing }
AMTActorBlueprint >> state [
	^ state
]
