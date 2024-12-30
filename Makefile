compile:
	mkdir -p ./output/
	cp style.css ./output/style.css
	pandoc user-manual.md -s -c style.css --toc -o ./output/index.html
	pandoc user-manual.md --template=template.tex --pdf-engine=xelatex --toc -o ./output/user-manual.pdf
	pandoc user-manual.md --toc -o ./output/user-manual.docx
	pandoc user-manual.md --toc -o ./output/user-manual.odt

clean:
	rm ./output/*
