Class {
	#name : #SkipCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
SkipCard >> activateEffectOn: aGame forSpaceship: anId [

	aGame activateCard: self.
	aGame skipTurn
]
