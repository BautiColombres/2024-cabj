Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'id',
		'aFuelTank',
		'objectPosition'
	],
	#classInstVars : [
		'counterId'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Spaceship class >> initialize [

	counterId := 0
]

{ #category : #'instance creation' }
Spaceship class >> launchWithFuel: anAmountOfFuel [
	counterId := counterId + 1.
	^ self new initializeLaunch: counterId withFuel: anAmountOfFuel .
]

{ #category : #comparing }
Spaceship >> > aSpaceship [

	| completedLaps aSpaceshipCompletedLaps cellPosition aSpaceshipCellPosition |
	completedLaps := objectPosition lap - 1.
	aSpaceshipCompletedLaps := aSpaceship position lap - 1.
	cellPosition := objectPosition cell.
	aSpaceshipCellPosition := aSpaceship position cell.

	^ completedLaps > aSpaceshipCompletedLaps
		  ifTrue: [ true ]
		  ifFalse: [
			  completedLaps = aSpaceshipCompletedLaps
				  ifTrue: [ cellPosition > aSpaceshipCellPosition ]
				  ifFalse: [ false ] ]
]

{ #category : #fuel }
Spaceship >> amountOfFuel [

	^ aFuelTank loadedWith
]

{ #category : #capacity }
Spaceship >> changeCapacity: aNumber [

	aFuelTank changeCapacity: aNumber
]

{ #category : #'set and get' }
Spaceship >> id [

	^ id
]

{ #category : #initialization }
Spaceship >> initializeLaunch: counterId withFuel: anAmountOfFuel [

	objectPosition := Position startGame.
	aFuelTank := FuelTank fullWith: anAmountOfFuel.
	id := counterId
]

{ #category : #fuel }
Spaceship >> loadFuel [

	aFuelTank reloadToCapacity
]

{ #category : #movement }
Spaceship >> move: aNumberOfMovements [

	| aux |
	aux := aNumberOfMovements.
	aNumberOfMovements > aFuelTank loadedWith ifTrue: [
		aux := aFuelTank loadedWith ].

	objectPosition updateCell: aux.

	aFuelTank useFuel: aux abs
]

{ #category : #fuel }
Spaceship >> objectFuelTank [

	^ aFuelTank
]

{ #category : #'set and get' }
Spaceship >> position [

	^ objectPosition
]

{ #category : #movement }
Spaceship >> resetToOne [

	| currentCell |
	currentCell := objectPosition cell.
	objectPosition updateCell: 1 - currentCell
]
