##############
# PARAMETERS #
##############
# do you want to see the commands executed ?
DO_MKDBG:=0
# do you want dependency on the Makefile itself ?
DO_ALLDEP:=1

########
# CODE #
########
# silent stuff
ifeq ($(DO_MKDBG),1)
Q:=
# we are not silent in this branch
else # DO_MKDBG
Q:=@
#.SILENT:
endif # DO_MKDBG

# dependency on the makefile itself
ifeq ($(DO_ALLDEP),1)
.EXTRA_PREREQS+=$(foreach mk, ${MAKEFILE_LIST},$(abspath ${mk}))
endif # DO_ALLDEP

OUT_DIR:=out
SOURCES=$(shell find source -type f)
OPTS=-O "fontface=Fira Code,fontsize=50,line_numbers=False,style=monokai,bg=\#000000"
WK_OPTIONS=--quiet --quality 100 --width 2048 --zoom 3 --minimum-font-size 50
# WK_OPTIONS=--zoom 20.5 --minimum-font-size 32 --disable-smart-width

BASE_SVG=$(addsuffix .svg, $(SOURCES))
BASE_JPG=$(addsuffix .jpg, $(SOURCES))
BASE_HTM=$(addsuffix .htm, $(SOURCES))
BASE_PNG=$(addsuffix .png, $(SOURCES))
BASE_RTF=$(addsuffix .rtf, $(SOURCES))

OUT_SVG=$(addprefix out/,$(BASE_SVG))
OUT_JPG=$(addprefix out/,$(BASE_JPG))
OUT_HTM=$(addprefix out/,$(BASE_HTM))
OUT_PNG=$(addprefix out/,$(BASE_PNG))
OUT_RTF=$(addprefix out/,$(BASE_RTF))

OUT_CONVERT_JPG=$(addprefix out/htm2jpg/,$(addsuffix .jpg, $(BASE_HTM)))
OUT_CONVERT_PNG=$(addprefix out/htm2png/,$(addsuffix .png, $(BASE_HTM)))


ALL:=
ALL+=$(OUT_SVG)
ALL+=$(OUT_JPG)
ALL+=$(OUT_HTM)
ALL+=$(OUT_PNG)
ALL+=$(OUT_RTF)
ALL+=$(OUT_CONVERT_JPG)
ALL+=$(OUT_CONVERT_PNG)

.PHONY: all
all: $(ALL)
	@true

$(OUT_SVG): out/%.svg: %
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)pygmentize -f svg $(OPTS) -o $@ $<
$(OUT_JPG): out/%.jpg: %
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)pygmentize -f jpg $(OPTS) -o $@ $<
$(OUT_HTM): out/%.htm: %
	$(Q)mkdir -p $(dir $@)
	$(info doing [$@])
	$(Q)pygmentize -f html -O full $(OPTS) -o $@ $<
$(OUT_PNG): out/%.png: %
	$(Q)mkdir -p $(dir $@)
	$(info doing [$@])
	$(Q)pygmentize -f png $(OPTS) -o $@ $<
$(OUT_RTF): out/%.rtf: %
	$(Q)mkdir -p $(dir $@)
	$(info doing [$@])
	$(Q)pygmentize -f rtf $(OPTS) -o $@ $<

$(OUT_CONVERT_JPG): out/htm2jpg/%.jpg: out/%
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)wkhtmltoimage $(WK_OPTIONS) $< $@
$(OUT_CONVERT_PNG): out/htm2png/%.png: out/%
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)wkhtmltoimage $(WK_OPTIONS) $< $@

.PHONY: debug
debug:
	$(info SOURCES is $(SOURCES))
	$(info BASE_SVG is $(BASE_SVG))
	$(info BASE_JPG is $(BASE_JPG))
	$(info BASE_HTM is $(BASE_HTM))
	$(info BASE_PNG is $(BASE_PNG))
	$(info BASE_RTF is $(BASE_RTF))
	$(info OUT_SVG is $(OUT_SVG))
	$(info OUT_JPG is $(OUT_JPG))
	$(info OUT_HTM is $(OUT_HTM))
	$(info OUT_PNG is $(OUT_PNG))
	$(info OUT_RTF is $(OUT_RTF))
	$(info OUT_CONVERT_JPG is $(OUT_CONVERT_JPG))
	$(info OUT_CONVERT_PNG is $(OUT_CONVERT_PNG))
	$(info ALL is $(ALL))

.PHONY: clean_hard
clean_hard:
	$(info doing [$@])
	$(Q)git clean -qffxd

.PHONY: results
results:
	$(info doing [$@])
	$(Q)geeqie
