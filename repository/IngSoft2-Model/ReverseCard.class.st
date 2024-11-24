Class {
	#name : #ReverseCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
ReverseCard >> activateEffectOn: aGame forSpaceship: anId [

	aGame activateCard: self.
	aGame reverseTurnOrder
]
