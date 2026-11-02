#   ***************************************************************************
#   My Python Tutorial  ::  numba
#   ***************************************************************************
#   coding:UTF8
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$


#   === :header
import sys
assert sys.version_info >= (3,9)

#   import.LIB
import LIB_inc as m;  g = m.CLib();   sTc = 'TcNumba'
g.f_header(sTc)

#   import.numpy needed
try:
    import numpy as np
except ImportError as e:    #    e.__str__()
    sEc = e.__str__()
    g.f_warning(sEc); g.f__exit(0)      # !CRQ-241209:TryImport.Numpy

#   import numba
try:
    import numba as gNumba
    from   numba import jit
except ImportError as e:    #   e.__str__()
    sEc = e.__str__()
    g.f_warning(sEc); g.f__exit(0)      # !CRQ-241209:TryImport.Numba

#   === :content
'''
    !content:
        •   m:  numba
'''

#   m:  numba
g.f_menu("numba")

s = gNumba.__version__
g.f_text("numba.version: '%s'" % s)

#   https://notebooks.gesis.org/binder/jupyter/user/numba-numba-examples-7ngno1kq/notebooks/notebooks/basics.ipynb

@jit(nopython=True)
def go_fast(a):     # Function is compiled when called the first time
    trace = 0.0
    # assuming square input matrix
    for i in range(a.shape[0]):     # Numba likes loops
        trace += np.tanh(a[i, i])   # Numba likes NumPy functions
    return a + trace

#   using numby
x = np.arange(100).reshape(10, 10)
go_fast(x)

#   call again
go_fast(2 * x)

#   === :footer
g.f_footer(sTc)
