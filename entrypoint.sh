#!/usr/bin/env bash

set -eou pipefail

CPP_EXTENSION_TESTS="test_cpp_extensions_aot_no_ninja test_cpp_extensions_aot_ninja test_cpp_extensions_jit"
(
    set -x
    python -u run_test.py -v -x ${CPP_EXTENSION_TESTS}
    python -u -c "import torch; import tensorflow"
    python -u -c "import tensorflow; import torch"
    python -u -c "import scipy; import torch"
    python -u -c "import torch; import scipy"
    python -u -c "import torch as th; x = th.autograd.Variable(th.rand(1, 3, 2, 2)); l = th.nn.Upsample(2); print(l(x))"
    python -u run_test.py -v -i ${CPP_EXTENSION_TESTS}
)
