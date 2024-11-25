Class {
	#name : #FuelTank,
	#superclass : #Object,
	#instVars : [
		'fuel',
		'capacity'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
FuelTank class >> fullWith: anAmountOfFuel [

	^ self new initializeFullWith: anAmountOfFuel
]

{ #category : #capacity }
FuelTank >> changeCapacity: aNumber [

	capacity := capacity + aNumber
]

{ #category : #initialization }
FuelTank >> initializeFullWith: anAmountOfFuel [

	fuel := anAmountOfFuel.
	capacity := anAmountOfFuel
]

{ #category : #asserting }
FuelTank >> isEmpty [

	^ fuel <= 0
]

{ #category : #fuel }
FuelTank >> loadFuel: anAmountOfFuel [

	fuel := fuel + anAmountOfFuel
]

{ #category : #'set and get' }
FuelTank >> loadedWith [

	^ fuel
]

{ #category : #capacity }
FuelTank >> reloadToCapacity [

	fuel := capacity
]

{ #category : #fuel }
FuelTank >> useFuel: anAmountOfFuel [

	fuel := fuel - anAmountOfFuel
]
