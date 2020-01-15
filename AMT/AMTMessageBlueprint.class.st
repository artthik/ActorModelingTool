"
I am a blueprint of an AMT Message
"
Class {
	#name : #AMTMessageBlueprint,
	#superclass : #Object,
	#instVars : [
		'sender',
		'recipient',
		'data',
		'type'
	],
	#category : #'AMT-Model'
}

{ #category : #accessing }
AMTMessageBlueprint >> data [
	^ data
]

{ #category : #accessing }
AMTMessageBlueprint >> data: anObject [
	data := anObject
]

{ #category : #accessing }
AMTMessageBlueprint >> recipient [
	^ recipient
]

{ #category : #accessing }
AMTMessageBlueprint >> recipient: anObject [
	recipient := anObject
]

{ #category : #accessing }
AMTMessageBlueprint >> sender [
	^ sender
]

{ #category : #accessing }
AMTMessageBlueprint >> sender: anObject [
	sender := anObject
]

{ #category : #accessing }
AMTMessageBlueprint >> type [
	^ type
]

{ #category : #accessing }
AMTMessageBlueprint >> type: anObject [
	type := anObject
]
