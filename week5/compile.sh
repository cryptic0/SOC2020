#!/bin/bash

pdflatex kimura.tex
bibtex kimura
pdflatex kimura.tex
pdflatex kimura.tex
