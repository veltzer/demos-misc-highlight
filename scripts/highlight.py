#!/usr/bin/env python

""" Render one source file to all highlight formats with pygmentize, mirroring
the Makefile: svg, jpg, html (-O full), png and rtf, each with the shared style
options. The generator invokes this as highlight.py <input> <output>, where
<output> carries one nominal extension; the five real products are written
alongside it, one per format. """

import os
import subprocess
import sys

OPTS = [
    "-O",
    "fontface=Fira Code,fontsize=50,line_numbers=False,style=monokai,bg=#000000",
]

# output format -> extra pygmentize args
FORMATS = {
    "svg": [],
    "jpg": [],
    "html": ["-O", "full"],
    "png": [],
    "rtf": [],
}


def main():
    """ main entry point """
    source, nominal = sys.argv[1], sys.argv[2]
    stem = os.path.splitext(nominal)[0]
    for fmt, extra in FORMATS.items():
        target = stem + "." + fmt
        cmd = ["pygmentize", "-f", fmt] + extra + OPTS + ["-o", target, source]
        ret = subprocess.call(cmd)
        if ret != 0:
            sys.exit(ret)


if __name__ == "__main__":
    main()
