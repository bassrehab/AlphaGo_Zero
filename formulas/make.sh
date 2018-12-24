#!/bin/bash

set -x
[ -d agz.tex ] && continue
mkdir agz
#    [ -d agz.tex ] || mkdir agz.tex
# create full doc
pdflatex -jobname=agz/agz.tex agz.tex
pdflatex "\def\ispreview{1} \input{agz.tex}"

# create EPS files
pages=`pdfinfo agz.pdf | grep Pages | sed 's/  */ /g' | cut -d ' ' -f 2-`
for page in `seq $pages`; do
    pdftops -f $page -l $page -eps agz.pdf agz/agz-`printf '%03d' $page`.eps
done

# create images
#    convert -density 300 agz.tex.pdf -quality 90 agz.tex/agz.tex.png
rm agz.tex/*.{aux,log}
done

./clean.sh
