# docker-pandoc

pandoc docker image with latex support for pdf generation

## Usage

Example usage:

### Converting to HTML

`docker run --rm -it -v "$(pwd):/pandoc" geometalab/pandoc pandoc -o README.html README.md`

### to pdf

Converting to pdf can be achieved in two ways, through use of latex,
and through use of wkhtmltopdf.

#### using latex (default)

`docker run --rm -it -v "$(pwd):/pandoc" geometalab/pandoc pandoc -o README.pdf README.md`

#### using wkhtmltopdf

Also see issue in pandoc: https://github.com/jgm/pandoc/issues/1793.

`docker run --rm -it -v "$(pwd):/pandoc" geometalab/pandoc bash -c "pandoc -t html5 README.md | wkhtmltopdf - README.pdf"`

### getting inside the container

`docker run --rm -it -v "$(pwd):/pandoc" --entrypoint="/bin/bash" geometalab/pandoc`

## Development

### Prerequisites

Python3 with pytest installed.

### Testing

`pytest`

### Building and pushing

This uses the pytest above to verify the image is working.

`./build_and_push.sh`
