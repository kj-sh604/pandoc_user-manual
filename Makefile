compile:
	@echo "'public' and 'output' directories created"
	@echo
	@mkdir -p ./output/ ./public/
	@echo "generating website... => ./public/index.html"
	@cp -R ./static/ ./public/
	pandoc user-manual.md -s -c ./static/style.css --toc -o ./public/index.html
	@echo
	@echo "generating .pdf... => ./output/user-manual.pdf"
	pandoc user-manual.md --template=template.tex --pdf-engine=xelatex --toc -o ./output/user-manual.pdf
	@echo
	@echo "generating .docx... => ./output/user-manual.docx"
	pandoc user-manual.md --toc -o ./output/user-manual.docx
	@echo
	@echo "generating .odt... => ./output/user-manual.odt"
	pandoc user-manual.md --toc -o ./output/user-manual.odt
	@echo

clean:
	@if [ -d "public" ]; then \
		rm -r public/; \
		echo "rm'd the 'public' directory."; \
	else \
		echo "no 'public' directory found, skipping cleanup."; \
	fi
	@if [ -d "output" ]; then \
		rm -r output/; \
		echo "rm'd the 'output' directory."; \
	else \
		echo "no 'output' directory found, skipping cleanup."; \
	fi
