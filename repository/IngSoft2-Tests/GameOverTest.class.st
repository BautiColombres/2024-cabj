Class {
	#name : #GameOverTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GameOverTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #'error testing' }
GameOverTest >> testGameOverThrowIsInvalid [

	self
		should: [ GameOver new throw ]
		raise: Error
		withMessage: 'The Game is Over'
]
