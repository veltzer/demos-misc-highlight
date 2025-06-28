""" python deps for this project """

install_requires: list[str] = [
    "pillow",
]
build_requires: list[str] = [
    "pymakehelper",
    "pydmt",
    "pyclassifiers",
]
requires = install_requires + build_requires
