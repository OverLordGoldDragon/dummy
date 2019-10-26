#!/usr/bin/env bash
pycodestyle --max-line-length=89 keras_adamw tests

if [[ "$TF_KERAS" == "True" ]]; then
    TESTPATH="tests/test_optimizers_v2.py";
else
    TESTPATH="tests/test_optimizers.py";
fi

ALLFILES="optimizers.py optimizers_v2.py optimizers_tfpy.py"
ALLFILES+=" optimizers_225.py optimizers_225tf.py"
ALLFILES+=" utils.py utils_225.py example.py"
ALLFILES+="test_optimizers.py test_optimizers_v2.py test_optimizers_tfpy.py"


if [[ "$TF_VERSION" == "1.14.0" ]] && [[ "$KERAS_VERSION" == "2.2.5" ]]; then
    if [[ "$TF_KERAS" == "True" ]]; then
        KEEPFILES="test_optimizers_v2.py optimizers_225tf.py utils_225.py"
    else
        KEEPFILES="test_optimizers.py optimizers_225.py utils_225.py"
	fi
elif [[ "$TF_VERSION" == "2.0.0" ]] && [[ "$KERAS_VERSION" == "2.3.0" ]]; then
    if [[ "$TF_KERAS" == "True" ]]; then
        KEEPFILES="test_optimizers_v2.py optimizers_v2.py utils.py"
	else
	    KEEPFILES="test_optimizers.py optimizers.py utils.py"
	fi
fi

IGNORECOMMAND=()
for FILE in $ALLFILES; do
    if [[ "$KEEPFILES" != *"$FILE"* ]]; then
        IGNORECOMMAND+=(--ignore-files="$FILE")
    fi
done

nosetests \
    --nocapture --with-coverage --cover-erase --cover-html --cover-html-dir=htmlcov \
	"${IGNORECOMMAND[@]}" --cover-package=keras_adamw --with-doctest "$TESTPATH"
