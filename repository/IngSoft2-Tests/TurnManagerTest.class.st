Class {
	#name : #TurnManagerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #turns }
TurnManagerTest >> test01OneSpaceshipsThenTurnOneReturnsSpaceshipOne [

	| aTurnManager collectionOfSpaceships currentSpaceshipId |
	collectionOfSpaceships := CollectionOfSpaceships
		                          numberOfSpaceships: 1
		                          withAmountOfFuel: 5.

	aTurnManager := TurnManager manage: collectionOfSpaceships.
	currentSpaceshipId := aTurnManager spaceshipPlaying id.

	Spaceship initialize.
	self assert: currentSpaceshipId equals: 1
]

{ #category : #turns }
TurnManagerTest >> test02TwoSpaceshipsThenTurnTwoReturnsSpaceshipTwo [

	| aTurnManager collectionOfSpaceships currentSpaceshipId |
	collectionOfSpaceships := CollectionOfSpaceships
		                          numberOfSpaceships: 2
		                          withAmountOfFuel: 5.

	aTurnManager := TurnManager manage: collectionOfSpaceships.
	aTurnManager nextTurn.
	currentSpaceshipId := aTurnManager spaceshipPlaying id.

	Spaceship initialize.
	self assert: currentSpaceshipId equals: 2
]

{ #category : #turns }
TurnManagerTest >> test03WhenRoundIsOverNextTurnIsTheFirstSpaceship [

	| aTurnManager collectionOfSpaceships currentSpaceshipId |
	collectionOfSpaceships := CollectionOfSpaceships
		                          numberOfSpaceships: 2
		                          withAmountOfFuel: 5.

	aTurnManager := TurnManager manage: collectionOfSpaceships.
	aTurnManager nextTurn.
	aTurnManager nextTurn.
	currentSpaceshipId := aTurnManager spaceshipPlaying id.

	Spaceship initialize.

	self assert: currentSpaceshipId equals: 1
]

{ #category : #turns }
TurnManagerTest >> test04WhenSpaceshipOneLosesTurnsTheNextTurnIsSpaceshipTwo [

	| aTurnManager collectionOfSpaceships currentSpaceshipId |
	collectionOfSpaceships := CollectionOfSpaceships
		                          numberOfSpaceships: 2
		                          withAmountOfFuel: 5.

	aTurnManager := TurnManager manage: collectionOfSpaceships.
	aTurnManager lostTurns: 2 by: 1.
	aTurnManager nextTurn.
	aTurnManager nextTurn.
	currentSpaceshipId := aTurnManager spaceshipPlaying id.

	Spaceship initialize.
	self assert: currentSpaceshipId equals: 2
]

{ #category : #turns }
TurnManagerTest >> test05WhenSpaceshipOneLosesTwoTurnsThenSpaceshipTwoPlaysThem [

	| aTurnManager collectionOfSpaceships currentSpaceshipId |
	collectionOfSpaceships := CollectionOfSpaceships
		                          numberOfSpaceships: 2
		                          withAmountOfFuel: 5.

	aTurnManager := TurnManager manage: collectionOfSpaceships.
	aTurnManager lostTurns: 2 by: 1.
	aTurnManager nextTurn.
	aTurnManager nextTurn.
	aTurnManager nextTurn.
	aTurnManager nextTurn.
	aTurnManager nextTurn.
	aTurnManager nextTurn.
	currentSpaceshipId := aTurnManager spaceshipPlaying id.

	Spaceship initialize.
	self assert: currentSpaceshipId equals: 1
]

{ #category : #turns }
TurnManagerTest >> test06WhenEverySpaceshipsLosesTheirTurnThenNextTurnIsTheSame [

	| aTurnManager collectionOfSpaceships currentSpaceshipId |
	collectionOfSpaceships := CollectionOfSpaceships
		                          numberOfSpaceships: 1
		                          withAmountOfFuel: 5.

	aTurnManager := TurnManager manage: collectionOfSpaceships.
	aTurnManager lostTurns: 2 by: 1.
	aTurnManager nextTurn.
	currentSpaceshipId := aTurnManager spaceshipPlaying id.

	Spaceship initialize.
	self assert: currentSpaceshipId equals: 1
]

{ #category : #turns }
TurnManagerTest >> test07WhenSpaceshipLostTwoTurnsIsCalledTwiceAndTwoTurnsPassThenSpaceshipRecoversTurn [

	| aTurnManager collectionOfSpaceships currentSpaceshipId |
	collectionOfSpaceships := CollectionOfSpaceships
		                          numberOfSpaceships: 1
		                          withAmountOfFuel: 5.

	aTurnManager := TurnManager manage: collectionOfSpaceships.
	aTurnManager lostTurns: 2 by: 1.
	aTurnManager lostTurns: 2 by: 1.
	aTurnManager lostTurns: 2 by: 1.
	aTurnManager nextTurn.
	aTurnManager nextTurn.
	aTurnManager nextTurn.
	currentSpaceshipId := aTurnManager spaceshipPlaying id.

	Spaceship initialize.
	self assert: currentSpaceshipId equals: 1
]

{ #category : #turns }
TurnManagerTest >> test08OneSpaceshipLostOneTurnAndThenRecoversIt [

	| aTurnManager collectionOfSpaceships currentSpaceshipId |
	collectionOfSpaceships := CollectionOfSpaceships
		                          numberOfSpaceships: 2
		                          withAmountOfFuel: 5.

	aTurnManager := TurnManager manage: collectionOfSpaceships.
	aTurnManager lostTurns: 1 by: 1.
	aTurnManager nextTurn.
	aTurnManager nextTurn.
	aTurnManager nextTurn.
	currentSpaceshipId := aTurnManager spaceshipPlaying id.

	Spaceship initialize.
	self assert: currentSpaceshipId equals: 1
]

{ #category : #reverse }
TurnManagerTest >> test09WhenReverseTurnOrderThenSpaceshipPlayingThreeInsteadOfTwo [

	| aTurnManager collectionOfSpaceships currentSpaceshipId |
	collectionOfSpaceships := CollectionOfSpaceships
		                          numberOfSpaceships: 3
		                          withAmountOfFuel: 5.

	aTurnManager := TurnManager manage: collectionOfSpaceships.
	aTurnManager reverseTurnOrder.
	aTurnManager nextTurn.
	currentSpaceshipId := aTurnManager spaceshipPlaying id.

	Spaceship initialize.
	self assert: currentSpaceshipId equals: 3
]

{ #category : #reverse }
TurnManagerTest >> test10DoblueReverseThenTurnOrderGoesBackToNormal [

	| aTurnManager collectionOfSpaceships currentSpaceshipId |
	collectionOfSpaceships := CollectionOfSpaceships
		                          numberOfSpaceships: 3
		                          withAmountOfFuel: 5.

	aTurnManager := TurnManager manage: collectionOfSpaceships.
	aTurnManager reverseTurnOrder.
	aTurnManager nextTurn.
	aTurnManager reverseTurnOrder.
	aTurnManager nextTurn.
	currentSpaceshipId := aTurnManager spaceshipPlaying id.

	Spaceship initialize.
	self assert: currentSpaceshipId equals: 1
]

{ #category : #turns }
TurnManagerTest >> test11PreviousTurnThenGoesBackToPreviousSpaceship [

	| aTurnManager collectionOfSpaceships currentSpaceshipId |
	collectionOfSpaceships := CollectionOfSpaceships
		                          numberOfSpaceships: 3
		                          withAmountOfFuel: 5.

	aTurnManager := TurnManager manage: collectionOfSpaceships.
	aTurnManager nextTurn.
	aTurnManager previousTurn.
	currentSpaceshipId := aTurnManager spaceshipPlaying id.

	Spaceship initialize.
	self assert: currentSpaceshipId equals: 1
]

{ #category : #turns }
TurnManagerTest >> test12PreviousTurnAtStartItsTheSameAsCurrentTurn [

	| aTurnManager collectionOfSpaceships currentSpaceshipId |
	collectionOfSpaceships := CollectionOfSpaceships
		                          numberOfSpaceships: 3
		                          withAmountOfFuel: 5.

	aTurnManager := TurnManager manage: collectionOfSpaceships.
	aTurnManager previousTurn.
	currentSpaceshipId := aTurnManager spaceshipPlaying id.

	Spaceship initialize.
	self assert: currentSpaceshipId equals: 1
]
