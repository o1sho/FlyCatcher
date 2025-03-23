extends CanvasLayer

@onready var transition_mask: ColorRect = $TransitionMask

func start_transition() -> void:
	transition_mask.start_transition()
