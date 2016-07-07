#!/bin/bash
set -e

function remove_if_exists_else_fail {
  if [[ -e "$1" ]]; then
    rm -f "$1"
  else
    exit 1
  fi
}

cd $(dirname $0)
docker build -t geometalab/pandoc:latest .

# make some simple tests
output_file='README.pdf'

docker run --rm -it -v "$(pwd):/pandoc" geometalab/pandoc bash -c "pandoc -t html5 README.md | wkhtmltopdf - ${output_file}"
remove_if_exists_else_fail ${output_file}

docker run --rm -it -v "$(pwd):/pandoc" geometalab/pandoc pandoc -o ${output_file} README.md
remove_if_exists_else_fail ${output_file}

output_file='README.html'
docker run --rm -it -v "$(pwd):/pandoc" geometalab/pandoc pandoc -o ${output_file} README.md
remove_if_exists_else_fail ${output_file}

# push the newly create image
docker push geometalab/pandoc:latest
