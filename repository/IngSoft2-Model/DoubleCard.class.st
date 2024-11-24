Class {
	#name : #DoubleCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
DoubleCard >> activateEffectOn: aGame forSpaceship: anId [

	aGame activateCard: self.
	aGame doubleTurn
]
