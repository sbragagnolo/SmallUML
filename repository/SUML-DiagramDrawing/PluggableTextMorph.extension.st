Extension { #name : #PluggableTextMorph }

{ #category : #'*SUML-DiagramDrawing' }
PluggableTextMorph >> fit [
	self width: self text asTextMorph width + 20.
	textMorph fit.
	self extent:  textMorph extent + (0 @ 25).

]
