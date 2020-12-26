SOURCES=source/puppet.pp
# SOURCES=puppet.pp user.rb
OPTS=-O "fontface=Fira Code,fontsize=50,line_numbers=False,style=monokai,bg=\#000000"
# OPTS=

OUT_SVG=$(addprefix out,$(addsuffix .svg, $(basename $(SOURCES))))
OUT_JPG=$(addprefix out,$(addsuffix .jpg, $(basename $(SOURCES))))
OUT_CONVERT_JPG=$(addsuffix _convert.jpg, $(basename $(SOURCES))))
OUT_HTM=$(addprefix out,$(addsuffix .htm, $(basename $(SOURCES))))
OUT_PNG=$(addprefix out,$(addsuffix .png, $(basename $(SOURCES))))
OUT_CONVERT_PNG=$(addprefix out,$(addsuffix _convert.png, $(basename $(SOURCES))))
OUT_RTF=$(addprefix out,$(addsuffix .rtf, $(basename $(SOURCES))))


ALL:=
ALL+=$(OUT_SVG)
ALL+=$(OUT_JPG)
ALL+=$(OUT_CONVERT_JPG)
ALL+=$(OUT_HTM)
ALL+=$(OUT_PNG)
ALL+=$(OUT_CONVERT_PNG)
ALL+=$(OUT_RTF)

.PHONY: all
all: $(ALL)

#$(OUT_SVG): %.svg: %.rb Makefile
#	pygmentize -f svg $(OPTS) -o $@ $<
#$(OUT_JPG): %.jpg: %.rb Makefile
#	pygmentize -f jpg $(OPTS) -o $@ $<
#$(OUT_HTM): %.htm: %.rb Makefile
#	pygmentize -f html $(OPTS) -o $@ $<
#$(OUT_PNG): %.png: %.rb Makefile
#	pygmentize -f png $(OPTS) -o $@ $<
#$(OUT_RTF): %.rtf: %.rb Makefile
#	pygmentize -f rtf $(OPTS) -o $@ $<

$(OUT_SVG): %.svg: %.pp Makefile
	pygmentize -f svg $(OPTS) -o $@ $<
$(OUT_JPG): %.jpg: %.pp Makefile
	pygmentize -f jpg $(OPTS) -o $@ $<
$(OUT_CONVERT_JPG): %_convert.jpg: %.htm Makefile
	wkhtmltoimage --quality 100 $< $@
$(OUT_HTM): %.htm: %.pp Makefile
	pygmentize -f html -O full $(OPTS) -o $@ $<
$(OUT_PNG): %.png: %.pp Makefile
	pygmentize -f png $(OPTS) -o $@ $<
$(OUT_CONVERT_PNG): %_convert.png: %.htm Makefile
	wkhtmltoimage --quality 100 $< $@
$(OUT_RTF): %.rtf: %.pp Makefile
	pygmentize -f rtf $(OPTS) -o $@ $<

.PHONY: debug
debug:
	$(info SOURCES is $(SOURCES))
	$(info OUT_SVG is $(OUT_SVG))
	$(info OUT_JPG is $(OUT_JPG))
	$(info OUT_CONVERT_JPG is $(OUT_CONVERT_JPG))
	$(info OUT_HTM is $(OUT_HTM))
	$(info OUT_PNG is $(OUT_PNG))
	$(info OUT_RTF is $(OUT_RTF))
	$(info ALL is $(ALL))
