Class {
	#name : #LoadedDiceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #action }
LoadedDiceTest >> test001WhenCollectionOfTwoLoadedDiceThrowThenReturnsSumOfFaces [

	| aCollectionOfLoadedDie dice |
	dice := OrderedCollection
		        with: (LoadedDie of: #( 3 ))
		        with: (LoadedDie of: #( 3 )).
	aCollectionOfLoadedDie := Dice of: dice.
	self assert: aCollectionOfLoadedDie throw equals: 6
]

{ #category : #action }
LoadedDiceTest >> test002CollectionInitializeWithOneDieThrowThenReturnsDiesFaces [

	| aCollectionOfLoadedDie dice |
	dice := OrderedCollection with: (LoadedDie of: #( 3 )).
	aCollectionOfLoadedDie := Dice of: dice.
	self assert: aCollectionOfLoadedDie throw equals: 3
]

{ #category : #initialization }
LoadedDiceTest >> test003WhenCollectionInitializeWithTwoDiceOfThreeThenAmountOfFacesEqualsSix [

	| aCollectionOfLoadedDie dice |
	dice := OrderedCollection
		        with: (LoadedDie of: #( 3 ))
		        with: (LoadedDie of: #( 3 )).
	aCollectionOfLoadedDie := Dice of: dice.
	self assert: aCollectionOfLoadedDie amountOfFaces equals: 6
]
