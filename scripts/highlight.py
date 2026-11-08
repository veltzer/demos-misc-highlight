#!/usr/bin/env python

""" Render one source file to one highlight format with pygmentize, mirroring
the Makefile: svg, jpg, html (-O full), png or rtf, each with the shared style
options. The generator invokes this as highlight.py <input> <output>, one
generator instance per format; the output's extension names the format. """

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
    source, target = sys.argv[1], sys.argv[2]
    fmt = os.path.splitext(target)[1][1:]
    if fmt not in FORMATS:
        sys.exit(f"{target}: unknown format [{fmt}], expected one of {list(FORMATS)}")
    cmd = ["pygmentize", "-f", fmt] + FORMATS[fmt] + OPTS + ["-o", target, source]
    sys.exit(subprocess.call(cmd))


if __name__ == "__main__":
    main()
