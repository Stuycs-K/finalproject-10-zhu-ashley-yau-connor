run:
	processing-java --sketch=font_work --run --ARGS=$(ARGS)
	processing-java --sketch=final_project --run --ARGS=$(ARGS)
instructions:
	cat README.md
