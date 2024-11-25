Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'turnManager',
		'finishLine',
		'board',
		'spaceshipsCardHands',
		'aActiveDeck',
		'dice',
		'spaceships',
		'cellToEnter',
		'anAllyTankManager',
		'spaceshipsTrapped'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> numberOfSpaceships: anAmount with: aBoardCreator playWith: aCollectionOfDice andGameDeck: anEffectManager [

	^ self new
		  initializeNumberOfSpaceships: anAmount
		  with: aBoardCreator
		  playWith: aCollectionOfDice
		  andGameDeck: anEffectManager
]

{ #category : #card }
Game >> activateCard: aCard [

	aActiveDeck activate: aCard
]

{ #category : #ally }
Game >> ally: spaceshipIdOne with: spaceshipIdTwo [

	| spaceshipOne spaceshipTwo |
	spaceshipOne := spaceships detectSpaceshipWithId: spaceshipIdOne.
	spaceshipTwo := spaceships detectSpaceshipWithId: spaceshipIdTwo.
	anAllyTankManager ally: spaceshipOne with: spaceshipTwo
]

{ #category : #'hyper gravity' }
Game >> applyHyperGravityOn: aSpaceship withValue: value [

	spaceshipsTrapped at: aSpaceship put: value
]

{ #category : #fuel }
Game >> checkAndHandleFuelDepletion: aSpaceship [

	| spaceshipsWithoutFuel |
	spaceshipsWithoutFuel := anAllyTankManager
		                         spaceshipsWithEmptyFuelTank: aSpaceship.
	spaceshipsWithoutFuel do: [ :spaceship |
		turnManager lostTurns: 2 by: spaceship id.
		spaceship resetToOne.
		spaceship loadFuel ]
]

{ #category : #movement }
Game >> checkMoveIsPossible: throwResult for: aSpaceship [

	| positionOfSpaceship aNumberOfMovements |
	aNumberOfMovements := throwResult.
	positionOfSpaceship := aSpaceship position.

	(spaceshipsTrapped includesKey: aSpaceship) ifTrue: [
		throwResult < (spaceshipsTrapped at: aSpaceship)
			ifTrue: [
				aNumberOfMovements := 0.
				^ aNumberOfMovements ]
			ifFalse: [ spaceshipsTrapped removeKey: aSpaceship ] ].

	aNumberOfMovements := positionOfSpaceship
		                      adjustMovementFor: aNumberOfMovements
		                      withLimits: finishLine.

	^ aNumberOfMovements
]

{ #category : #turns }
Game >> doubleTurn [

	| currentSpaceship |
	currentSpaceship := turnManager spaceshipPlaying.
	spaceships
		each: [ :spaceship | turnManager lostTurns: 1 by: spaceship id ]
		but: currentSpaceship
]

{ #category : #jail }
Game >> freeSpaceship: aSpaceshipId [

	| spaceshipToFree |
	spaceshipToFree := spaceships detectSpaceshipWithId: aSpaceshipId.
	spaceshipsTrapped removeKey: spaceshipToFree
]

{ #category : #card }
Game >> giveOneCardTo: aSpaceship [

	(spaceshipsCardHands at: aSpaceship id) gainACard
]

{ #category : #'hyper space jump' }
Game >> hyperSpaceJump: aSpaceship [

	| aPosition aNumberOfMovements |
	aPosition := aSpaceship position.
	aNumberOfMovements := self checkMoveIsPossible: 4 for: aSpaceship.
	aPosition updateCell: aNumberOfMovements.
	aPosition adjustPositionWith: finishLine
]

{ #category : #initialization }
Game >> initializeNumberOfSpaceships: anAmount with: aBoardCreator playWith: aCollectionOfDice andGameDeck: anEffectManager [

	aActiveDeck := ActiveDeck startGame.

	finishLine := Position
		              startGameWithCell: aBoardCreator cells
		              andLap: aBoardCreator laps.

	dice := aCollectionOfDice.

	spaceships := CollectionOfSpaceships
		              numberOfSpaceships: anAmount
		              withAmountOfFuel: dice amountOfFaces * 2.

	anAllyTankManager := AllyTankManager manage: spaceships.

	spaceshipsCardHands := (1 to: anAmount) collect: [ :index |
		                       SpaceshipCardHand startGameWith:
			                       anEffectManager ].

	turnManager := TurnManager manage: spaceships.

	spaceshipsTrapped := Dictionary new.

	board := aBoardCreator createBoard
]

{ #category : #card }
Game >> lastCardPlayed [

	^ aActiveDeck lastCardPlayed
]

{ #category : #cell }
Game >> lastCellEffect [

	^ cellToEnter
]

{ #category : #movement }
Game >> move: spaceship a: numberOfMovements [

	| positionOfSpaceship aNumberOfMovements |
	aNumberOfMovements := self
		                      checkMoveIsPossible: numberOfMovements
		                      for: spaceship.

	positionOfSpaceship := spaceship position.

	anAllyTankManager spaceship: spaceship wantsToUse: aNumberOfMovements.

	spaceship move: aNumberOfMovements.

	positionOfSpaceship adjustPositionWith: finishLine.

	self checkAndHandleFuelDepletion: spaceship
]

{ #category : #'moon walk' }
Game >> moveAllTheSpaceshipsExcept: aSpaceship withValueToMove: aNumberOfMovements [

	spaceships
		each: [ :spaceship | self move: spaceship a: aNumberOfMovements ]
		but: aSpaceship
]

{ #category : #movement }
Game >> playTurn [

	| positionOfSpaceship throwResult currentSpaceship |
	throwResult := self throwDiceAndCheckEffects.
	currentSpaceship := turnManager spaceshipPlaying.
	positionOfSpaceship := currentSpaceship position.

	self move: currentSpaceship a: throwResult.

	cellToEnter := board at: positionOfSpaceship cell.
	cellToEnter applyEffectTo: currentSpaceship on: self.

	positionOfSpaceship = finishLine ifTrue: [
		dice := GameOver new.
		^ self spaceships positionsOfSpaceships ].

	turnManager nextTurn
]

{ #category : #jail }
Game >> putOnJail: aSpaceship [

	| value |
	value := dice amountOfFaces.
	spaceshipsTrapped at: aSpaceship put: value
]

{ #category : #fuel }
Game >> reloadSpaceshipAndLooseTurn [

	| currentSpaceship |
	currentSpaceship := turnManager spaceshipPlaying.
	currentSpaceship loadFuel.
	currentSpaceship := turnManager nextTurn
]

{ #category : #cancellation }
Game >> removeTheCard: aCardToCancel [

	aActiveDeck removeACard: aCardToCancel
]

{ #category : #'atomic bomb' }
Game >> resetSpaceshipsToCellOne [

	spaceships each: [ :spaceship | spaceship resetToOne ]
]

{ #category : #turns }
Game >> reverseTurnOrder [

	turnManager previousTurn.
	turnManager reverseTurnOrder.
	turnManager nextTurn
]

{ #category : #turns }
Game >> skipTurn [

	turnManager nextTurn
]

{ #category : #card }
Game >> spaceshipId: anId useInstantCard: aCard toDoEffectFor: anObject [

	| spaceshipCardHand cardInitialized |
	cardInitialized := aCard toDoEffectFor: anObject.
	spaceshipCardHand := spaceshipsCardHands at: anId.
	(spaceshipCardHand use: aCard) ifTrue: [
		cardInitialized activateEffectOn: self forSpaceship: anId ]
]

{ #category : #accessing }
Game >> spaceships [

	^ spaceships 
]

{ #category : #ally }
Game >> stopAlly: aSpaceshipId [

	| spaceshipOne |
	spaceshipOne := spaceships detectSpaceshipWithId: aSpaceshipId.
	anAllyTankManager stopAlly: spaceshipOne
]

{ #category : #movement }
Game >> throwDiceAndCheckEffects [

	| throwResult maxThrow randomValue currentSpaceship |
	randomValue := Random new next.
	throwResult := dice throw.
	currentSpaceship := turnManager spaceshipPlaying.

	throwResult := aActiveDeck
		               applyEffectOn: throwResult
		               withCurrentSpaceship: currentSpaceship id.

	maxThrow := dice amountOfFaces.
	throwResult = maxThrow ifTrue: [
		randomValue < 0.8
			ifTrue: [ currentSpaceship changeCapacity: 1 ]
			ifFalse: [ currentSpaceship objectFuelTank useFuel: 1 ] ].
	^ throwResult
]

{ #category : #card }
Game >> usePermanentCard: aCard toDoEffectFor: anId [

	| currentSpaceshipCardHand cardInitialized currentSpaceship |
	currentSpaceship := turnManager spaceshipPlaying.
	cardInitialized := aCard toDoEffectFor: anId.
	currentSpaceshipCardHand := spaceshipsCardHands at:
		                            currentSpaceship id.
	(currentSpaceshipCardHand use: aCard) ifFalse: [ ^ self ].
	cardInitialized
		activateEffectOn: self
		forSpaceship: currentSpaceship id
]

{ #category : #results }
Game >> winner [

	^ (spaceships ranking at: 1) id
]
