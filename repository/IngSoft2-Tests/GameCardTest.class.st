Class {
	#name : #GameCardTest,
	#superclass : #TestCase,
	#instVars : [
		'aLoadedDie',
		'aWormholeCreator',
		'aBoardCreator',
		'collectionOfCells',
		'gameDeck'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
GameCardTest >> setUp [

	super setUp.
	aLoadedDie := LoadedDie of: #( 6 ).

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	collectionOfCells := OrderedCollection new.

	30 timesRepeat: [ collectionOfCells add: Cell new ].

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 1
		                 withWormholeCreator: aWormholeCreator.

	gameDeck := LoadedEffectManager manage:
		            (OrderedCollection withAll: {
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
]

{ #category : #running }
GameCardTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #acceleration }
GameCardTest >> test03WhenOneAccelerationCardIsActiveThenSpaceshipMovesOneMoreThanThrowResult [

	| result aGame |
	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: AccelerationCard toDoEffectFor: nil.

	aGame playTurn.
	result := Dictionary new.
	result at: 1 put: 8.


	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #overload }
GameCardTest >> test05SpaceshipOnePlaysOverloadToSpaceshipTwoThenTwoMovesLessTwo [

	| result aGame |
	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: OverloadCard toDoEffectFor: 2.
	aGame playTurn.

	aGame playTurn.
	result := Dictionary new.
	result at: 1 put: 7.
	result at: 2 put: 5.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #ally }
GameCardTest >> test06GameActivatesAllyCardThenSpaceshipOneCanUseFuelFromSpaceshipTwo [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 7 1 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: AllyCard toDoEffectFor: 2.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	result := Dictionary new.
	result at: 1 put: 22.
	result at: 2 put: 4.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #ally }
GameCardTest >> test07BothAllysRunOutOfFuelThenBothLooseTwoTurns [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 7 7 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: AllyCard toDoEffectFor: 2.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	result := Dictionary new.
	result at: 1 put: 1.
	result at: 2 put: 1.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #cancellation }
GameCardTest >> test10SpaceshipThreeRemovesOverloadCardThenItMovesWithoutEffect [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 7 7 7 ).

	aGame := Game
		         numberOfSpaceships: 3
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: OverloadCard toDoEffectFor: 2.
	aGame playTurn.
	aGame usePermanentCard: OverloadCard toDoEffectFor: 3.
	aGame playTurn.

	aGame
		spaceshipId: 2
		useInstantCard: CancellationCard
		toDoEffectFor: (OverloadCard toDoEffectFor: 3).
	aGame playTurn.
	result := Dictionary new.
	result at: 1 put: 8.
	result at: 2 put: 6.
	result at: 3 put: 8.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #cancellation }
GameCardTest >> test11CancelAllyCardThenBothSpaceshipsUseOnlyTheirFuelTank [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 7 1 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: AllyCard toDoEffectFor: 2.
	aGame playTurn.
	aGame
		spaceshipId: 2
		useInstantCard: CancellationCard
		toDoEffectFor: (AllyCard toDoEffectFor: 2).
	aGame playTurn.
	aGame playTurn.
	result := Dictionary new.
	result at: 1 put: 1.
	result at: 2 put: 3.
	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #'instant card' }
GameCardTest >> test12InstancCardPlayedOnAnoterSpaceshipsTurnThenInstantCardCanDoTheEffect [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 7 7 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: OverloadCard toDoEffectFor: 2.
	aGame
		spaceshipId: 2
		useInstantCard: CancellationCard
		toDoEffectFor: (OverloadCard toDoEffectFor: 2).
	aGame playTurn.
	aGame playTurn.
	result := Dictionary new.
	result at: 1 put: 8.
	result at: 2 put: 8.


	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #cancellation }
GameCardTest >> test13AccelerationCardPlayedAndCancelledThenSpaceshipMovesWithoutEffect [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 7 7 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: AccelerationCard toDoEffectFor: nil.
	aGame
		spaceshipId: 2
		useInstantCard: CancellationCard
		toDoEffectFor: AccelerationCard new.
	aGame playTurn.
	aGame playTurn.
	result := Dictionary new.
	result at: 1 put: 8.
	result at: 2 put: 8.
	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #spaceshipCardHand }
GameCardTest >> test27WhenACardThatIsNotInHandTriesToActivateThenDoesNotDoTheEffectOfIt [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 14 12 12 1 ).
	aGame := Game
		         numberOfSpaceships: 3
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: AccelerationCard toDoEffectFor: nil.
	aGame
		spaceshipId: 1
		useInstantCard: CancellationCard
		toDoEffectFor: AccelerationCard new.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame usePermanentCard: AccelerationCard toDoEffectFor: nil.
	aGame playTurn.

	result := Dictionary new.
	result at: 1 put: 16.
	result at: 2 put: 13.
	result at: 3 put: 13.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #cancellation }
GameCardTest >> test28CancellationCardCancelsOnlyTheCardThatIsExactlyTheSameAsTheOneItWantsToCancel [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 7 7 7 7 7 7 7 7 7 7 20 ).

	aGame := Game
		         numberOfSpaceships: 3
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: OverloadCard toDoEffectFor: 2.
	aGame playTurn.
	aGame usePermanentCard: OverloadCard toDoEffectFor: 3.
	aGame playTurn.
	aGame playTurn.

	aGame playTurn.
	aGame
		spaceshipId: 2
		useInstantCard: CancellationCard
		toDoEffectFor: (OverloadCard toDoEffectFor: 2).
	aGame playTurn.
	aGame playTurn.
	result := Dictionary new.
	result at: 1 put: 15.
	result at: 2 put: 13.
	result at: 3 put: 11.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #ally }
GameCardTest >> test31SpaceshipThreeTriesToAllyWithTwoThenItThrowAnErrorBecauseTwoAlreadyHasAlly [

	self
		should: [
			| aGame |
			aLoadedDie := LoadedDie of: #( 1 1 7 1 ).
			aGame := Game
				         numberOfSpaceships: 4
				         with: aBoardCreator
				         playWith: aLoadedDie
				         andGameDeck: gameDeck.

			aGame usePermanentCard: AllyCard toDoEffectFor: 2.
			aGame playTurn.
			aGame playTurn.
			aGame usePermanentCard: AllyCard toDoEffectFor: 2 ]
		raise: Error
		withMessage: 'Spaceship 2 already has an ally.'
]

{ #category : #ally }
GameCardTest >> test32SpaceshipsTwoChangesCapacityAndOneAnTwoAreAllysThenAmountOfTotalFuelChanges [

	| resultOne aGame resultTwo |
	aLoadedDie := LoadedDie of: #( 6 7 6 14 2 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: AllyCard toDoEffectFor: 2.
	aGame playTurn. "1 -> 7"
	aGame playTurn. "2 -> 8"
	aGame playTurn. "1 -> 13"
	aGame reloadSpaceshipAndLooseTurn.
	aGame playTurn. "1 -> 27"
	aGame playTurn. "2 -> 10"

	resultOne := Dictionary new.
	resultOne at: 1 put: 1.
	resultOne at: 2 put: 1.

	resultTwo := Dictionary new.
	resultTwo at: 1 put: 27.
	resultTwo at: 2 put: 10.

	self assert: (aGame spaceships cellsOfSpaceships = resultOne or:
			 aGame spaceships cellsOfSpaceships = resultTwo)
]

{ #category : #spaceshipCardHand }
GameCardTest >> test33GamePlaysWithDeckWithProbabilisticDistributionThenSpaceshipCardHandAlwaysInitializedWithTwoCards [

	| result aGame |
	gameDeck := EffectManager
		            manage: (OrderedCollection with: AccelerationCard)
		            withProbabilitiesDistribution: #( 100 ).
	aLoadedDie := LoadedDie of: #( 4 ).
	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: AccelerationCard toDoEffectFor: nil.
	aGame usePermanentCard: AccelerationCard toDoEffectFor: nil.
	aGame usePermanentCard: AccelerationCard toDoEffectFor: nil.
	aGame playTurn.

	result := Dictionary new.
	result at: 1 put: 7.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #reverse }
GameCardTest >> test34SpaceshipOneMovesAndPlaysReverseThenThreeMovesInsteadOfTwo [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 7 7 ).

	aGame := Game
		         numberOfSpaceships: 3
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame playTurn.
	aGame spaceshipId: 1 useInstantCard: ReverseCard toDoEffectFor: nil.
	aGame playTurn.

	result := Dictionary new.
	result at: 1 put: 8.
	result at: 2 put: 1.
	result at: 3 put: 8.


	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #reverse }
GameCardTest >> test35TwoReverseCardsPlayedThenTurnOrderStaysTheSame [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 7 7 ).

	aGame := Game
		         numberOfSpaceships: 3
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame playTurn.
	aGame spaceshipId: 1 useInstantCard: ReverseCard toDoEffectFor: nil.
	aGame spaceshipId: 2 useInstantCard: ReverseCard toDoEffectFor: nil.
	aGame playTurn.

	result := Dictionary new.
	result at: 1 put: 8.
	result at: 2 put: 8.
	result at: 3 put: 1.


	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #skip }
GameCardTest >> test36SkipCardPlayedThenSpaceshipThreeDoesntGetItsTurn [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 7 7 7 ).

	aGame := Game
		         numberOfSpaceships: 4
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame playTurn.
	aGame playTurn.
	aGame spaceshipId: 1 useInstantCard: SkipCard toDoEffectFor: nil.
	aGame playTurn.

	result := Dictionary new.
	result at: 1 put: 8.
	result at: 2 put: 8.
	result at: 3 put: 1.
	result at: 4 put: 8.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #double }
GameCardTest >> test37SpaceshipsOneAndThreeUseDoubleCardThenGetToPlayTwiceInARow [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 7 7 7 7 7 10 ).

	aGame := Game
		         numberOfSpaceships: 3
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame spaceshipId: 1 useInstantCard: DoubleCard toDoEffectFor: nil.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame spaceshipId: 3 useInstantCard: DoubleCard toDoEffectFor: nil.
	aGame playTurn.
	aGame playTurn.

	result := Dictionary new.
	result at: 1 put: 15.
	result at: 2 put: 8.
	result at: 3 put: 15.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #freedom }
GameCardTest >> test38SpaceshipTwoPlaysFreedomCardThenGetsOutOfJail [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 7 9 7 7 15 ).

	30 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells at: 10 put: JailCell new.

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 1
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame playTurn.
	aGame playTurn.
	aGame spaceshipId: 2 useInstantCard: FreedomCard toDoEffectFor: 2.
	aGame playTurn.
	aGame playTurn.

	result := Dictionary new.
	result at: 1 put: 15.
	result at: 2 put: 17.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]
