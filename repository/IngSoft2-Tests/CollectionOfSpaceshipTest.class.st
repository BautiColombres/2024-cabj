Class {
	#name : #CollectionOfSpaceshipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #initialization }
CollectionOfSpaceshipTest >> test01CollectionOfSpaceshipsInitializeThenCellsEqualsOne [

	| aCollectionOfSpaceships result |
	aCollectionOfSpaceships := CollectionOfSpaceships
		                           numberOfSpaceships: 2
		                           withAmountOfFuel: 10.

	result := Dictionary new.
	result at: 1 put: 1.
	result at: 2 put: 1.

	self assert: aCollectionOfSpaceships cellsOfSpaceships equals: result
]

{ #category : #results }
CollectionOfSpaceshipTest >> test02LapsOfSpaceshipsThenReturnsDictionaryWithLapOfEachSpaceship [

	| aCollectionOfSpaceships result |
	aCollectionOfSpaceships := CollectionOfSpaceships
		                           numberOfSpaceships: 2
		                           withAmountOfFuel: 10.

	result := Dictionary new.
	result at: 1 put: 1.
	result at: 2 put: 1.

	self assert: aCollectionOfSpaceships lapsOfSpaceships equals: result
]

{ #category : #results }
CollectionOfSpaceshipTest >> test03PositionsOfSpaceshipsThenReturnEachPositionForEverySpaceship [

	| aCollectionOfSpaceships result |
	aCollectionOfSpaceships := CollectionOfSpaceships
		                           numberOfSpaceships: 2
		                           withAmountOfFuel: 10.

	result := Dictionary new.
	result at: 1 put: Position startGame.
	result at: 2 put: Position startGame.

	self
		assert: aCollectionOfSpaceships positionsOfSpaceships
		equals: result
]
