#!/usr/bin/env bash
pycodestyle --max-line-length=89 keras_adamw tests

if [[ "$TF_KERAS" == "True" ]]; then
    TESTPATH="tests/test_optimizers_v2.py";
else
	TESTPATH="tests/test_optimizers.py";
fi

nosetests \
    --nocapture --with-coverage --cover-erase --cover-html --cover-html-dir=htmlcov \
	--ignore-files="example.py", "tests/test_optimizers_tfpy.py" --cover-package=keras_adamw --with-doctest "$TESTPATH"
