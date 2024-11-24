Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#instVars : [
		'aLoadedDie',
		'aWormholeCreator',
		'collectionOfCells',
		'aBoardCreator',
		'dice',
		'aCollectionOfDice',
		'gameDeck'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
GameTest >> setUp [

	super setUp.
	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	collectionOfCells := OrderedCollection new.

	dice := OrderedCollection
		        with: (Die of: 10)
		        with: (Die of: 10)
		        with: (Die of: 10)
		        with: (Die of: 10)
		        with: (Die of: 10).

	aCollectionOfDice := Dice of: dice.

	gameDeck := EffectManager
		            manage: (OrderedCollection withAll: {
					             AccelerationCard.
					             AllyCard.
					             OverloadCard.
					             RedoCard.
					             RepeatCard.
					             CancellationCard.
					             ReverseCard.
					             SkipCard.
					             DoubleCard.
					             FreedomCard })
		            withProbabilitiesDistribution:
		            #( 10 10 10 10 10 10 10 10 10 10 )
]

{ #category : #asserting }
GameTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #spaceship }
GameTest >> testGameCreatedWithDieMovesSpaceshipInBetweenOneAndTheAmountOfFaces [

	| aGame aDie |
	aDie := Die of: 5.
	50 timesRepeat: [ collectionOfCells add: Cell new ].

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 1
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aDie
		         andGameDeck: gameDeck.
	aGame playTurn.

	self assert:
		((aGame spaceships cellsOfSpaceships values at: 1) between: 2 and: 6)
]

{ #category : #'game over' }
GameTest >> testSpaceshipOnesWinThenSpaceshipsTwoPlaysAndGameOver [

	| aGame |
	collectionOfCells := OrderedCollection new.
	4 timesRepeat: [ collectionOfCells add: Cell new ].

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 1
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aCollectionOfDice
		         andGameDeck: gameDeck.
	aGame playTurn.
	self
		should: [ aGame playTurn ]
		raise: Error
		withMessage: 'The Game is Over'
]

{ #category : #spaceship }
GameTest >> testTwoSpaceshipsFirstOneMovesTwiceWithDieOfSixThenMinTwoMaxTwelvePosition [

	| aGame aDie |
	aDie := Die of: 6.
	50 timesRepeat: [ collectionOfCells add: Cell new ].

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 1
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aDie
		         andGameDeck: gameDeck.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert:
		((aGame spaceships cellsOfSpaceships values at: 1)
			 between: 1
			 and: 13)
]
