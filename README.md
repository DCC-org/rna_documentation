# documents

## Usage

Hint: You should read the upcoming section first! However, if you want to build
the pdf:

```sh
latexmk
```

yes, this is it. This will trigger all the magic to create a pdf. It will be called documentation.pdf

## Setup

We need a few tools to successfully work with latex:

```bash
sudo pacman -Syu texlive-bin texlive-core make texlive-bibtexextra texlive-bin texlive-core texlive-fontsextra texlive-formatsextra texlive-games texlive-genericextra texlive-htmlxml texlive-humanities texlive-latexextra texlive-music texlive-pictures texlive-plainextra texlive-pstricks texlive-publishers texlive-science biber
```

Also a font package:

```bash
sudo pacman -Syu ttf-inconsolata
```

Python dependencies for colorized text and syntax highlighting:

```bash
sudo pacman -Syu python-pygments python2-pygments pygmentize
```

Last but not least, a tool to convert svg to pdf:

```bash
sudo pacman -Syu inkscape
```

## how to cite

\cite{HorgasAnalyse}
'Hadoop ist sacklahm(siehe benchmarks aus \cite{Horgasanalyse}'

## stuff for the appendix

We have a few files that place content in the appendix section

### figures.tex

this is for all figures (pictures, pdf, svg)

### tables.tex

tables, obvious?

contains all the tables. You find some explanations on how it works [online](https://de.wikibooks.org/wiki/LaTeX-W%C3%B6rterbuch:_tabular)

### listings.tex

source code, text

### Embed svg

this is a bit tricky. embedding a svg, in general, is pretty easy:

```latex
\begin{figure}[tbp]
  \centering
  \includesvg[svgpath=../figures/,path=../figures/,width=1.0\textwidth]{ssduserstory}
  \caption{Wireframe für SSD Userstory}
\label{figure:ssduserstory}
\end{figure}
```

this expects a file at: .../figures/ssduserstory.svg. inkscape will be called to convert it to tex. Also you need:

```latex
\usepackage{svg}
```

somewhere.

Sad news: most of the tools for drawing svg files are totally fucked up.
https://validator.w3.org/ can be used to validate the svg. I've tested draw.io,
yED and gliffy. All of them suck because the svg is broken. How can we fix that?
We can convert the svg to pdf with inkscape and use the pdf in latex (also we
use pdfcrop to pruge useless surrounding whitespace):

```bash
inkscape -A ssduserstory.pdf ssduserstory.svg
pdfcrop ssduserstory.pdf
```

and the corresponding latex code:

```latex
\begin{figure}[tbp]
  \centering
  \includegraphics[width=1.0\textwidth]{../figures/ssduserstory-crop.pdf}
  \caption{Wireframe für SSD Userstory}
\label{figure:ssduserstory}
\end{figure}
```

### Convert a docx to latex

This works well with pandoc:

```sh
pandoc --extract-media media --standalone --output RNA.latex RNA.docx
```

And you maybe need to install it first:

```
sudo pacman -Syu pandoc
```

### Reformat a block

We try to not use more than 80 chars in one line. vim allows you to easily
reformat a block. Enter the visual mode with v, mark the paragraph, press gq.
This requires the following in `~/.vim/ftplugin/tex.vim`:

```vim
setl lbr
set colorcolumn=80
```

### Quote something

That's pretty easy:

```latex
\enquote{stuff we want to quote}
```

Requires csquotes and polyglossia. Language needs to be defined.
