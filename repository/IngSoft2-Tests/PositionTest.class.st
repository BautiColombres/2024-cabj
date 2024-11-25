Class {
	#name : #PositionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #initialization }
PositionTest >> test01PositioninitializeThenCellEqualsOne [

	| aPosition |
	aPosition := Position startGame.

	self assert: aPosition cell equals: 1
]

{ #category : #initialization }
PositionTest >> test02PositioninitializeThenLapEqualsOne [

	| aPosition |
	aPosition := Position startGame.

	self assert: aPosition lap equals: 1
]

{ #category : #'set and get' }
PositionTest >> test03PositioninitializeSetCellTwoThenCellEqualsTwo [

	| aPosition |
	aPosition := Position startGame.
	aPosition updateCell: 1.

	self assert: aPosition cell equals: 2
]

{ #category : #'set and get' }
PositionTest >> test04PositioninitializeSetLapTwoThenLapEqualsTwo [

	| aPosition |
	aPosition := Position startGame.
	aPosition updateLap: 1.

	self assert: aPosition lap equals: 2
]

{ #category : #position }
PositionTest >> test05PositionEqualsAnotherPosition [

	| aPosition position equals |
	aPosition := Position startGame.
	position := Position startGameWithCell: 1 andLap: 1.
	equals := aPosition = position.

	self assert: equals
]

{ #category : #position }
PositionTest >> test06PositionIsNotEqualToAnotherPosition [

	| aPosition position equals |
	aPosition := Position startGame.
	position := Position startGameWithCell: 2 andLap: 1.
	equals := aPosition = position.

	self deny: equals
]

{ #category : #initialization }
PositionTest >> test08PositionInitializeThenIsInLapOne [

	| aPosition |
	aPosition := Position startGame.

	self assert: aPosition lap equals: 1
]
