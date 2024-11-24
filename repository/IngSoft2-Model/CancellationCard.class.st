Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#instVars : [
		'cardToCancel'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CancellationCard class >> toDoEffectFor: aCard [

	^ self new initializeToDoEffectFor: aCard
]

{ #category : #effect }
CancellationCard >> activateEffectOn: aGame forSpaceship: anId [

	aGame activateCard: self.
	aGame removeTheCard: cardToCancel
]

{ #category : #initialization }
CancellationCard >> initializeToDoEffectFor: aCard [

	cardToCancel := aCard
]
