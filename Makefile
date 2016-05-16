include LaTeX.mk

printable:
	pdfnup --paper a4paper --no-landscape --nup 2x4 --frame true --offset '0cm 0cm' --delta '0.5mm 0.5mm' --scale 0.965 --suffix 8 packaging-tutorial.pdf
	pdfnup --paper a4paper --landscape --nup 2x2 --frame true --offset '0cm 0cm' --delta '1mm 1mm' --scale 0.96 --suffix 4 packaging-tutorial.pdf
