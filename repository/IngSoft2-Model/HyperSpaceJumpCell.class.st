Class {
	#name : #HyperSpaceJumpCell,
	#superclass : #Cell,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
HyperSpaceJumpCell >> applyEffectTo: aSpaceship on: aGame [

	aGame hyperSpaceJump: aSpaceship
]
