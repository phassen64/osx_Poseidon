#   ***************************************************************************
#   My Python Tutorial  ::  vector2D
#   ***************************************************************************
#   !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ

#   === :header
from __future__ import annotations          # CVector2D|float
import numbers          # numbers.Real = int && float 5|5.0
from math import sqrt   # sqrt()
import LIB_inc as m;    g = m.CLib();   sTc = 'tcMemory'
g.f_header(sTc)


#   === :content

'''
    !content
        m:  vector2D
            s:  define
            s:  type
            s:  operation
            s:  exception
            s:  classMethod:power
            s:  property
'''

#   ===========================================================================
#   b:  class
#   ===========================================================================

class CVector2D:

    __sEc_intFloat  = "??? dataType int|float"
    __sEc_real      = "??? dataType real"
    __sEc_object    = "??? noObjectVector"

    def __init__(self, x: float = 0.0, y: float = 0.0) -> None:
        if (not (isinstance(x, numbers.Real) and
                    isinstance(y, numbers.Real))):
            raise TypeError(self.__sEc_intFloat)
            return None
        self.X = x
        self.Y = y
        self.m_iId   = 1234     # g.f_iRandom(1000,1)

    def __call__(self) -> None:
        print("Calling the __call__ method!")

    def __repr__(self) -> str:     # str output
        sCls = self.__class__.__name__
        return f"{sCls}->({self.X},{self.Y})"

    def __str__(self) -> str:      # str typeConversion
        return f"({self.X};{self.Y})"

    def __abs__(self) -> float:
        return sqrt(pow(self.X, 2) + pow(self.Y, 2))

    def __eq__(self, pPartner: object) -> bool:
        if not isinstance(pPartner, CVector2D):
            raise TypeError(self.__sEc_object)
        return self.X == pPartner.X and self.Y == pPartner.Y

    def __lt__(self, pPartner: object) -> bool:
        if not isinstance(pPartner, CVector2D):
            raise TypeError(self.__sEc_object)
        return abs(self) < abs(pPartner)

    def __add__(self, pPartner:CVector2D) -> CVector2D:
        if not isinstance(pPartner, CVector2D):
            raise TypeError(self.__sEc_object)
        x = self.X + pPartner.X
        y = self.Y + pPartner.Y
        return CVector2D(x,y)

    def __sub__(self, pPartner:CVector2D) -> CVector2D:
        if not isinstance(pPartner, CVector2D):
            raise TypeError(self.__sEc_object)
        x = self.X - pPartner.X
        y = self.Y - pPartner.Y
        return CVector2D(x,y)

    def __mul__(self, pPartner:CVector2D) -> CVector2D:
        if not isinstance(pPartner, CVector2D):
            raise TypeError(self.__sEc_object)
        x = self.X * pPartner.X
        y = self.Y * pPartner.Y
        return CVector2D(x,y)

    def __truediv__(self, pPartner:CVector2D) -> CVector2D:
        if not isinstance(pPartner, CVector2D):
            raise TypeError(self.__sEc_object)
        x = self.X / pPartner.X
        y = self.Y / pPartner.Y
        return CVector2D(x,y)

    @classmethod
    def f_power__cm(cls, p1:float, p2:float, pExp:float) -> CVector2D:
        M = cls(p1,p2)
        M.X = M.X ** pExp
        M.Y = M.Y ** pExp
        return M

    #   getter && setter
    def __get(self):
        return self.m_iId
    def __set(self,p_iId):
        self.m_iId = p_iId

    #   init property(fget=None, fset=None, fdel=None, doc=None)
    ppt = property(__get,__set)

#   ===========================================================================
#   b:  body
#   ===========================================================================

#   m:  vector2D
g.f_menu("Vector2D")

#   s:  define
g.f_menuS1("define")
v1 = CVector2D(-1.0, -3.0)   # float
v2 = CVector2D(5, 8)         # numbers.real
g.f_text("v1.str    => %s" % str(v1))
g.f_text("v2.repr   => %s" % repr(v2))  # !CRQ-240414

#   s:  type
sType = type(v1)
g.f_text("? type(v1) =: <%s>" % (sType))    # => class '__main__.CVector2D'

#   s:  operation
g.f_menuS1("operation")

#   artithmetic
v = v1 + v2;    g.f_text(f"v := v1+v2 := {v}")
v = v1 - v2;    g.f_text(f"v := v1-v2 := {v}")
v = v1 * v2;    g.f_text(f"v := v1*v2 := {v}")
v = v1 / v2;    g.f_text(f"v := v1/v2 := {v}")

#   compare
b = v1 == v2;   g.f_text(f"b := v1==v2 := {b}")
b = v1 < v2;    g.f_text(f"b := v1<v2 := {b}")

#   single
v = abs(v1);    g.f_text(f"v := abs(v1) := {v}")

#   s:  exception
g.f_menuS1("make risky assignment")
try:
    v3 = CVector2D(-1, "-1")
except TypeError as e:
    g.f_text(f"Exception occured: {e}",g.C_COLOR_RED)
    v3 = CVector2D(99, 99)
v = v1 + v3;    g.f_text(f"v := v1+v3 := {v}")

#   s:  classMethod:power
g.f_menuS1("classMethod:power")
f1 = 5.0
f2 = 4.0
fx = 2.0
v  = CVector2D.f_power__cm(f1,f2,fx)
g.f_text("power v(%f,%f)**(%f)  => %s" % (f1,f2,fx,str(v)))
fx = 3.0
v  = CVector2D.f_power__cm(f1,f2,fx)
g.f_text("power v(%f,%f)**(%f)  => %s" % (f1,f2,fx,str(v)))
f2 = -9.2
v  = CVector2D.f_power__cm(f1,f2,fx)
g.f_text("power v(%f,%f)**(%f)  => %s" % (f1,f2,fx,str(v)))

#   s:  property
g.f_menuS1("property")
g.f_text("v1.iId    => %d" % v1.ppt)
v1.ppt = 4711
g.f_text("v1.iId2   => %d" % v1.ppt)

#   === :footer
g.f_footer(sTc)
