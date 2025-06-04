messageMask: 
processing-java --sketch=font_work --run --ARGS=$(ARGS)
imageMask: 
processing-java --sketch=image_work --run --ARGS=$(ARGS)
encode:
	processing-java --sketch=final_project --run --ARGS=$(ARGS)
instructions:
	cat README.md
