#!/usr/bin/env sh

# checks
if ! command -v pandoc > /dev/null 2>&1; then
  echo "error: pandoc is not installed. please install it before running this script."
  exit 0
fi

if [ ! -f "user-manual.md" ]; then
  echo "error: user-manual.md not found."
  exit 0
fi

if [ ! -d "static" ]; then
  echo "error: static directory not found."
  exit 0
fi

if [ ! -f "template.tex" ]; then
  echo "error: template.tex not found."
  exit 0
fi

echo "'public' and 'output' directories created"
echo
mkdir -p ./output/ ./public/
echo "generating website... => ./public/index.html"
cp -R ./static/ ./public/
pandoc user-manual.md -s -c ./static/style.css --toc -o ./public/index.html
echo
echo "generating .pdf... => ./output/user-manual.pdf"
pandoc user-manual.md --template=template.tex --pdf-engine=xelatex --toc -o ./output/user-manual.pdf
echo
echo "generating .docx... => ./output/user-manual.docx"
pandoc user-manual.md --toc -o ./output/user-manual.docx
echo
echo "generating .odt... => ./output/user-manual.odt"
pandoc user-manual.md --toc -o ./output/user-manual.odt
echo
