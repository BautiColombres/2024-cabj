Class {
	#name : #CardDispenserCell,
	#superclass : #Cell,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
CardDispenserCell >> applyEffectTo: aSpaceship on: aGame [

	aGame giveOneCardTo: aSpaceship
]
