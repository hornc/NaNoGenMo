#!/bin/bash

# Convert all .svg to .pdf using Inkscape
inkscape --export-type="pdf" output_*.svg

# Combines all individual output_*.pdf discs into one .tex document
cat << EOF > phaistos-mantong.tex
\let\mypdfximage\pdfximage
\def\pdfximage{\immediate\mypdfximage}
\documentclass{book}
\RequirePackage[a4paper, margin=3cm]{geometry}
\usepackage{pdfpages}
\usepackage{fancyhdr}
\pdfsuppresswarningpagegroup=1
\begin{document}
\renewcommand{\headrulewidth}{0pt}
\fancyhead[CO]{PHAISTOS-MANTONG DISCS}
\fancyfoot[CO]{\thepage}
$(while read a && read b; do echo "\includepdfmerge[pagecommand={\thispagestyle{fancy}Disc \thepage.\\\\\hspace*{6em}Side A\vspace{120mm}\\\\\hspace*{6em}Side B},scale=0.9,delta=0 -20mm,nup=1x2]{$a, $b}"; done < <(ls output_*.pdf))
\end{document}
EOF

# Convert .tex to single pdf
pdflatex phaistos-mantong.tex
