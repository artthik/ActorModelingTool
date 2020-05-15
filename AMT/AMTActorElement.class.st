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
		'attributesElement',
		'refreshButton',
		'buttons',
		'view',
		'addActorButton',
		'receiveMethodsList',
		'sendMethodsList',
		'allMethodsList',
		'linkActorButton',
		'selectedActor'
	],
	#category : #'AMT-View'
}

{ #category : #accessing }
AMTActorElement >> actor [
	^ actor
]

{ #category : #accessing }
AMTActorElement >> actor: anObject [
	| methods receiveMethods sendMethods |
	actor := anObject.
	anObject actorElement: self.
	nameLabel text: actor class name asRopedText.
	commentEditor text: actor class comment asRopedText.
	attributesElement items: actor class allInstVarNames.
	methods := actor class methods.
	receiveMethods := methods
		select: [ :method | method hasPragmaNamed: 'AMTReceive' ].
	receiveMethodsList items: receiveMethods asOrderedCollection.
	sendMethods := methods
		select: [ :method | method hasPragmaNamed: 'AMTSend' ].
	sendMethodsList items: sendMethods asOrderedCollection.
	allMethodsList items: methods asOrderedCollection
]

{ #category : #accessing }
AMTActorElement >> addActorButton [
	^ BrButton new
		beLarge;
		look: BrGlamorousButtonWithIconLook new;
		icon: BrGlamorousIcons add asElement;
		label: 'Add Actor';
		action: [ view addActor ];
		constraintsDo: [ :c | c horizontal matchParent ];
		margin: (BlInsets top: 5 right: 5);
		yourself
]

{ #category : #initialization }
AMTActorElement >> allMethodsList [
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

{ #category : #initialization }
AMTActorElement >> allMethodsTab [
	allMethodsList := self allMethodsList.
	^ BrTab new
		look: BrGlamorousTabLook new;
		label: 'All methods';
		stencil: [ allMethodsList ]
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
				action: [ :b |  b phlow spawnObject: (actor instVarNamed: n)  ];
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
AMTActorElement >> behaviourTab [
	^ BrTab new
		look: BrGlamorousTabLook new;
		label: 'Behaviour';
		stencil: [ AMTActorCard new setActor: actor ]
]

{ #category : #accessing }
AMTActorElement >> changeHeaderColor [
	nameLabel background: (Color fromHexString: 'FF928B')
	"attributesElement background: Color black."
]

{ #category : #accessing }
AMTActorElement >> changeHeaderColorBack [
	nameLabel background: BrGlamorousColors defaultHeaderBackgroundColor
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
	refreshButton := self refreshButton.
	addActorButton := self addActorButton.
	linkActorButton := self linkActorButton.
	tabGroup := self tabGroup.
	buttons := BlElement new.
	buttons layout: BlLinearLayout horizontal.
	buttons
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: 40 ].
	buttons
		addChild: saveNameButton;
		addChild: refreshButton;
		addChild: addActorButton;
		addChild: linkActorButton.
	self
		addChild: nameLabel;
		addChild: buttons;
		addChild: tabGroup.
	^ self
]

{ #category : #accessing }
AMTActorElement >> linkActor: anActorElement [
	| actorToLink |
	actorToLink := anActorElement.
	view selectedActor ~= 0
		ifTrue: [ | anEdge |
			anEdge := view drawEdgeFrom: view selectedActor to: anActorElement.
			view selectedActor background: Color white.
			view selectedActor: 0 ]
		ifFalse: [ view selectedActor: actorToLink.
			anActorElement background: Color blue.
			view selectedActor: anActorElement ]
]

{ #category : #accessing }
AMTActorElement >> linkActorButton [
	^ BrButton new
		beLarge;
		look: BrGlamorousButtonWithIconLook new;
		icon: BrGlamorousIcons add asElement;
		label: 'Link Actor';
		action: [ self linkActor: self ];
		constraintsDo: [ :c | c horizontal matchParent ];
		margin: (BlInsets top: 5 right: 5);
		yourself
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
		label: 'Main';
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
AMTActorElement >> receiveMethodsList [
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

{ #category : #initialization }
AMTActorElement >> receiveTab [
	receiveMethodsList := self receiveMethodsList.
	^ BrTab new
		look: BrGlamorousTabLook new;
		label: 'Receive';
		stencil: [ receiveMethodsList ]
]

{ #category : #accessing }
AMTActorElement >> refresh [
	self actor: actor
]

{ #category : #accessing }
AMTActorElement >> refreshButton [
	^ BrButton new
		beLarge;
		look: BrGlamorousButtonWithIconLook new;
		icon: BrGlamorousIcons refresh asElement;
		label: 'Refresh Actor';
		action: [ self refresh ];
		constraintsDo: [ :c | c horizontal matchParent ];
		margin: (BlInsets top: 5 right:  5);
		yourself
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
AMTActorElement >> sendMethodsList [
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

{ #category : #initialization }
AMTActorElement >> sendTab [
	sendMethodsList := self sendMethodsList.
	^ BrTab new
		look: BrGlamorousTabLook new;
		label: 'Send';
		stencil: [ sendMethodsList ]
]

{ #category : #accessing }
AMTActorElement >> tabGroup [
	^ BrTabGroup new
		look: BrGlamorousTabGroupLook new;
		addTab: self mainTab;
		addTab: self sendTab;
		addTab: self receiveTab;
		addTab: self allMethodsTab
]

{ #category : #accessing }
AMTActorElement >> view: anObject [
	view := anObject
]
