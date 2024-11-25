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

{ #category : #turns }
TurnManager >> decrementLostTurnsOfSpaceship [

	turnsToSkip
		at: currentSpaceship id
		put: (turnsToSkip at: currentSpaceship id) - 1
]

{ #category : #initialization }
TurnManager >> initializeManage: collectionOfSpaceships [

	spaceships := collectionOfSpaceships collect: [ :spaceship |
		              spaceship ].

	currentSpaceship := spaceships at: 1.
	previousSpaceship := currentSpaceship.
	turnsToSkip := Dictionary new.
	collectionOfSpaceships each: [ :spaceship |
		turnsToSkip at: spaceship id put: 0 ]
]

{ #category : #turns }
TurnManager >> lostTurns: anAmountOfTurns by: aSpaceshipId [

	(turnsToSkip at: aSpaceshipId) = 0 ifTrue: [
		turnsToSkip at: aSpaceshipId put: anAmountOfTurns ]
]

{ #category : #collection }
TurnManager >> nextSpaceship [

	| currentIndex nextIndex |
	currentIndex := spaceships indexOf: currentSpaceship.
	nextIndex := currentIndex + 1.
	nextIndex > spaceships size ifTrue: [ nextIndex := 1 ].
	currentSpaceship := spaceships at: nextIndex
]

{ #category : #turns }
TurnManager >> nextTurn [

	previousSpaceship := currentSpaceship.
	self nextSpaceship.
	[ (turnsToSkip at: currentSpaceship id) > 0 ] whileTrue: [
		self decrementLostTurnsOfSpaceship.
		self nextSpaceship ]
]

{ #category : #turns }
TurnManager >> previousTurn [

	currentSpaceship := previousSpaceship
]

{ #category : #reverse }
TurnManager >> reverseTurnOrder [

	spaceships := spaceships reversed
]

{ #category : #'set and get' }
TurnManager >> spaceshipPlaying [

	^ currentSpaceship
]
