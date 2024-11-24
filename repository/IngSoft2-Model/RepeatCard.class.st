Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RepeatCard class >> toDoEffectFor: aSpaceshipId [

	^ self new initializeToDoEffectFor: aSpaceshipId
]

{ #category : #effect }
RepeatCard >> activateEffectOn: aGame forSpaceship: anId [

	| spaceshipToApplyEffect cellToEnter |
	aGame activateCard: self.
	spaceshipToApplyEffect := aGame spaceships detectSpaceshipWithId:
		                          spaceshipAffected.

	cellToEnter := aGame lastCellEffect.

	cellToEnter applyEffectTo: spaceshipToApplyEffect on: aGame
]
