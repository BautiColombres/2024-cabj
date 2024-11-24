Class {
	#name : #GameOver,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #error }
GameOver >> throw [

	Error signal: 'The Game is Over'
]
