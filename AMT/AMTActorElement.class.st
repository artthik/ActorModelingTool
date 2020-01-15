"
I am the visual representation of the actor
"
Class {
	#name : #AMTActorElement,
	#superclass : #BlElement,
	#instVars : [
		'tabs',
		'nameLabel',
		'tabGroup'
	],
	#category : #'AMT-View'
}

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
	nameLabel := BrLabel new
		look: BrLabelLook;
		text: 'Text';
		margin: (BlInsets all: 10).
	tabGroup := BrTabGroup new.
	tabGroup look: BrGlamorousTabGroupLook new.
	tabGroup
		addTab: self mainTab;
		addTab: self stateTab;
		addTab: self sendTab;
		addTab: self receiveTab.
	self
		addChild: nameLabel;
		addChild: tabGroup.
	^ self
]

{ #category : #initialization }
AMTActorElement >> mainTab [
	^ BrTab new
		look: BrGlamorousTabLook new;
		label: 'Main';
		stencil: [ BlElement new
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ];
				margin: (BlInsets all: 10);
				background: (Color red alpha: 0.2) ]
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
				margin: (BlInsets all: 10);
				background: (Color red alpha: 0.2) ]
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
		stencil: [ BlElement new
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ];
				margin: (BlInsets all: 10);
				background: (Color red alpha: 0.2) ]
]
