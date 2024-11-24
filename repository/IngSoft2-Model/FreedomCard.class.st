Class {
	#name : #FreedomCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #effect }
FreedomCard >> activateEffectOn: aGame forSpaceship: anId [

	aGame activateCard: self.
	aGame freeSpaceship: anId
]
