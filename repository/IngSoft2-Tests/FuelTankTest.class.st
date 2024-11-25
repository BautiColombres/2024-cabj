Class {
	#name : #FuelTankTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #initialization }
FuelTankTest >> test01FuelTankInitializeWithAmountOfFuelThenIsLoadedWithTheSameAmount [

	| aFuelTank |
	aFuelTank := FuelTank fullWith: 10.

	self assert: aFuelTank loadedWith equals: 10
]

{ #category : #action }
FuelTankTest >> test02FuelTankUseFuelThenLoadedWithFuelLessTheAmountUsed [

	| aFuelTank |
	aFuelTank := FuelTank fullWith: 10.
	aFuelTank useFuel: 3.

	self assert: aFuelTank loadedWith equals: 7
]

{ #category : #action }
FuelTankTest >> test03FuelTankUseFuelAndLoadsTheSameAmountThenIsLoadedWithAmountInitializedWith [

	| aFuelTank |
	aFuelTank := FuelTank fullWith: 10.
	aFuelTank useFuel: 3.
	aFuelTank reloadToCapacity.

	self assert: aFuelTank loadedWith equals: 10
]

{ #category : #initialization }
FuelTankTest >> test04FuelTankInitializeWithFuelThenIsNotEmpty [

	| aFuelTank |
	aFuelTank := FuelTank fullWith: 10.

	self deny: aFuelTank isEmpty
]

{ #category : #initialization }
FuelTankTest >> test05FuelTankInitializedWithoutFuelThenIsEmpty [

	| aFuelTank |
	aFuelTank := FuelTank fullWith: 0.

	self assert: aFuelTank isEmpty
]
