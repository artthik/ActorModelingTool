"
I am the visual representation of the actor
"
Class {
	#name : #AMTActorElement,
	#superclass : #BlElement,
	#instVars : [
		'tabs',
		'nameLabel',
		'tabGroup',
		'actor',
		'comment',
		'commentEditor',
		'saveCommentButton'
	],
	#category : #'AMT-View'
}

{ #category : #accessing }
AMTActorElement >> actor [
	^ actor
]

{ #category : #accessing }
AMTActorElement >> actor: anObject [
	actor := anObject.
	nameLabel text: actor class name asRopedText.
	commentEditor text: actor class comment asRopedText
]

{ #category : #initialization }
AMTActorElement >> commentEditor [
	^ BrEditor new
		look: BrEditorLook;
		padding: (BlInsets all: 5);
		hMatchParent;
		vExact: 30;
		text: '...';
		yourself
]

{ #category : #initialization }
AMTActorElement >> commentTab [
	| canvas |
	commentEditor := self commentEditor.
	saveCommentButton := self saveCommentButton.
	canvas := BlElement new
		layout: BlLinearLayout vertical;
		background: Color white;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		look: BrShadowLook;
		addChild: commentEditor;
		addChild: saveCommentButton.
	^ BrTab new
		look: BrGlamorousTabLook new;
		label: 'Description';
		stencil: [ canvas ]
]

{ #category : #initialization }
AMTActorElement >> initialize [
	super initialize.
	self layout: BlLinearLayout vertical.
	self background: Color white.
	self look: BrShadowLook.
	self
		constraintsDo: [ :c | 
			c horizontal exact: 400.
			c vertical exact: 400 ].
	nameLabel := self nameLabel.
	tabGroup := self tabGroup.
	self
		addChild: nameLabel;
		addChild: tabGroup.
	^ self
]

{ #category : #accessing }
AMTActorElement >> nameLabel [
	^ BrLabel new
		look: BrLabelLook;
		text: '...';
		margin: (BlInsets all: 10)
]

{ #category : #initialization }
AMTActorElement >> receiveTab [
	^ BrTab new
		look: BrGlamorousTabLook new;
		label: 'Receive';
		stencil: [ BlElement new
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ];
				background: (Color red alpha: 0.2) ]
]

{ #category : #accessing }
AMTActorElement >> saveCommentButton [
	^ BrButton new
		beLarge;
		look: BrGlamorousButtonWithIconLook new;
		icon: BrGlamorousIcons accept asElement;
		label: 'Save Description';
		action: [ actor class comment: commentEditor text asString ];
		constraintsDo: [ :c | c horizontal matchParent ];
		margin: (BlInsets all: 5);
		yourself
]

{ #category : #initialization }
AMTActorElement >> sendTab [
	^ BrTab new
		look: BrGlamorousTabLook new;
		label: 'Send';
		stencil: [ BlElement new
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ];
				margin: (BlInsets all: 10);
				background: (Color red alpha: 0.2) ]
]

{ #category : #initialization }
AMTActorElement >> stateTab [
	^ BrTab new
		look: BrGlamorousTabLook new;
		label: 'State';
		stencil: [ AMTActorCard new
				setActor: actor;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ];
				margin: (BlInsets all: 10) ]
]

{ #category : #accessing }
AMTActorElement >> tabGroup [
	^ BrTabGroup new
		look: BrGlamorousTabGroupLook new;
		addTab: self commentTab;
		addTab: self stateTab;
		addTab: self sendTab;
		addTab: self receiveTab
]
