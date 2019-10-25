#!/usr/bin/env bash
pycodestyle --max-line-length=89 keras_adamw tests

if [[ "$TF_KERAS" == "True" ]]; then
    TESTPATH="tests/test_optimizers_v2.py";
else
    TESTPATH="tests/test_optimizers.py";
fi

if [[ "$TF_VERSION"=="1.14.0" ]] && [[ "$KERAS_VERSION"=="2.2.5" ]]; then
	ignorefiles = ["optimizers.py", "optimizers_225tf.py", "utils.py", "test_optimizers_v2.py"]
elif [[ "$TF_VERSION"=="1.14.0" ]] && [[ "$KERAS_VERSION"=="2.2.5" ]] && [[ "$TF_KERAS"=="True" ]]; then
	ignorefiles = ["optimizers.py", "optimizers_225.py", "utils.py", "test_optimizers.py"]
elif [[ "$TF_VERSION"=="2.0.0" ]] && [[ "$KERAS_VERSION"=="2.3.0" ]] && [[ "$TF_KERAS"=="False" ]] && [[ "TF_EAGER"=="True" ]]; then
	ignorefiles = ["optimizers_v2.py", "optimizers_225.py", "optimizers_225tf.py", "utils_225.py", "test_optimizers_v2.py"]
elif [[ "$TF_VERSION"=="2.0.0" ]] && [[ "$KERAS_VERSION"=="2.3.0" ]] && [[ "$TF_KERAS"=="False" ]] && [[ "TF_EAGER"=="False" ]]; then
	ignorefiles = ["optimizers_v2.py", "optimizers_225.py", "optimizers_225tf.py", "utils_225.py", "test_optimizers_v2.py"]
elif [[ "$TF_VERSION"=="2.0.0" ]] && [[ "$KERAS_VERSION"=="2.3.0" ]] && [[ "$TF_KERAS"=="True" ]] && [[ "$TF_EAGER"=="True" ]]; then
	ignorefiles = ["optimizers.py", "optimizers_225.py", "optimizers_225tf.py", "utils_225.py", "test_optimizers.py"]
elif [[ "$TF_VERSION"=="2.0.0" ]] && [[ "$KERAS_VERSION"=="2.3.0" ]] && [[ "$TF_KERAS"=="True" ]] && [[ "$TF_EAGER"=="False" ]]; then
	ignorefiles = ["optimizers.py", "optimizers_225.py", "optimizers_225tf.py", "utils_225.py", "test_optimizers.py"]
fi

ignorefiles = ignorefiles + ["example.py", "optimizers_tfpy.py"]

IGNORECOMMAND = ''
for ignorefile in ignorefiles:
    IGNORECOMMAND += ' --ignore-files=' + ignorefile

nosetests \
    --nocapture --with-coverage --cover-erase --cover-html --cover-html-dir=htmlcov \
	"$IGNORECOMMAND" --cover-package=keras_adamw --with-doctest "$TESTPATH"
