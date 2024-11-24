Class {
	#name : #JailCell,
	#superclass : #Cell,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
JailCell >> applyEffectTo: aSpaceship on: aGame [

	aGame putOnJail: aSpaceship
]
