Class {
	#name : #LightYear,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LightYear class >> ofValue: aValue [

	^ self new initializeOfValue: aValue
]

{ #category : #convertion }
LightYear >> convertToParsec [

	^ value / 3
]

{ #category : #initialization }
LightYear >> initializeOfValue: aValue [

	value := aValue
]
