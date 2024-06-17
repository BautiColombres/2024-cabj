Class {
	#name : #GameCardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameCardTest >> test01GameActivatesAOverloadCardThenActiveCardsEqualsOne [

	| aLoadedDie aWormholeCreator aBoardCreator aGame |
	aLoadedDie := LoadedDie of: #( 6 ).

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	aBoardCreator := BoardCreator
		                 withCellsAndLaps: #( 10 1 )
		                 withWormholeCreator: aWormholeCreator
		                 andSpecialCellsDistruibution: #( 0 0 0 0 0 0 ).
	aGame := Game
		         numberOfSpaceshipsPlayingWithAllCards: 2
		         withBoardCreator: aBoardCreator
		         playWithDice: aLoadedDie.

	aGame activatePermanentCard: (OverloadCard reduceThrowOf: 2).

	self assert: aGame activeCards equals: 1
]

{ #category : #tests }
GameCardTest >> test02GameActivatesAAccelerationCardThenActiveCardsEqualsOne [

	| aLoadedDie aWormholeCreator aBoardCreator aGame |
	
	aLoadedDie := LoadedDie of: #( 6 ).

	aWormholeCreator := WormholeCreator
		                    withBeginning: 2
		                    andEnd: 3.
	aBoardCreator := BoardCreator
		                 withCellsAndLaps: #( 10 1 )
		                 withWormholeCreator: aWormholeCreator
		                 andSpecialCellsDistruibution: #( 0 0 0 0 0 0 ).
	aGame := Game
		         numberOfSpaceshipsPlayingWithAllCards: 1
		         withBoardCreator: aBoardCreator
		         playWithDice: aLoadedDie.
		
	aGame activatePermanentCard: AccelerationCard new.

	self assert: aGame activeCards equals: 1.
]

{ #category : #tests }
GameCardTest >> test03WhenOneAccelerationCardIsActiveThenSpaceshipMovesOneMoreThenThrowResult [

	| aLoadedDie aWormholeCreator aBoardCreator aGame position |
	aLoadedDie := LoadedDie of: #( 6 ).

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	aBoardCreator := BoardCreator
		                 withCellsAndLaps: #( 10 1 )
		                 withWormholeCreator: aWormholeCreator
		                 andSpecialCellsDistruibution: #( 0 0 0 0 0 0 ).
	aGame := Game
		         numberOfSpaceshipsPlayingWithAllCards: 1
		         withBoardCreator: aBoardCreator
		         playWithDice: aLoadedDie.

	aGame activatePermanentCard: AccelerationCard new.

	position := OrderedCollection with: 8 with: 1.
	self assert: aGame moveSpaceship equals: position
]

{ #category : #tests }
GameCardTest >> test04SpaceshipPlaysAllCardsThenActiveDeckActiveCardsEqualsTwo [

	| aLoadedDie aWormholeCreator aBoardCreator aGame |
	
	aLoadedDie := LoadedDie of: #( 3 ).

	aWormholeCreator := WormholeCreator
		                    withBeginning: 2
		                    andEnd: 3.
	aBoardCreator := BoardCreator
		                 withCellsAndLaps: #( 10 1 )
		                 withWormholeCreator: aWormholeCreator
		                 andSpecialCellsDistruibution: #( 0 0 0 0 0 0 ).
	aGame := Game
		         numberOfSpaceshipsPlayingWithAllCards: 1
		         withBoardCreator: aBoardCreator
		         playWithDice: aLoadedDie.
		
	aGame activatePermanentCard: (OverloadCard reduceThrowOf: 2).
	aGame moveSpaceship .
	aGame activatePermanentCard: AccelerationCard new.
	aGame moveSpaceship .
	aGame activatePermanentCard: AccelerationCard new.

	self assert: aGame activeCards equals: 2.
]

{ #category : #tests }
GameCardTest >> test05SpaceshipOnePlaysOverloadToSpaceshipTwoThenTwoMovesLessTwo [

	| aLoadedDie aWormholeCreator aBoardCreator aGame position |
	aLoadedDie := LoadedDie of: #( 6 ).

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	aBoardCreator := BoardCreator
		                 withCellsAndLaps: #( 10 1 )
		                 withWormholeCreator: aWormholeCreator
		                 andSpecialCellsDistruibution: #( 0 0 0 0 0 0 ).
	aGame := Game
		         numberOfSpaceshipsPlayingWithAllCards: 2
		         withBoardCreator: aBoardCreator
		         playWithDice: aLoadedDie.

	aGame activatePermanentCard: (OverloadCard reduceThrowOf: 2).
	aGame moveSpaceship.

	position := OrderedCollection with: 5 with: 1.
	self assert: aGame moveSpaceship equals: position
]

{ #category : #tests }
GameCardTest >> test06GameActivatesAllyCardThenSpaceshipOneCanUseFuelFromSpaceshipTwo [

	| aLoadedDie aWormholeCreator aBoardCreator aGame result |
	aLoadedDie := LoadedDie of: #( 7 1 ).

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	aBoardCreator := BoardCreator
		                 withCellsAndLaps: #( 30 1 )
		                 withWormholeCreator: aWormholeCreator
		                 andSpecialCellsDistruibution: #( 0 0 0 0 0 0 ).
	aGame := Game
		         numberOfSpaceshipsPlayingWithAllCards: 2
		         withBoardCreator: aBoardCreator
		         playWithDice: aLoadedDie.

	aGame activatePermanentCard: (AllyCard shareFuelWith: 2).
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.
	
	result := Dictionary new.
	result at: 1 put: 22.
	result at: 2 put: 4.
	
	self assert: aGame finalPositionOfSpaceships equals: result
]

{ #category : #tests }
GameCardTest >> test07BothAllysRunOutOfFuelThenBothLooseTwoTurns [

	| aLoadedDie aWormholeCreator aBoardCreator aGame result |
	aLoadedDie := LoadedDie of: #( 7 7 ).

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	aBoardCreator := BoardCreator
		                 withCellsAndLaps: #( 30 1 )
		                 withWormholeCreator: aWormholeCreator
		                 andSpecialCellsDistruibution: #( 0 0 0 0 0 0 ).
	aGame := Game
		         numberOfSpaceshipsPlayingWithAllCards: 2
		         withBoardCreator: aBoardCreator
		         playWithDice: aLoadedDie.

	aGame activatePermanentCard: (AllyCard shareFuelWith: 2).
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.

	result := Dictionary new.
	result at: 1 put: 1.
	result at: 2 put: 1.

	self assert: aGame finalPositionOfSpaceships equals: result
]

{ #category : #tests }
GameCardTest >> test08GameInitializeSpaceshipPlaysAllCardsThenActiveCardsEqualsTwo [

	| aLoadedDie aWormholeCreator aBoardCreator aGame |
	aLoadedDie := LoadedDie of: #( 7 7 ).

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	aBoardCreator := BoardCreator
		                 withCellsAndLaps: #( 30 1 )
		                 withWormholeCreator: aWormholeCreator
		                 andSpecialCellsDistruibution: #( 0 0 0 0 0 0 ).
	aGame := Game
		         numberOfSpaceships: 1
		         withBoardCreator: aBoardCreator
		         playWithDice: aLoadedDie.

	aGame activatePermanentCard: (AllyCard shareFuelWith: 1).
	aGame activatePermanentCard: (AllyCard shareFuelWith: 1).
	aGame activatePermanentCard: (OverloadCard reduceThrowOf: 1).
	aGame activatePermanentCard: (OverloadCard reduceThrowOf: 1).
	aGame activatePermanentCard: AccelerationCard new.
	aGame activatePermanentCard: AccelerationCard new.

	self assert: aGame activeCards equals: 2
]

{ #category : #tests }
GameCardTest >> test09SpaceshipTwoUsesCancellationCardThenActiveCardBySpaceshipOneIsEliminated [

	| aLoadedDie aWormholeCreator aBoardCreator aGame |
	aLoadedDie := LoadedDie of: #( 7 7 ).

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	aBoardCreator := BoardCreator
		                 withCellsAndLaps: #( 30 1 )
		                 withWormholeCreator: aWormholeCreator
		                 andSpecialCellsDistruibution: #( 0 0 0 0 0 0 ).
	aGame := Game
		         numberOfSpaceshipsPlayingWithAllCards: 2
		         withBoardCreator: aBoardCreator
		         playWithDice: aLoadedDie.

	aGame activatePermanentCard: (OverloadCard reduceThrowOf: 2).
	aGame moveSpaceship.

	aGame
		spaceshipId: 2
		activateInstantCard:
		(CancellationCard cancel: (OverloadCard reduceThrowOf: 2)).

	self assert: aGame activeCards equals: 0
]

{ #category : #tests }
GameCardTest >> test10SpaceshipThreeRemovesOverloadCardThenItMovesWithoutEffect [

	| aLoadedDie aWormholeCreator aBoardCreator aGame position |
	aLoadedDie := LoadedDie of: #( 7 7 7 ).

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	aBoardCreator := BoardCreator
		                 withCellsAndLaps: #( 30 1 )
		                 withWormholeCreator: aWormholeCreator
		                 andSpecialCellsDistruibution: #( 0 0 0 0 0 0 ).
	aGame := Game
		         numberOfSpaceshipsPlayingWithAllCards: 3
		         withBoardCreator: aBoardCreator
		         playWithDice: aLoadedDie.

	aGame activatePermanentCard: (OverloadCard reduceThrowOf: 2).
	aGame moveSpaceship.
	aGame activatePermanentCard: (OverloadCard reduceThrowOf: 3).
	aGame moveSpaceship.

	aGame
		spaceshipId: 2
		activateInstantCard:
		(CancellationCard cancel: (OverloadCard reduceThrowOf: 3)).

	position := OrderedCollection with: 8 with: 1.
	self assert: aGame moveSpaceship equals: position
]

{ #category : #tests }
GameCardTest >> test11CancelAllyCardThenBothSpaceshipsUseOnlyTheirFuelTank [

	| aLoadedDie aWormholeCreator aBoardCreator aGame position |
	aLoadedDie := LoadedDie of: #( 7 1 ).

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	aBoardCreator := BoardCreator
		                 withCellsAndLaps: #( 30 1 )
		                 withWormholeCreator: aWormholeCreator
		                 andSpecialCellsDistruibution: #( 0 0 0 0 0 0 ).
	aGame := Game
		         numberOfSpaceshipsPlayingWithAllCards: 2
		         withBoardCreator: aBoardCreator
		         playWithDice: aLoadedDie.

	aGame activatePermanentCard: (AllyCard shareFuelWith: 2).
	aGame moveSpaceship.
	aGame
		spaceshipId: 2
		activateInstantCard:
		(CancellationCard cancel: (AllyCard shareFuelWith: 2)).
	aGame moveSpaceship.

	position := OrderedCollection with: 1 with: 1.
	self assert: aGame moveSpaceship equals: position
]

{ #category : #tests }
GameCardTest >> test12InstancCardPlayedOnAnoterSpaceshipsTurnThenInstantCardCanDoTheEffect [

	| aLoadedDie aWormholeCreator aBoardCreator aGame position |
	aLoadedDie := LoadedDie of: #( 7 7 ).

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	aBoardCreator := BoardCreator
		                 withCellsAndLaps: #( 30 1 )
		                 withWormholeCreator: aWormholeCreator
		                 andSpecialCellsDistruibution: #( 0 0 0 0 0 0 ).
	aGame := Game
		         numberOfSpaceshipsPlayingWithAllCards: 2
		         withBoardCreator: aBoardCreator
		         playWithDice: aLoadedDie.

	aGame activatePermanentCard: (OverloadCard reduceThrowOf: 2).
	aGame
		spaceshipId: 2
		activateInstantCard:
		(CancellationCard cancel: (OverloadCard reduceThrowOf: 2)).
	aGame moveSpaceship.

	position := OrderedCollection with: 8 with: 1.
	self assert: aGame moveSpaceship equals: position
]

{ #category : #tests }
GameCardTest >> test13AccelerationCardPlayedAndCancelledThenSpaceshipMovesWithoutEffect [

	| aLoadedDie aWormholeCreator aBoardCreator aGame position |
	aLoadedDie := LoadedDie of: #( 7 7 ).

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	aBoardCreator := BoardCreator
		                 withCellsAndLaps: #( 30 1 )
		                 withWormholeCreator: aWormholeCreator
		                 andSpecialCellsDistruibution: #( 0 0 0 0 0 0 ).
	aGame := Game
		         numberOfSpaceshipsPlayingWithAllCards: 2
		         withBoardCreator: aBoardCreator
		         playWithDice: aLoadedDie.

	aGame activatePermanentCard: AccelerationCard new.
	aGame
		spaceshipId: 2
		activateInstantCard: (CancellationCard cancel: AccelerationCard new).
	aGame moveSpaceship.

	position := OrderedCollection with: 8 with: 1.
	self assert: aGame moveSpaceship equals: position
]