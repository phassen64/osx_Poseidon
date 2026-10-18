#   ***************************************************************************
#   My Python Tutorial  ::  runTime meassurement [V3.10]
#   ***************************************************************************

#   coding:UTF8
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

import sys

assert sys.version_info >= (3,10)
import random
import time
from collections.abc import Callable
from functools import wraps
from timeit import Timer
from typing import Any

#   === :header
from y52_timing_m1 import CVector2D
import LIB_inc as m;  g = m.CLib();   sTc = 'TcTimingV310'
g.f_header(sTc)


def F_decorator_timing(fn: Callable) -> Callable:
    @wraps(fn)
    def timer(*args: Any, **kwargs: Any) -> Any:
        start_time = time.perf_counter()
        fn_result = fn(*args, **kwargs)
        end_time = time.perf_counter()
        time_duration = end_time - start_time
        g.f_text(f"Function {fn.__name__} took {time_duration:.6f}s")
        return fn_result
    return timer
#   --- eof

@F_decorator_timing
def F_test_addition_own_implementation() -> None:
    g.f_menu("run:FTestAddion")
    for _ in range(100_000):
        v1 = CVector2D(
                random.randint(-10, 10),
                random.randint(-10, 10))
        v2 = CVector2D(
                random.randint(-10, 10),
                random.randint(-10, 10))
        r = v1 + v2  # noqa


def F_test_addition_standard_lib() -> None:
    g.f_menu("run:FAddStdLib")

    sImport = """
import random
from y52_timing_m1 import CVector2D
"""
    sCode   = """
v1 = CVector2D(random.randint(-10, 10), random.randint(-10, 10))
v2 = CVector2D(random.randint(-10, 10), random.randint(-10, 10))
r = v1 + v2  # noqa
"""
    timer = Timer(sCode, setup=sImport)
    iRunMax = 10
    mean_time = sum(timer.repeat(repeat=iRunMax, number=100_000)) / iRunMax
    g.f_text(f"Mean computation time: {mean_time:.6f}s")


def F_do_timing() -> None:
    s = CVector2D.__init__.__doc__
    s = g.f_sTrim(s,True); g.f_text("doc.__init__ := <%s>" % s)
    s = CVector2D.__repr__.__doc__
    s = g.f_sTrim(s,True); g.f_text("doc.__repr__ := <%s>" % s)
    s = CVector2D.__str__.__doc__
    s = g.f_sTrim(s,True); g.f_text("doc.__str__ := <%s>" % s)
    F_test_addition_own_implementation()
    F_test_addition_standard_lib()


if __name__ == "__main__":
    F_do_timing()

#   === :footer
g.f_footer(sTc)
