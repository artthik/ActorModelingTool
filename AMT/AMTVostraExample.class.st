"
!Actor modeling tool VOSTRA example

In this example we will walk through a part of a real life software project being implemented currently.

VOSTRA is an software system of the canton of Bern that manages and stores criminal records. The duration these criminal records need to be stored is defined by a new law (StReG), that is being implemented by the EJPD in Bern.

+file://Fristen_L1.jpg+

In this image we can see that there are multiple questions that need to be answered to determine the duration of a criminal record. We however will focus on the first and most important question.

+file://one.jpg+

After a conviction is being recorded the ""checkers"" will check for certain flags and categorisations, this will let them calculate the duration the criminal record is going to be stored.

Our input is a criminal record and our output will be a duration this criminal record needs to be stored. 

!!1. VostraStart
In the VostraStart Actor we will fabricate the criminal record and send it to Checker1.

For this criminal record we need different types of data:
- Personal information that identifies the criminal
- The type of the criminal offense
- The conviction in years
- The flag if a conviction is for life
- The type of the penalty
- And if an appeal has been accepted

!!2. Checker1
Here we will check if the """"type of the criminal offense"""" falls under any of the categories, where the record need to be stored indefinitely or if the """"conviction"""" is for life.

!!3. Checker2
Here we check what """"type the penalty"""" or if there is a """"flag that the conviction is for life"""".

!!4. Checker3
Here we will check again the """"type of the penalty"""" and if there has been an """"accepted appeal"""".

!!5. VostraEnd
This is the final actor, that will evaluate and return us the """"duration the criminal record is going to be stored"""".
"
Class {
	#name : #AMTVostraExample,
	#superclass : #Object,
	#instVars : [
		'view',
		'actors',
		'vostraStart',
		'vostraChecker1',
		'vostraChecker2',
		'vostraChecker3',
		'vostraEnd',
		'container',
		'actorCards'
	],
	#category : #'AMT-Examples'
}

{ #category : #'accessing structure variables' }
AMTVostraExample >> addAndRenameActors [
	"Add another actor"
	view addActor.
	view addActor.
	view addActor.
	view addActor.
	actors := view actors.
	"Rename actors"
	vostraStart := actors at: 1.
	vostraStart class rename: 'VostraStart'.
	vostraChecker1 := actors at: 2.
	vostraChecker1 class rename: 'VostraChecker1'.
	vostraChecker2 := actors at: 3.
	vostraChecker2 class rename: 'VostraChecker2'.
	vostraChecker3 := actors at: 4.
	vostraChecker3 class rename: 'VostraChecker3'.
	vostraEnd := actors at: 5.
	vostraEnd class rename: 'VostraEnd'.
]

{ #category : #'accessing structure variables' }
AMTVostraExample >> addMethodToVostraChecker1 [
	"VostraChecker1"

	vostraChecker1 class
		compile:
			'receive
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
	message type = ''Check1''
		ifTrue: [ (message data at: 2) = ''2''
				ifTrue: [ message data at: 7 put: ''indefinitely''.
					self
						createAndSendMessageTo: vostraEnd
						with: message data
						and: ''End''.
						self actorCard changeColorBack.
						^self. ].
			(message data at: 3) asNumber > 25
				ifTrue: [ message data at: 7 put: ''indefinitely''.
					self
						createAndSendMessageTo: vostraEnd
						with: message data
						and: ''End''.
						self actorCard changeColorBack.
						^self. ].
			((message data at: 2) ~= ''2''
				or: [ (message data at: 3) asNumber <= 25 ])
				ifTrue: [ self
						createAndSendMessageTo: vostraChecker2
						with: message data
						and: ''Check2'' ] ].
	self actorCard changeColorBack'
]

{ #category : #'accessing structure variables' }
AMTVostraExample >> addMethodToVostraChecker2 [
	"VostraChecker2"

	vostraChecker2 class
		compile:
			'receive
	| message vostraChecker3 vostraEnd |
	knownActors
		do: [ :actor | 
			actor class = VostraChecker3
				ifTrue: [ vostraChecker3 := actor ] ].
	knownActors
		do: [ :actor | 
			actor class = VostraEnd
				ifTrue: [ vostraEnd := actor ] ].
	message := mailbox at: 1.
	mailbox remove: message.
	message type = ''Check2''
		ifTrue: [ (message data at: 4) = ''yes''
				ifTrue: [ message data at: 7 put: ''indefinitely''.
					self
						createAndSendMessageTo: vostraEnd
						with: message data
						and: ''End''.
					self actorCard changeColorBack.
					^ self ].
			(message data at: 5) = ''life sentance''
				ifTrue: [ message data at: 7 put: ''indefinitely''.
					self
						createAndSendMessageTo: vostraChecker3
						with: message data
						and: ''End''.
					self actorCard changeColorBack.
					^ self ].
			((message data at: 4) ~= ''yes''
				or: [ (message data at: 5) ~= ''life sentance'' ])
				ifTrue: [ self
						createAndSendMessageTo: vostraChecker3
						with: message data
						and: ''Check3'' ] ].
	self actorCard changeColorBack'
]

{ #category : #'accessing structure variables' }
AMTVostraExample >> addMethodToVostraChecker3 [
	"VostraChecker3"

	vostraChecker3 class
		compile:
			'receive
	| message vostraEnd |
	knownActors
		do: [ :actor | 
			actor class = VostraEnd
				ifTrue: [ vostraEnd := actor ] ].
	message := mailbox at: 1.
	mailbox remove: message.
	message type = ''Check3''
		ifTrue: [ (message data at: 5) = ''deportation''
				ifTrue: [ message data at: 7 put: (message data at: 3) ].
			(message data at: 6) = ''yes''
				ifTrue: [ message data at: 7 put: 0.
					self
						createAndSendMessageTo: vostraEnd
						with: message data
						and: ''End''.
					self actorCard changeColorBack.
					^ self ].
			((message data at: 5) ~= ''deportation''
				or: [ (message data at: 6) ~= ''yes'' ])
				ifTrue: [ message data at: 7 put: (message data at: 3).
					self
						createAndSendMessageTo: vostraEnd
						with: message data
						and: ''End'' ] ].
	self actorCard changeColorBack'
]

{ #category : #'accessing structure variables' }
AMTVostraExample >> addMethodToVostraEnd [
	"VostraEnd"

	vostraEnd class
		compile:
			'receive
	| message |
	message := mailbox at: 1.
	mailbox remove: message.
	message type = ''End''
		ifTrue: [ self inform: ''Criminal record of '',(message data at: 1),'' needs to be stored for '',(message data at: 7),'' years'' ].
	self actorCard changeColorBack'
]

{ #category : #'accessing structure variables' }
AMTVostraExample >> addMethodToVostraStart [
	"VostraStart"

	vostraStart class
		compile:
			'createAndSend
	| vostraChecker1 data |
	state := state - 200.
	knownActors
		do: [ :actor | 
			actor class = VostraChecker1
				ifTrue: [ vostraChecker1 := actor ] ].
	data := OrderedCollection new.
	data add: ''Sherlock Holmes, 221b Baker street, London, January 6th 1854''.
	data add: ''1''.
	data add: ''20''.
	data add: ''no''.
	data add: ''prison''.
	data add: ''no''.
	data add: ''0''.
	self createAndSendMessageTo: vostraChecker1 with: data and: ''Check1'''
]

{ #category : #'accessing structure variables' }
AMTVostraExample >> cleanUp [
	Smalltalk globals removeClassNamed: 'VostraStart'.
	Smalltalk globals removeClassNamed: 'VostraChecker1'.
	Smalltalk globals removeClassNamed: 'VostraChecker2'.
	Smalltalk globals removeClassNamed: 'VostraChecker3'.
	Smalltalk globals removeClassNamed: 'VostraEnd'.
]

{ #category : #'accessing structure variables' }
AMTVostraExample >> completeScenario [
	"Delete older instances of Bank and ATM"

	<gtExample>
	self cleanUp.
	"Create new AMT project with initial actor"
	view := AMTController new.

	"Add another actor"
	self addAndRenameActors.

	"VostraStart"
	self addMethodToVostraStart.
	"VostraChecker1"
	self addMethodToVostraChecker1.
	"VostraChecker2"
	self addMethodToVostraChecker2.
	"VostraChecker3"
	self addMethodToVostraChecker3.
	"VostraEnd"
	self addMethodToVostraEnd.

	"Refresh the actors so the view shows the changes"
	self refreshTool.
	^ view
]

{ #category : #'accessing structure variables' }
AMTVostraExample >> refreshTool [
	"Refresh the actors so the view shows the changes"

	container := view container.
	actorCards := container children.
	actorCards do: [ :each | each refresh ]
]
