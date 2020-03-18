"
!Bank withdrawal example

This example shows a simple one way message being sent by one actor and being received and processed by another actor.

Here you will get a step by step example for an ATM use case.
The use case is that a user will withdraw an amount form the ATM. The ATM will make sure that the Bankaccount of the user has a valid amount to withdraw the desired amount.

!!1. Open the Actor Modeling Tool
The tool opens with an empty actor card that holds no further logic than the default starting methods.

!!2. Add another actor
Click on the ""+"" button the actor card.

!!3. Change the name of the actors
Change the names to ""Bank"" and ""ATM"" and then click the edit name button on the actor cards.

!!4. Add the desired methods to the classes

!!!!4.1 Add all the setup methods for all actors
Set the setup method to set the state of the ATM and the Bank.
In our example we want to set the state of the ATM to be the amount of cash in the ATM and the state of the Bank to be the amount of cash the user has.
So the setup method will set the amounts for both actors.

For the ATM this can be something like this:
ATM >> setUp
	state := 500.

For the Bank something like this:
Bank >> setUp
	state := 5000.
	
!!!!4.2 Add the ATM method to create and send a message to the bank
ATM >> createAndSend
| bank |
state := state - 200.
	knownActors
		do: [ :actor | 
			actor class = Bank
				ifTrue: [ bank := actor ] ].
	self createAndSendMessageTo: bank with: '200' and: 'Withdrawal'

!!!!4.3 Add the Bank method to receive and process the message from the ATM
Bank >> receive
	| message |
	message := mailbox at: 1.
	message type = 'Withdrawal'
		ifTrue: [ state := state - message data asNumber]
		
!!5. Click setUp on each actor
By clicking and inspecting the state before and after clicking setUp on the actor card we will see, that the state has changed by implementation and interaction.

!!6. Click create&send on the AMT actor card.
By clicking create&send in the ATM actor card we can no see the Bank being updated in red, this indicates a new message has arrived.

!!7. Click receive on the Bank actor card.
By clicking receive the state will change and the actor card will return to it's default color, as the message has been processed.
"
Class {
	#name : #AMTExampleATMWithdrawal,
	#superclass : #Object,
	#instVars : [
		'view',
		'actors',
		'bankActor',
		'atmActor',
		'container',
		'actorCards'
	],
	#category : #'AMT-Examples'
}

{ #category : #'accessing structure variables' }
AMTExampleATMWithdrawal >> completeScenario [
	"Delete older instances of Bank and ATM"

	<gtExample>
	Smalltalk globals removeClassNamed: 'Bank'.
	Smalltalk globals removeClassNamed: 'ATM'.
	"Create new AMT project with initial actor"
	view := AMTController new.
	"Add another actor"
	view addActor.
	actors := view actors.
	"Rename actors"
	bankActor := actors at: 1.
	bankActor class rename: 'Bank'.
	bankActor class comment: 'I am the Bank, doing Bank stuff'.
	atmActor := actors at: 2.
	atmActor class rename: 'ATM'.
	atmActor class comment: 'I am the ATM, doing all the ATM stuff'.
	"Add all the needed methods to all the classes"
	atmActor class
		compile:
			'setUp state := 500.'.
	bankActor class
		compile:
			'setUp state := 5000.'.
	"Add the ATM method to create and send a message to the bank"
	atmActor class
		compile:
			'createAndSend <AMTSend> 
				| bank | 
				state := state - 200. 
				knownActors do: [ :actor | actor class = Bank 
					ifTrue: [ bank := actor ] ]. 
				self createAndSendMessageTo: bank with: ''200'' and: ''Withdrawal'''.
	"Add the Bank method to receive and process the message from the ATM"
	bankActor class
		compile:
			'receiveWithdrawal <AMTReceive>
			|message|
			message := mailbox at: 1.
				 self when: (message type = ''Withdrawal'' )
				and: (2=2)
					  do: [ state := state - message data asNumber]. 
				self receive'.
	"Refresh the actors so the view shows the changes"
	container := view container.
	actorCards := container children.
	actorCards do: [ :each | each refresh ].
	^ view
]
