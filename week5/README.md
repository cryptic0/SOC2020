---
title: Professional quality typesetting with LaTeX
author: Vikram Chhatre
date: June 24, 2020
---

## Professional Quality Typesetting with LaTeX

This week we will visit another publishing standard - [LaTeX2e](https://latex-project.org). You may have heard of it or not, you may have been intimidated by it or not. LaTeX is a typesetting engine which can help you write professional quality document which look like they just came from an actual typesetting press.  Yes, the one that prints ink on paper using metal casts.

We understand that this way of writing documents is not for everyone.  We just want to give you an introduction and then you can decide for yourself if it's worth to you.



## How to prepare for this session?


- Install [MacTex2020](https://tug.org/mactex/mactex-download.html) or [MiKTeX for Windows](https://miktex.org)

- Install [TeXMaker](https://www.xm1math.net/texmaker/) for your OS

- Get a free account on [OVERLEAF](https://overleaf.com)

- If this will be your first time attending SOC2020, get a free [GitHub account](https://github.com)



## Highlights from the session

In this session, we learned following items:

- What is LaTeX and analogy to the R environment package system

- Structure of the main ``.tex`` document: 

	- Preamble where you declare document types, various necessary packages and their respective options

	- Body of the document

	- Math equations and symbols

	- Inserting citations 

	- Table of contents, List of figures

- Structure of the bibliography document i.e. ``.bib``

	- Google scholar provides BibTeX style citation entries

	- Bibliography key and how to use it when citing a paper

- Compiling a ``.tex`` document

	- Run ``pdflatex`` once
	- Run ``bibtex`` once
	- Run ``pdflatex`` 2x more
	- **OR**
	- Write these commands inside a simple shell script and execute it instead.

- We structured the main document ``kimura.tex`` and compiled it to produce the pdf ``kimura.pdf``.

- How to upload your project to your overleaf account 

- How to push changes to GitHub directly from your overleaf account

- Finally, how to use TeXMaker, the GUI client for TeX.




## Further reading

If you are curious about the development of LaTeX, here are some important people who were seminal in its develpment and some associated articles:

- [Leslie Lamport](https://en.wikipedia.org/wiki/Leslie_Lamport) and [his book](https://www.amazon.com/LaTeX-Document-Preparation-System-2nd/dp/0201529831)

- Donald Knuth's profile in New York Times: [The Yoda of Silicon Valley](https://www.nytimes.com/2018/12/17/science/donald-knuth-computers-algorithms-programming.html) 

- <span style="color:blue">One of the beginner's guide to LaTeX that has been around for over 25 years is still an extremely useful first book (free of course):</span>
	
	- [The Not So Short Introduction to LaTeX by Oetiker, Partl, Hyna and Schlegl](https://tobi.oetiker.ch/lshort/lshort.pdf).  **I highly recommend it**.
