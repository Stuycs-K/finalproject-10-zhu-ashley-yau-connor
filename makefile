PATH=\"Program Files"\processing-3.5.4-windows64\processing-3.5.4\processing-java.exe 
FONT="C:\Users\conno\Cyber\finalproject-10-zhu-ashley-yau-connor\font_work\font"
messageMask: 
	$(PATH) --sketch=$(FONT) --run $(ARGS)
imageMask: 
	\"Program Files"\processing-3.5.4-windows64\processing-3.5.4\processing-java.exe --sketch="C:\Users\conno\Cyber\finalproject-10-zhu-ashley-yau-connor\image_work" --run --ARGS=$(ARGS)
encode:
	\"Program Files"\processing-3.5.4-windows64\processing-3.5.4\processing-java.exe --sketch="C:\Users\conno\Cyber\finalproject-10-zhu-ashley-yau-connor\final_project" --run --ARGS=$(ARGS)
instructions:
	cat README.md
