#   ***************************************************************************
#   My Python Tutorial  ::  numpy
#   ***************************************************************************
#   coding:UTF8
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$


#   === :header
import sys
assert sys.version_info >= (3,9)

#   import.LIB
import LIB_inc as m;  g = m.CLib();   sTc = 'TcNumPy'
g.f_header(sTc)

#   import.numpy
try:
    import numpy as np
except ImportError as e:
    sEc = e.__str__()
    g.f_warning(sEc); g.f__exit(0)      # !CRQ-241209:TryImport.Numpy

#   === :content
'''
    !content:
        •   m:  numpy
'''

#   m:  numpy
g.f_menu("numpy")

a = np.arange(15).reshape(3, 5); g.f_text(a)

#   error
#   s = a.shape(3,5); g.f_text(s)

i = a.ndim; g.f_text("Dim := %d" % i)
assert (i == 2)

i = a.size; g.f_text("size := %d" % i)
assert (i == 15)

i = a.itemsize; g.f_text("Itemsize := %d" % i)
assert (( i == 4 ) or ( i == 8 ))

s = a.dtype.name; g.f_text("type.name := %s" % s)
assert ((s == 'int32') or (s == 'int64'))

s = type(a); g.f_text("type := '%s'" % s)   # "<class 'numpy.ndarray'>
#   assert (s == "<class 'numpy.ndarray'>")

#   === :footer
g.f_footer(sTc)
