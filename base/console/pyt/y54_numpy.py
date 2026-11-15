#   ***************************************************************************
#   My Python Tutorial  ::  numpy       update:[2026-10-27]
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


g.f_menuS1("numpy.intro")


# Imports NumPy library for numerical operations
import numpy as np 

# Creates a NumPy array
a = np.array([10, 20, 30, 40, 50]) 
g.f_text("np.array =: [%s]" % a)

# Calculates and prints the average (mean)
x = a.mean()
g.f_text("calculated a.mean() =: '%s'" % x)


g.f_menuS1("numpy.arrange")

#   s:  np.arrange
n = 10
a = np.arange(n); 
g.f_text("np.arrange(%d) =: [%s]" % (n,a) )

#   s:  np.size
i = a.size; g.f_text("a.size := %d" % i)
assert (i == 10)

#   s:  np.itemsize
i = a.itemsize; g.f_text("a.ItemSize := %d" % i)
assert (( i == 4 ) or ( i == 8 ))

#   s:  np.dtype
s = a.dtype.name; g.f_text("a.dType.Name := %s" % s)
assert ((s == 'int32') or (s == 'int64'))

#   s:  np.nDim
x = a.ndim
g.f_text("a.ndim := %d" % x)
assert (x == 1)

#   s:  type(a)
s = type(a)
g.f_text("type := '%s'" % s)   # "<class 'numpy.ndarray'>
#   assert (s == "<class 'numpy.ndarray'>")


#   s:  np.arange(n).reshape(i,j);
n = 10
i = 2   #   number of dimensions 
j = 5   #   elements for each one = 10/2
x = np.arange(n).reshape(i,j); 
g.f_text("np.arrange(%d).reshape(%d,%d):= %s" % (n,i,j,x))



#   === :footer
g.f_footer(sTc)
