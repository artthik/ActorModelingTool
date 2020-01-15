"
I am the view
"
Class {
	#name : #AMTView,
	#superclass : #BlElement,
	#instVars : [
		'actors',
		'container',
		'controller'
	],
	#category : #'AMT-View'
}

{ #category : #accessing }
AMTView >> actors [
	^ actors
]

{ #category : #adding }
AMTView >> addActor [
	controller addActor
]

{ #category : #adding }
AMTView >> addActorButton [
	^ BrButton new
		beLarge;
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Add Actor';
		action: [ self addActor ];
			constraintsDo: [ :c | c horizontal matchParent ];
		yourself
]

{ #category : #initialization }
AMTView >> addActorCard: anActor [
	| actorCard |
	actorCard := AMTActorCard new
		view: self;
		setActor: anActor;
		addEventHandler: BlPullHandler new.
	container addChild: actorCard.
	actors add: anActor
	"instanceElements addAll: {tmpInstance} TODO: Why does this not work?"
]

{ #category : #initialization }
AMTView >> canvas [
	^ BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		yourself
]

{ #category : #accessing }
AMTView >> container [
	^ container
]

{ #category : #accessing }
AMTView >> controller: anObject [
	controller := anObject
]

{ #category : #initialization }
AMTView >> initialize [
	super initialize.
	actors := OrderedCollection new.
	container := self canvas.
	self
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		"addChild: self toolbar;"
			addChild: container
]

{ #category : #initialization }
AMTView >> toolbar [
	^ BrToolbar new
		look: BrGlamorousToolbarLook;
		background: Color veryVeryLightGray;
		addChild: self addActorButton;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical matchParent ];
		yourself
]
