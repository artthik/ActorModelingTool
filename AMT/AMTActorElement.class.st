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
		'commentEditor',
		'saveCommentButton',
		'saveNameButton',
		'commentLabel',
		'attributesLabel',
		'attributesElement'
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
	commentEditor text: actor class comment asRopedText.
	attributesElement items: actor class allInstVarNames.
]

{ #category : #accessing }
AMTActorElement >> attributesElement [
	^ BrSimpleList new
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
AMTActorElement >> attributesLabel [
	^ BrLabel new
		look: BrLabelLook;
		padding: (BlInsets all: 5);
		background: BrGlamorousColors defaultHeaderBackgroundColor;
		hMatchParent;
		vFitContent;
		text: 'Instance variables' asRopedText;
		yourself
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

{ #category : #accessing }
AMTActorElement >> commentLabel [
	^ BrLabel new
		look: BrLabelLook;
		padding: (BlInsets all: 5);
		background: BrGlamorousColors defaultHeaderBackgroundColor;
		hMatchParent;
		vFitContent;
		text: 'Description' asRopedText;
		yourself
]

{ #category : #initialization }
AMTActorElement >> initialize [
	| aCloseButton |
	super initialize.
	self layout: BlLinearLayout vertical.
	self background: Color white.
	self look: BrShadowLook.
	self
		constraintsDo: [ :c | 
			c horizontal exact: 400.
			c vertical exact: 400 ].
	nameLabel := self nameLabel.
	saveNameButton := self saveNameButton.
	tabGroup := self tabGroup.
	aCloseButton := GtInspectorRoundButtonStencil new asElement
		icon: GtInspectorPlusIconStencil close asElement;
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c
				margin:
					(BlInsets
						top: -10
						left: 0
						bottom: 0
						right: -10).
			c ignored horizontal alignRight.
			c ignored vertical alignTop ];
		action: [ self inform: 'yaes' ].
	self
		addChild: aCloseButton;
		addChild: nameLabel;
		addChild: saveNameButton;
		addChild: tabGroup.
	^ self
]

{ #category : #initialization }
AMTActorElement >> mainTab [
	| canvas |
	commentLabel := self commentLabel.
	commentEditor := self commentEditor.
	saveCommentButton := self saveCommentButton.
	attributesLabel := self attributesLabel.
	attributesElement := self attributesElement.
	canvas := BlElement new
		layout: BlLinearLayout vertical;
		background: Color white;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		look: BrShadowLook;
		addChild: commentLabel;
		addChild: commentEditor;
		addChild: saveCommentButton;
		addChild: attributesLabel;
		addChild: attributesElement.
	^ BrTab new
		look: BrGlamorousTabLook new;
		label: 'Description';
		stencil: [ canvas ]
]

{ #category : #accessing }
AMTActorElement >> nameLabel [
	^ BrEditor new
		look: BrEditorLook;
		padding: (BlInsets all: 5);
		background: BrGlamorousColors defaultHeaderBackgroundColor;
		hMatchParent;
		vExact: 40;
		text: '...' asRopedText;
		yourself
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
		icon: BrGlamorousIcons edit asElement;
		label: 'Save Description';
		action: [ actor class comment: commentEditor text asString ];
		constraintsDo: [ :c | c horizontal matchParent ];
		margin: (BlInsets all: 5);
		yourself
]

{ #category : #accessing }
AMTActorElement >> saveNameButton [
	^ BrButton new
		beLarge;
		look: BrGlamorousButtonWithIconLook new;
		icon: BrGlamorousIcons edit asElement;
		label: 'Save Name';
		action: [ actor class rename: nameLabel text asString ];
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
		addTab: self mainTab;
		addTab: self stateTab;
		addTab: self sendTab;
		addTab: self receiveTab
]
