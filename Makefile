compile:
	mkdir -p ./output/ ./public/
	cp -R ./static/ ./public/
	pandoc user-manual.md -s -c ./static/style.css --toc -o ./public/index.html
	pandoc user-manual.md --template=template.tex --pdf-engine=xelatex --toc -o ./output/user-manual.pdf
	pandoc user-manual.md --toc -o ./output/user-manual.docx
	pandoc user-manual.md --toc -o ./output/user-manual.odt

clean:
	rm ./output/*
	rm -r ./public/*
