Class {
	#name : #MessageHandler,
	#superclass : #Object,
	#instVars : [
		'actor'
	],
	#category : #'AMT-Model'
}

{ #category : #accessing }
MessageHandler >> actor [
	^ actor
]

{ #category : #accessing }
MessageHandler >> actor: anObject [
	actor := anObject
]

{ #category : #'as yet unclassified' }
MessageHandler >> appliesToMessage: message [
	self subclassResponsibility
	
]

{ #category : #'as yet unclassified' }
MessageHandler >> executeForMessage: message [
	self subclassResponsibility 
]
