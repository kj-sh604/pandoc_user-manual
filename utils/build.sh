#!/usr/bin/env sh

# declare PATHs relative to the root of the repo
MARKDOWN_PATH=./user-manual.md
HTML_PATH=./public/index.html
PDF_PATH=./output/user-manual.pdf
DOCX_PATH=./output/user-manual.docx
ODT_PATH=./output/user-manual.odt


# checks
if [ "$(uname)" = "Darwin" ]; then
  eval "$(/usr/libexec/path_helper)"
fi

if ! command -v pandoc > /dev/null 2>&1; then
  echo "error: pandoc is not installed. please install it before running this script."
  exit 0
fi

if [ ! -f "$MARKDOWN_PATH" ]; then
  echo "error: $MARKDOWN_PATH not found."
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

# create necessary directories
echo "'public' and 'output' directories created"
mkdir -p ./output/ ./public/

# generate website
echo "generating website... => $HTML_PATH"
cp -R ./static/ ./public/
pandoc $MARKDOWN_PATH -s -c ./static/style.css --toc -o $HTML_PATH || echo 'error generating index.html'

# generate .pdf
if command -v lualatex > /dev/null 2>&1; then
  PDF_ENGINE="lualatex"
elif command -v xelatex > /dev/null 2>&1; then
  PDF_ENGINE="xelatex"
  echo "[WARNING]: using xelatex - emojis may not render correctly"
elif command -v pdflatex > /dev/null 2>&1; then
  PDF_ENGINE="pdflatex"
  echo "[WARNING]: using pdflatex - converting markdown to ASCII"
  cat $MARKDOWN_PATH | iconv -c -t ASCII//TRANSLIT > tmp.md
  MARKDOWN_PATH=./tmp.md
else
  echo "no suitable LaTeX engine found. PDF creation will be skipped."
fi

if [ -n "$PDF_ENGINE" ]; then
  echo "generating .pdf... => $PDF_PATH (--pdf-engine=$PDF_ENGINE)"
  pandoc $MARKDOWN_PATH --template=template.tex --pdf-engine="$PDF_ENGINE" --toc -o $PDF_PATH || echo 'error generating .pdf'
fi

# generate other formats
echo "generating .docx... => $DOCX_PATH"
pandoc $MARKDOWN_PATH -o $DOCX_PATH || echo 'error generating .docx'
echo "generating .odt... => $ODT_PATH"
pandoc $MARKDOWN_PATH -o $ODT_PATH || echo 'error generating .odt'

# clean-up if using pdflatex
if [ $MARKDOWN_PATH = "./tmp.md" ]; then
    rm ./tmp.md
fi
