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

{ #category : #accessing }
CancellationCard >> activateEffectOn: aGame forSpaceship: anId [
	
	aGame removeTheCard: cardToCancel andSaveTheLastInstantCardPlayed: self.
	
]

{ #category : #initialization }
CancellationCard >> initializeToDoEffectFor: aCard [

	cardToCancel := aCard
]
