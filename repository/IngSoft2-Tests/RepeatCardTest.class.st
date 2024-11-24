Class {
	#name : #RepeatCardTest,
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
RepeatCardTest >> setUp [

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

{ #category : #'black hole' }
RepeatCardTest >> test01SpaceshipOneEntersBlackHoleAndSpaceshipTwoRepeatsEffectThenSpaceshipOneIsInPositionOne [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 5 ).
	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	collectionOfCells := OrderedCollection new.
	10 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells at: 6 put: BlackHoleCell new.

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 1
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame spaceshipId: 2 useInstantCard: RepeatCard toDoEffectFor: 1.

	result := Dictionary new.
	result at: 1 put: 1.
	result at: 2 put: 1.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #repeat }
RepeatCardTest >> test02ReapeatCardRepeatsACellThenNothingChanges [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 9 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame spaceshipId: 2 useInstantCard: RepeatCard toDoEffectFor: 1.

	result := Dictionary new.
	result at: 1 put: 10.
	result at: 2 put: 1.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #'moon walk' }
RepeatCardTest >> test03RepeatCardRepeatsMoonWalkThenSpaceshipOneMovesBackwards [

	| aGame result |
	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	collectionOfCells := OrderedCollection new.
	10 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells at: 7 put: (MoonWalkCell withValueToMove: 4).

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 1
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame spaceshipId: 2 useInstantCard: RepeatCard toDoEffectFor: 2.

	result := Dictionary new.
	result at: 1 put: 3.
	result at: 2 put: 1.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #'atomic bomb' }
RepeatCardTest >> test04RepeatCardRepeatsAtomicBombThenEverySpaceshipIsOnCellOne [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 4 ).
	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	collectionOfCells := OrderedCollection new.
	10 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells at: 5 put: AtomicBombCell new.

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 1
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame spaceshipId: 2 useInstantCard: RepeatCard toDoEffectFor: 1.

	result := Dictionary new.
	result at: 1 put: 1.
	result at: 2 put: 1.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #'hyper jump' }
RepeatCardTest >> test05RepeatCardRepeatsHyperJumpThenBothSpaceshipsMoveSameParsecs [

	| aGame result aConversor values |
	aConversor := Conversor totalCells: 4 convertionValue: 8.
	values := OrderedCollection
		          with: (Parsecs ofValue: 10)
		          with: (LightYear ofValue: 24)
		          with: (Parsecs ofValue: 6)
		          with: (Parsecs ofValue: 4).

	aLoadedDie := LoadedDie of: #( 8 ).

	collectionOfCells := OrderedCollection new.
	10 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells
		at: 9
		put: (HyperJumpCell withConversor: aConversor andValues: values).

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 2
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame spaceshipId: 1 useInstantCard: RepeatCard toDoEffectFor: 2.

	result := Dictionary new.
	result at: 1 put: 4.
	result at: 2 put: 5.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #'card dispenser' }
RepeatCardTest >> test06RepeatCardRepeatsCardDispenserThenSpaceshipTwoCanPlayTwoAccelerationCards [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 3 3 3 3 80 ).

	collectionOfCells := OrderedCollection new.
	10 timesRepeat: [ collectionOfCells add: Cell new ].
	collectionOfCells at: 4 put: CardDispenserCell new.

	gameDeck := LoadedEffectManager manage:
		            (OrderedCollection
			             with: AccelerationCard
			             with: RepeatCard).

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 2
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame spaceshipId: 2 useInstantCard: RepeatCard toDoEffectFor: 2.
	aGame usePermanentCard: AccelerationCard toDoEffectFor: nil.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame usePermanentCard: AccelerationCard toDoEffectFor: nil.
	aGame moveSpaceship.

	result := Dictionary new.
	result at: 1 put: 8.
	result at: 2 put: 10.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #wormhole }
RepeatCardTest >> test07RepeatCardRepeatsWormholeThenSpaceshipOneGoesToWormhole [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 9 1 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame spaceshipId: 2 useInstantCard: RepeatCard toDoEffectFor: 1.

	result := Dictionary new.
	result at: 1 put: 3.
	result at: 2 put: 3.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #'hyper gravity' }
RepeatCardTest >> test08RepeatCardRepeatsHyperGravityThenSpaceshipMovesWithoutImpediment [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 7 1 1 ).
	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame spaceshipId: 1 useInstantCard: RepeatCard toDoEffectFor: 2.
	aGame moveSpaceship.

	result := Dictionary new.
	result at: 1 put: 8.
	result at: 2 put: 3.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #'hyper gravity' }
RepeatCardTest >> test09RepeatHyperGravityForSpaceshipTwoThenItCannotMoveBeacuseOfIt [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 7 2 ).

	collectionOfCells := OrderedCollection new.
	10 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells
		at: 8
		put:
		(HyperGravityCell withValueToMove: aLoadedDie amountOfFaces // 2).

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 2
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame spaceshipId: 1 useInstantCard: RepeatCard toDoEffectFor: 2.
	aGame moveSpaceship.

	result := Dictionary new.
	result at: 1 put: 8.
	result at: 2 put: 1.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #'hyper gravity' }
RepeatCardTest >> test10RepeatHyperGravityForSpaceshipTwoThenItCanMoveBeacuseOfThrowGreaterThenValue [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 7 6 ).

	collectionOfCells := OrderedCollection new.
	10 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells
		at: 8
		put:
		(HyperGravityCell withValueToMove: aLoadedDie amountOfFaces // 2).

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 2
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame spaceshipId: 1 useInstantCard: RepeatCard toDoEffectFor: 2.
	aGame moveSpaceship.

	result := Dictionary new.
	result at: 1 put: 8.
	result at: 2 put: 7.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : #jailCell }
RepeatCardTest >> test11RepeateJailForSpaceshipTwoThenItOnlyMovesWithMaxDiceThrow [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 7 6 1 10 ).

	collectionOfCells := OrderedCollection new.
	30 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells at: 8 put: JailCell new.

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 2
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame spaceshipId: 1 useInstantCard: RepeatCard toDoEffectFor: 2.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.

	result := Dictionary new.
	result at: 1 put: 8.
	result at: 2 put: 11.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]
