#!/usr/bin/env bash
pycodestyle --max-line-length=89 keras_adamw tests

if [[ "$TF_VERSION" == "2.0.0" ]]; then
    TESTPATH="tests/test_optimizers_v2.py";
elif [[ "$TF_VERSION" == "1.14.0" ]]; then
    TESTPATH="tests/test_optimizers.py";
fi

nosetests \
    --nocapture --with-coverage --cover-erase --cover-html --cover-html-dir=htmlcov --ignore-files="example.py" \
    --cover-package=keras_adamw --with-doctest "$TESTPATH"
