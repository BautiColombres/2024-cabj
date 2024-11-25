Class {
	#name : #Parsecs,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Parsecs class >> ofValue: aValue [

	^ self new initializeOfValue: aValue
]

{ #category : #convertion }
Parsecs >> convertToParsec [

	^ value
]

{ #category : #initialization }
Parsecs >> initializeOfValue: aValue [

	value := aValue
]
