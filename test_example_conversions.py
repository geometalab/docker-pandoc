#!/usr/bin/env python
import os
import subprocess

def _test_pandoc(result_file, command, *, expected_file_size, size_deviation=0):
    try:
        assert not os.path.exists(result_file)
        command = command.format(result_file)
        subprocess.check_call(command, shell=True)
        actual_file_size = os.path.getsize(result_file)
        assert os.path.exists(result_file)
        assert expected_file_size > 200  # should always contain data!
        if size_deviation > 0:
            difference = size_deviation * expected_file_size
            min_size = expected_file_size - difference
            max_size = expected_file_size + difference
            assert min_size < actual_file_size < max_size
        else:
            assert expected_file_size == actual_file_size
    finally:
        try:
            os.remove(result_file)
        except:
            pass

def test_html_generation():
    to_html = 'docker run --rm -v "$(pwd):/pandoc" geometalab/pandoc pandoc -o {} README.md'
    _test_pandoc('README.html', to_html, expected_file_size=1457, size_deviation=0.1)


def test_pdf_generation():
    to_pdf = 'docker run --rm -v "$(pwd):/pandoc" geometalab/pandoc pandoc -o {} README.md'
    _test_pandoc('README.pdf', to_pdf, expected_file_size=106515, size_deviation=0.1)


def test_pdf_generation_using_html5_and_wkhtml():
    to_pdf = 'docker run --rm -v "$(pwd):/pandoc" geometalab/pandoc bash -c "pandoc -t html5 README.md | wkhtmltopdf - {}"'
    _test_pandoc('README.pdf', to_pdf, expected_file_size=20980, size_deviation=0.1)
