## Phaistos-Mantong Thesis

NaNoGenMo 2021 https://github.com/NaNoGenMo/2021/issues/37 , inspired by https://github.com/NaNoGenMo/2021/issues/29

This project uses the Mantong alphabet of [Richard Shaver](https://en.wikipedia.org/wiki/Richard_Sharpe_Shaver), and the fanciful notion that the symbols of the [Phaistos disc](http://wikipedia.org/wiki/Phaistos_Disc)
could be logographic equivalents (**not** a serious thesis at all -- the Phaistos disc symbols are unlikely to be logographic, but this can't be proven without a full decipherment, and that doesn't stop wild speculation...) to generate a ancient-looking text of 50000 logographic word-symbols when fed an English/ASCII text of at least 50000 characters.


The conceit is that the output is an ancient novel-length text in an undecipered logographic script, which may be interpretable using the 'Mantong alphabet', which supposedly encodes secret ancient meanings in the 26 letters of the modern English alphabet...

The output has an interesting form; more image like than text:

![example disc output](output_00001.svg "Example disc output")

A .png example:

![example disc output in png fromat](https://user-images.githubusercontent.com/905545/140311483-121d2c03-bd53-4f42-9f86-e872bd6e464f.png "Example disc output in .png")

[Aegean](https://dn-works.com/ufas/) is a font (.otf) which contains glyphs for the Unicode Phaistos disc symbols, and other ancient scripts.

The [main script](phaimantconv.sh) is a one line bash pipe which takes a text file as input and splits it out into a collection of Phaistos-glyph discs in SVG format, one side per file, named like `output_00000.svg`.

```
sed 's/\[.*\]//g;s/\W/ /g;s/\s\+/ /g;s/ *$/ /;s/^ //' | tr 'A-Z ' 'a-z|' | sed 's/a/𐇭/g;s/b/𐇱/g;s/c/𐇤/g;s/d/𐇙/g;s/e/𐇚/g;s/f/𐇲/g;s/g/𐇶/g;s/h/𐇐/g;s/i/𐇑/g;s/j/𐇶/g;s/k/𐇨/g;s/l/𐇳/g;s/m/𐇓/g;s/n/𐇔/g;s/o/𐇠/g;s/p/𐇜/g;s/q/𐇦/g;s/r/𐇝/g;s/s/𐇵/g;s/t/𐇛/g;s/u/𐇕/g;s/v/𐇩/g;s/w/𐇞/g;s/x/𐇥/g;s/y/𐇢/g;s/z/𐇼/g' | tr -d '\n' | sed 's/\(.\{137\}[^|]*\)|/⁞\1\n/g;' | split -da5 -l1 --filter 'echo "<svg viewBox=\"0 0 100 100\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\"><path id=\"p\" fill=\"none\" transform=\"scale(1,-1)\" d=\"M50,90 q-40,0 -40,-40 q0,-40 40,-40 q40,0 40,40 q0,40 -27,40 q-7,0 -12,-10 q-30,0 -30,-30 q0,-30 30,-30 q30,0 30,30 q-5,35 -25,25 q-25,-5 -25,-25 q0,-20 20,-20 q20,0 20,20 q0,15 -15,15 q-10,0 -15,-15 q0,-10 10,-10 q10,0 10,10 q0,10 -10,0\"/><use stroke=\"black\" stroke-width=\"0.6\" transform=\"scale(1,-1)\" xlink:href=\"#p\"/><text transform=\"scale(1,-1)\" font-size=\"6pt\"><textPath baseline-shift=\"2pt\" xlink:href=\"#p\">" $(cat -) "</textPath></text></svg>" > $FILE.svg' - output_
```

This pipe command had its origins in the [Mantong expander script](https://github.com/enkiv2/misc/blob/master/mantong-expand.sh) written by [@enkiv2](https://github.com/enkiv2) which was used for the [Mantong Expansion](https://github.com/NaNoGenMo/2021/issues/29) project which inspired this, and introduced me to the work of Richard Shaver. 

[maketex.sh](maketex.sh) is the publishing script which requires Inkscape to convert the `output_` SVGs into PDF, and pdflatex to combine all the files into one book-like PDF with introduction, bibliography, and appendices. Odd numbers of discs have to be padded with a blank .pdf file to have the page pairing layout work. [blank.pdf](blank.pdf) is included for this purpose. I didn't automate this padding. Lazy.

`phaimantconv.sh` can be used to convert any English / ASCII input text into one or more discs. A particular text with some clean up was used to generate the 50K logogram output for NaNoGenMo purposes.


