Class {
	#name : #WormholeCreator,
	#superclass : #Object,
	#instVars : [
		'beginningWormhole',
		'endingWormhole'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
WormholeCreator class >> withBeginning: beginning andEnd: ending [

	^ self new initializeWithBeginning: beginning andEnd: ending
]

{ #category : #'set and get' }
WormholeCreator >> beginning [

	^ beginningWormhole
]

{ #category : #'set and get' }
WormholeCreator >> ending [

	^ endingWormhole
]

{ #category : #initialization }
WormholeCreator >> initializeWithBeginning: beginning andEnd: ending [

	beginningWormhole := Wormhole in: beginning to: ending.
	endingWormhole := Wormhole in: ending to: beginning
]
