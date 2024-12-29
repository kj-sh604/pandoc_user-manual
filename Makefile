compile:
	pandoc user-manual.md -s -c style.css --toc -o index.html
	pandoc user-manual.md --template=template.tex --pdf-engine=xelatex --toc -o user-manual.pdf

clean:
	rm ./*.pdf
	rm ./*.html
