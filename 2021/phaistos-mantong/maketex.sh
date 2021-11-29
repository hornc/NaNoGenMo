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
\usepackage{listings}
\lstset{
basicstyle=\small\ttfamily,
columns=flexible,
breaklines=true
}
\pdfsuppresswarningpagegroup=1
\title{The Phaistos-Mantong Discs: A Logographic Novel in an Ancient Undeciphered Language}
\begin{document}
\renewcommand{\headrulewidth}{0pt}
\fancyhf{}
\maketitle
\frontmatter
\section{Preface}
Presented here, for the first time, without further comment, are these ancient discs.
\mainmatter
\fancyhead[CO]{PHAISTOS-MANTONG DISCS}
\fancyfoot[CO]{\thepage}
$(while read a && read b; do echo "\includepdfmerge[pagecommand={\thispagestyle{fancy}Disc \thepage.\\\\\hspace*{6em}Side A\vspace{120mm}\\\\\hspace*{6em}Side B},scale=0.9,delta=0 -20mm,nup=1x2]{$a, $b}"; done < <(ls output_*.pdf))

\begin{thebibliography}{100}
  \bibitem{E2}enkiv2, \emph{Mantong Expansion}, NaNoGenMo 2021, accessed November 2021, \\\\
     $\langle$ https://github.com/NaNoGenMo/2021/issues/29 $\rangle$
  \bibitem{RS}Shaver, Richard Sharpe, \`\`I Remember Lemuria'' \emph{Amazing Stories}, March 1945.
  \bibitem{FS}Stawell, F.M., \emph{A clue to the Cretan scripts}, G. Bell and sons, ltd., London, 1931.
\end{thebibliography}
\section{Appendix A}
\section{Appendix B}
\scriptsize{\textbf{Source:} $\langle$ https://github.com/hornc/NaNoGenMo/blob/master/2021/phaistos-mantong/phaimantconv.sh $\rangle$}
\lstinputlisting[language=Bash]{phaimantconv.sh}

\end{document}
EOF

# Convert .tex to single pdf
pdflatex phaistos-mantong.tex
