Class {
	#name : #AtomicBombCell,
	#superclass : #Cell,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
AtomicBombCell >> applyEffectTo: aSpaceship on: aGame [

	aGame resetSpaceshipsToCellOne
]
