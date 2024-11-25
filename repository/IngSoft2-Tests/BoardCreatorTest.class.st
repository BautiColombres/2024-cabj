Class {
	#name : #BoardCreatorTest,
	#superclass : #TestCase,
	#instVars : [
		'aConversor',
		'values',
		'anEffectManager',
		'aWormholeCreator',
		'collectionOfCells',
		'aBoardCreator',
		'board'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
BoardCreatorTest >> setUp [

	super setUp.
	aConversor := Conversor totalCells: 4 convertionValue: 8.
	values := OrderedCollection
		          with: (Parsecs ofValue: 10)
		          with: (LightYear ofValue: 24)
		          with: (Parsecs ofValue: 6)
		          with: (Parsecs ofValue: 4).

	anEffectManager := EffectManager
		                   manage: (OrderedCollection withAll: {
					                    AtomicBombCell new.
					                    BlackHoleCell new.
					                    CardDispenserCell new.
					                    (HyperGravityCell withValueToMove: 7).
					                    (HyperJumpCell
						                     withConversor: aConversor
						                     andValues: values).
					                    HyperSpaceJumpCell new.
					                    JailCell new.
					                    (MoonWalkCell withValueToMove: 4).
					                    Cell new })
		                   withProbabilitiesDistribution:
		                   #( 2 20 10 20 8 5 1 10 24 ).


	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	collectionOfCells := anEffectManager createCollectionSize: 100.

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 2
		                 withWormholeCreator: aWormholeCreator.

	board := aBoardCreator createBoard
]

{ #category : #asserting }
BoardCreatorTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #initialization }
BoardCreatorTest >> test01BoardCreatorInitializeThenCellsReturnsAmountOfCellsOnBoard [

	collectionOfCells := OrderedCollection new.
	5 timesRepeat: [ collectionOfCells add: Cell new ].

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 1
		                 withWormholeCreator: aWormholeCreator.

	self assert: aBoardCreator cells equals: 5
]

{ #category : #initialization }
BoardCreatorTest >> test02BoardCreatorInitializeThenLapsReturnsAmountOfLaps [

	collectionOfCells := OrderedCollection new.
	5 timesRepeat: [ collectionOfCells add: Cell new ].

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 1
		                 withWormholeCreator: aWormholeCreator.

	self assert: aBoardCreator laps equals: 1
]

{ #category : #board }
BoardCreatorTest >> test03BoardCreatorCreatesBoardWithCollectionOfCellsThenBoardHasThatCollectionPlusWhormHole [

	collectionOfCells := OrderedCollection new.

	collectionOfCells add: Cell new.
	collectionOfCells add: Cell new.
	collectionOfCells add: Cell new.
	collectionOfCells add: BlackHoleCell new.
	collectionOfCells add: AtomicBombCell new.
	collectionOfCells add: CardDispenserCell new.
	collectionOfCells add: (HyperGravityCell withValueToMove: 3).
	collectionOfCells add: (MoonWalkCell withValueToMove: 3).
	collectionOfCells add:
		(HyperJumpCell withConversor: aConversor andValues: values).


	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 2
		                 withWormholeCreator: aWormholeCreator.

	board := aBoardCreator createBoard.

	self assert: ((board at: 1) isKindOf: Cell).
	self assert: ((board at: 2) isKindOf: Wormhole).
	self assert: ((board at: 3) isKindOf: Wormhole).
	self assert: ((board at: 4) isKindOf: BlackHoleCell).
	self assert: ((board at: 5) isKindOf: AtomicBombCell).
	self assert: ((board at: 6) isKindOf: CardDispenserCell).
	self assert: ((board at: 7) isKindOf: HyperGravityCell).
	self assert: ((board at: 8) isKindOf: MoonWalkCell).
	self assert: ((board at: 9) isKindOf: HyperJumpCell)
]

{ #category : #'error testing' }
BoardCreatorTest >> test04BoardCreatorRecivesCollectionOfNotCellsThenErrorIsThrown [

	self
		should: [
			| collectionOfNotCells |
			collectionOfNotCells := OrderedCollection new.
			5 timesRepeat: [ collectionOfNotCells add: Spaceship new ].
			aBoardCreator := BoardCreator
				                 with: collectionOfNotCells
				                 ofLaps: 2
				                 withWormholeCreator: aWormholeCreator ]
		raise: Error
		withMessage: 'A board creator must recive a collection of cells'
]

{ #category : #effect }
BoardCreatorTest >> test05BoardWithProbabilitesThenProbabilisticDistrubutionIsRight [

	| probabilities totalCells counts expectedMeans deviations lowerBounds upperBounds |
	"Distribución de probabilidades (en tanto por ciento)"
	probabilities := #( 2 20 10 20 8 5 1 10 24 ).

	"Tamaño total de las celdas generadas (dos menos por el wormhole)"
	totalCells := 98.

	"Calcular media (mu) y desviación estándar (sigma) para cada probabilidad"
	expectedMeans := probabilities collect: [ :prob |
		                 totalCells * prob / 100 ].
	deviations := probabilities collect: [ :prob |
		              | p |
		              p := prob / 100.
		              (totalCells * p * (1 - p)) sqrt ].

	"Calcular límites de confianza (99%)"
	lowerBounds := expectedMeans
		               with: deviations
		               collect: [ :mean :sigma | mean - (2.567 * sigma) ].
	upperBounds := expectedMeans
		               with: deviations
		               collect: [ :mean :sigma | mean + (2.567 * sigma) ].

	"Contar ocurrencias reales de cada tipo de celda"
	counts := OrderedCollection new.
	counts add:
		(board select: [ :cell | cell isKindOf: AtomicBombCell ]) size.
	counts add:
		(board select: [ :cell | cell isKindOf: BlackHoleCell ]) size.
	counts add:
		(board select: [ :cell | cell isKindOf: CardDispenserCell ]) size.
	counts add:
		(board select: [ :cell | cell isKindOf: HyperGravityCell ]) size.
	counts add:
		(board select: [ :cell | cell isKindOf: HyperJumpCell ]) size.
	counts add:
		(board select: [ :cell | cell isKindOf: HyperSpaceJumpCell ]) size.
	counts add: (board select: [ :cell | cell isKindOf: JailCell ]) size.
	counts add:
		(board select: [ :cell | cell isKindOf: MoonWalkCell ]) size.
	counts add: 98 - counts sum.

	"Validar que cada conteo real esté dentro del rango de confianza"
	1 to: probabilities size do: [ :i |
		self assert: ((counts at: i)
				 between: (lowerBounds at: i) rounded
				 and: (upperBounds at: i) rounded) ]
]
