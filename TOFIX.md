# TOFIX

Findings from a code scan on 2026-10-04.

## High

- `scripts/highlight.py:13-16` - the shared options use `fontface=` and `fontsize=`, but pygments' png/jpg image formatter reads `font_name` and `font_size` (`pygments/formatters/img.py:412-413`) and the svg formatter reads `fontfamily`; only the rtf formatter knows `fontface`. So png/jpg silently render in the 14pt default font, which is exactly the "output images look terrible" item in `doc/TODO.txt:1`. Pass per-format options (`font_name`/`font_size` for png/jpg, `fontfamily` for svg) and, since the image formatter raises `FontNotFound` for a missing family, declare the font package (e.g. `fonts-firacode`) under `[dependencies] system` in `rsconstruct.toml`.

## Medium

- `rsconstruct.toml:26-32` / `scripts/highlight.py:32-37` - the generator declares one output (`out/<name>.svg`) but the script writes five (`.svg`, `.jpg`, `.html`, `.png`, `.rtf`); the four undeclared files are not tracked, cached or cleaned by rsconstruct. Declare all outputs (an explicit processor with `output_files`, or one generator per format).
- `tera.templates/.github/dependabot.yml.tera` - never rendered: `rsconstruct.toml` has no `[processor.tera]` and the repo has no `config/personal.lua`/`config/version.lua`, so `.github/dependabot.yml` is a hand-kept copy. Add the standard `[processor.tera]` stanza and the config files it needs.

## Low

- `README.md:7` - lists `cli-highlight` as a tool, but nothing in the repo uses it; add a demo or drop the line. The README is also hand-written rather than generated from the fleet `tera.templates/README.md.tera`.
- `source/ruby.rb:1` - the file starts with `Code:` and uses `<FUNCTION NAME>`-style placeholders throughout, so it is not Ruby (it is Puppet doc boilerplate pasted from a web page); replace it with a real Ruby sample so the highlighter demo shows Ruby lexing.
- `pyproject.toml:13` - `pytest` is a dev dependency but there are no tests and no pytest processor; drop it.
- `rsconstruct.toml:34` - orphan comment about pygments/Pillow with no stanza under it; move it next to the generator or delete it.
