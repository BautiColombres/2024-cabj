Class {
	#name : #TurnManager,
	#superclass : #Object,
	#instVars : [
		'spaceships',
		'currentSpaceship',
		'turnsToSkip',
		'previousSpaceship'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
TurnManager class >> manage: collectionOfSpaceships [ 
	^(self new) initializeManage: collectionOfSpaceships .
]

{ #category : #action }
TurnManager >> decrementTurnsOfSpaceship [

	turnsToSkip
		at: currentSpaceship id
		put: (turnsToSkip at: currentSpaceship id) - 1
]

{ #category : #initialization }
TurnManager >> initializeManage: collectionOfSpaceships [

	spaceships := collectionOfSpaceships collect: [ :spaceship |
		              spaceship ].
	
	previousSpaceship := nil.
	currentSpaceship := spaceships at: 1.
	turnsToSkip := Dictionary new.
	collectionOfSpaceships each: [ :spaceship |
		turnsToSkip at: spaceship id put: 0 ]
]

{ #category : #action }
TurnManager >> lostTurns: anAmountOfTurns by: aSpaceshipId [

	(turnsToSkip at: aSpaceshipId) = 0 ifTrue: [
		turnsToSkip at: aSpaceshipId put: anAmountOfTurns ]
]

{ #category : #auxiliar }
TurnManager >> nextSpaceship [

	| currentIndex nextIndex |
	currentIndex := spaceships indexOf: currentSpaceship.
	nextIndex := currentIndex + 1.
	nextIndex > spaceships size ifTrue: [ nextIndex := 1 ].
	currentSpaceship := spaceships at: nextIndex
]

{ #category : #action }
TurnManager >> nextTurn [

	previousSpaceship := currentSpaceship.
	self nextSpaceship.
	[ (turnsToSkip at: currentSpaceship id) > 0 ] whileTrue: [
		self decrementTurnsOfSpaceship.
		self nextSpaceship ]
]

{ #category : #action }
TurnManager >> previousTurn [

	currentSpaceship := previousSpaceship
]

{ #category : #reverseCard }
TurnManager >> reverseTurnOrder [

	spaceships := spaceships reversed
]

{ #category : #accessing }
TurnManager >> spaceshipPlaying [

	^ currentSpaceship
]
