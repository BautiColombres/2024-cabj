Class {
	#name : #SpaceshipCardHand,
	#superclass : #Object,
	#instVars : [
		'collectionOfCards',
		'aGameDeck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpaceshipCardHand class >> startGameWith: aGameDeck [

	^ self new initializeStartGameWith: aGameDeck
]

{ #category : #card }
SpaceshipCardHand >> gainACard [

	collectionOfCards add: aGameDeck giveOneObject
]

{ #category : #initialization }
SpaceshipCardHand >> initializeStartGameWith: gameDeck [

	aGameDeck := gameDeck.
	collectionOfCards := gameDeck createCollectionSize: 2
]

{ #category : #card }
SpaceshipCardHand >> use: aCard [

	| cardToRemove |
	(collectionOfCards anySatisfy: [ :card | card = aCard ]) ifTrue: [
		cardToRemove := collectionOfCards detect: [ :card | card = aCard ].
		collectionOfCards remove: cardToRemove.
		^ true ].
	^ false
]
