Class {
	#name : #WithdrawalHandler,
	#superclass : #MessageHandler,
	#category : #'AMT-Model'
}

{ #category : #'as yet unclassified' }
WithdrawalHandler >> appliesToMessage: message [
	^ message type: 'Withdrawal'
]

{ #category : #'as yet unclassified' }
WithdrawalHandler >> executeForMessage: message [
	actor decreaseBy: message data asNumber.
	actor receive
]
