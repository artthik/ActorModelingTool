"
I am the visual representation of an AMT Actor
"
Class {
	#name : #AMTActorCard,
	#superclass : #BlElement,
	#instVars : [
		'actor',
		'view',
		'refreshButton',
		'addActorButton',
		'nameElement',
		'attributesElement',
		'methodElement',
		'buttons',
		'setUpButton',
		'createAndSendButton',
		'receiveButton',
		'minimizeActorButton',
		'maximizeActorCardButton',
		'saveNameButton',
		'commentElement',
		'actorCard'
	],
	#category : #'AMT-View'
}

{ #category : #accessing }
AMTActorCard >> actor [
	^ actor
]

{ #category : #accessing }
AMTActorCard >> actorElement [
	^ actorCard
]

{ #category : #accessing }
AMTActorCard >> actorElement: anObject [
	actorCard := anObject
]

{ #category : #adding }
AMTActorCard >> addActor [
	view addActor
]

{ #category : #accessing }
AMTActorCard >> addActorButton [
	^ BrButton new
		beLarge;
		look: BrGlamorousButtonWithIconLook new;
		icon: BrGlamorousIcons add asElement;
		label: 'Add Actor';
		action: [ self addActor ];
			constraintsDo: [ :c | c horizontal matchParent ];
		yourself
]

{ #category : #accessing }
AMTActorCard >> addActorButton1 [
	^ addActorButton
]

{ #category : #accessing }
AMTActorCard >> addActorButton: anObject [
	addActorButton := anObject
]

{ #category : #initialization }
AMTActorCard >> attributesElement [
	^ BrSimpleList new
		background: Color veryVeryLightGray;
		padding: (BlInsets all: 5);
		hMatchParent;
		vMatchParent;
		items: {};
		stencil:
			[ :n | 
			BrButton new
				look: BrGlamorousButtonWithLabelLook;
				label: n;
				action: [ :b | b phlow spawnObject: (actor instVarNamed: n) ];
				yourself ] yourself
]

{ #category : #accessing }
AMTActorCard >> attributesElement1 [
	^ attributesElement
]

{ #category : #accessing }
AMTActorCard >> attributesElement: anObject [
	attributesElement := anObject
]

{ #category : #accessing }
AMTActorCard >> buttons [
	^ buttons
]

{ #category : #accessing }
AMTActorCard >> changeColor [
	self background: (Color fromHexString: 'FF928B').
	"attributesElement background: Color black."
]

{ #category : #accessing }
AMTActorCard >> changeColorBack [
	self background: Color white.
]

{ #category : #accessing }
AMTActorCard >> commentElement [
	^ BrEditor new
		look: BrEditorLook;
		padding: (BlInsets all: 5);
		hMatchParent;
		vExact: 30;
		text: '...' asRopedText;
		yourself
]

{ #category : #accessing }
AMTActorCard >> createAndSendMessageButton [
	^ BrButton new
		beLarge;
		look: BrGlamorousButtonLabelLook new;
		label: 'create&send';
		action: [ actor createAndSend ];
			constraintsDo: [ :c | c horizontal matchParent ];
		yourself
]

{ #category : #accessing }
AMTActorCard >> initialize [
	super initialize.
	self layout: BlLinearLayout vertical.
	self
		constraintsDo: [ :c | 
			c horizontal exact: 400.
			c vertical exact: 400 ].
	self background: Color white.
	self look: BrShadowLook.
	saveNameButton := self saveNameButton.
	refreshButton := self refreshButton.
	addActorButton := self addActorButton.
	minimizeActorButton := self minimizeActorCardButton.
	setUpButton := self setUpButton.
	createAndSendButton := self createAndSendMessageButton.
	receiveButton := self receiveButton.
	buttons := BlElement new.
	buttons layout: BlLinearLayout horizontal.
	buttons
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: 30 ].
	buttons
		addChild: minimizeActorButton;
		addChild: refreshButton;
		addChild: addActorButton;
		addChild: setUpButton;
		addChild: createAndSendButton;
		addChild: receiveButton.
	commentElement := self commentElement.
	nameElement := self nameElement.
	attributesElement := self attributesElement.
	methodElement := self methodElement.
	self
		addChild: buttons;
		addChild: nameElement;
		addChild: commentElement;
		addChild: saveNameButton;
		addChild: attributesElement;
		addChild: methodElement.
	self minimizeActorCard
]

{ #category : #accessing }
AMTActorCard >> maximizeActorCard [
	self
		removeChild: maximizeActorCardButton;
		removeChild: nameElement.
	self layout: BlLinearLayout vertical.
	self
		constraintsDo: [ :c | 
			c horizontal exact: 400.
			c vertical exact: 400 ].
	self background: Color white.
	self look: BrShadowLook.
	refreshButton := self refreshButton.
	addActorButton := self addActorButton.
	minimizeActorButton := self minimizeActorCardButton.
	setUpButton := self setUpButton.
	createAndSendButton := self createAndSendMessageButton.
	receiveButton := self receiveButton.
	buttons := BlElement new.
	buttons layout: BlLinearLayout horizontal.
	buttons
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: 30 ].
	buttons
		addChild: minimizeActorButton;
		addChild: refreshButton;
		addChild: addActorButton;
		addChild: setUpButton;
		addChild: createAndSendButton;
		addChild: receiveButton.
	commentElement := self commentElement.
	nameElement := self nameElement.
	attributesElement := self attributesElement.
	methodElement := self methodElement.
	self
		addChild: buttons;
		addChild: nameElement;
		addChild: commentElement;
		addChild: saveNameButton;
		addChild: attributesElement;
		addChild: methodElement.
	self setActor: actor
]

{ #category : #accessing }
AMTActorCard >> maximizeActorCardButton [
	^ BrButton new
		beLarge;
		look: BrGlamorousButtonWithIconLook new;
		icon: BrGlamorousIcons zoomin asElement;
		label: 'Maximize Actor';
		action: [ self maximizeActorCard ];
		yourself
]

{ #category : #accessing }
AMTActorCard >> methodElement [
	^ BrSimpleList new
		padding: (BlInsets all: 5);
		hMatchParent;
		vMatchParent;
		items: {};
		stencil:
			[ :m | 
			(AMTMethodCoder forMethod: m)
				object: actor;
				yourself ] yourself
]

{ #category : #accessing }
AMTActorCard >> methodElement1 [
	^ methodElement
]

{ #category : #accessing }
AMTActorCard >> methodElement: anObject [
	methodElement := anObject
]

{ #category : #accessing }
AMTActorCard >> minimizeActorCard [
	self
		removeChild: nameElement;
		removeChild: commentElement;
		removeChild: saveNameButton;
		removeChild: methodElement;
		removeChild: attributesElement;
		removeChild: buttons.
	maximizeActorCardButton := self maximizeActorCardButton.
	self
		addChild: maximizeActorCardButton;
		addChild: nameElement.
	self
		constraintsDo: [ :c | 
			c horizontal exact: 200.
			c vertical exact: 60 ]
]

{ #category : #accessing }
AMTActorCard >> minimizeActorCardButton [
	^ BrButton new
		beLarge;
		look: BrGlamorousButtonWithIconLook new;
		icon: BrGlamorousIcons zoomout asElement;
		label: 'Minimize Actor';
		action: [ self minimizeActorCard ];
		yourself
]

{ #category : #accessing }
AMTActorCard >> nameElement [
	^ BrEditor new
		look: BrEditorLook;
		padding: (BlInsets all: 5);
		hMatchParent;
		vExact: 30;
		text: '...' asRopedText;
		yourself
]

{ #category : #accessing }
AMTActorCard >> nameElement1 [
	^ nameElement
]

{ #category : #accessing }
AMTActorCard >> nameElement: anObject [
	nameElement := anObject
]

{ #category : #accessing }
AMTActorCard >> receiveButton [
	^ BrButton new
		beLarge;
		look: BrGlamorousButtonLabelLook new;
		label: 'receive';
		action: [ actor receive ];
			constraintsDo: [ :c | c horizontal matchParent ];
		yourself
]

{ #category : #accessing }
AMTActorCard >> refresh [
	self setActor: actor
]

{ #category : #accessing }
AMTActorCard >> refreshButton [
	^ BrButton new
		beLarge;
		look: BrGlamorousButtonWithIconLook new;
		icon: BrGlamorousIcons refresh asElement;
		label: 'Refresh Actor';
		action: [ self refresh ];
			constraintsDo: [ :c | c horizontal matchParent ];
		yourself
]

{ #category : #accessing }
AMTActorCard >> refreshButton: anObject [
	refreshButton := anObject
]

{ #category : #accessing }
AMTActorCard >> saveNameButton [
	^ BrButton new
		beLarge;
		look: BrGlamorousButtonWithIconLook new;
		icon: BrGlamorousIcons edit asElement;
		label: 'Refresh Actor';
		action: [ actor class rename: nameElement text asString.
			actor class comment: commentElement text asString ];
		constraintsDo: [ :c | c horizontal matchParent ];
		yourself
]

{ #category : #accessing }
AMTActorCard >> setActor: anActor [
	| attributes |
	actor := anActor.
	anActor actorElement: self.
	commentElement text: actor class comment asRopedText.
	nameElement text: actor class name asRopedText.
	attributes := actor class allInstVarNames.
	attributesElement items: actor class allInstVarNames.
	methodElement items: actor class methods asOrderedCollection	"
	self
		removeChildren;
		addChild: ((actor gtViewsFor: GtPhlowView empty) asElementDo: #yourself)"
]

{ #category : #accessing }
AMTActorCard >> setUpButton [
	^ BrButton new
		beLarge;
		look: BrGlamorousButtonLabelLook new;
		label: 'setUp';
		action: [ actor setUp ];
			constraintsDo: [ :c | c horizontal matchParent ];
		yourself
]

{ #category : #accessing }
AMTActorCard >> view [
	^ view
]

{ #category : #accessing }
AMTActorCard >> view: aView [
	view := aView.
]
