#!/usr/bin/env sh

# declare PATHs relative to root of the repo
HTML_PATH=./public/index.html
PDF_PATH=./output/user-manual.pdf
DOCX_PATH=./output/user-manual.docx
ODT_PATH=./output/user-manual.odt


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
mkdir -p ./output/ ./public/
echo "generating website... => $HTML_PATH"
cp -R ./static/ ./public/
pandoc user-manual.md -s -c ./static/style.css --toc -o $HTML_PATH || { echo 'error generating index.html'; exit 0;}
echo "generating .pdf... => $PDF_PATH"
pandoc user-manual.md --template=template.tex --pdf-engine=xelatex --toc -o $PDF_PATH || { echo 'error generating .pdf'; exit 0;}
echo "generating .docx... => $DOCX_PATH"
pandoc user-manual.md -o $DOCX_PATH || { echo 'error generating .docx'; exit 0;}
echo "generating .odt... => $ODT_PATH"
pandoc user-manual.md -o $ODT_PATH || { echo 'error generating .odt'; exit 0;}
