#   coding:UTF-8
#   !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ-------$

#   ***************************************************************************
#   My Python Tutorial  :: class
#   ***************************************************************************

#   rem:
#       Python is an object oriented programming language.
#       Almost everything in Python is an object,
#           with its properties and methods.
#       A Class is like an object constructor,
#           or a "blueprint" for creating objects.

#   rem:
#       Python doesn't support
#       •   private or
#       •   protected class members

#  $url
#       •   https://www.w3schools.com/python/python_classes.asp
#       •   https://docs.python.org/3/tutorial/classes.html

#   book:  !doc:=...
#       •   Einf?hrung in Python3
#           https://www.hanser-elibrary.com/isbn/9783446435476

#   dunder :    "double underscore" methods
#   $url
#       •   https://www.geeksforgeeks.org/dunder-magic-methods-python/

''' !content
        •   m:  define
        •   m:  instanceInfo
        •   m:  callableInfo
        •   m:  methods with input-output-parameter
        •   m:  constructor && destructor
            •   s:  call::constructor
            •   s:  call::destructor
        •   m:  __new__
            •   s:  new vs init
            •   s:  Singleton
        •   m:  memberAccessSpecifier:public|protected?|private
            •   s:  access to:baseClass
                •   u:  access.attribute.base
                •   u:  access.method.base
            •   s:  access to:derivedClass
                •   u:  access.attribute.derived
                •   u:  access.method.derived
        •   m:  property
            •   s:  property.basic
            •   s:  property.advanced
            •   s:  property.expert
        •   m:  staticAttribute
            •   s:  use:staticAttribute.instance
            •   s:  use:staticAttribute.class
        •   m:  dynamicAttribute of class||instance
            •   s:  add::dynamicAttribute.class
                •   u:  vars(object):ca
                •   u:  dir(class):ca
            •   s:  add::dynamicAttribute.instance
                •   u:  add::setAttr<X,key,val>
                •   u:  vars(object):ia
                •   u:  dir(class):ia
                •   u:  chk::hasAttr<X,key>
                •   u:  get::getAttr<X,key>
                •   u:  del::delAttr<X,key>
        •   m:  MethodType:instance|class|static
            •   s:  methodType:instance
            •   s:  methodType:class
            •   s:  methodType:static
        •   m:  inheritance
            •   s:  monkey
            •   s:  actor
        •   m:multiple-inheritance
            •   s:  runMultiple
            •   s:  multi.Inheritance:isType
            •   s:  multi.Inheritance:isInstance
            •   s:  multi.Inheritance:isSubclass
        •   m:  abstractClass
            •   s:  abstract.baseClass
            •   s:  abstract.derivedClass
        •   m:  dunder_overloads_buildIn
            •   s:  str|repr:overloaded
            •   s:  print:overloaded
            •   s:  str|repr:standard showing:DateTime
        •   m:  overloading:operator:+
            •   s:  fExpr
            •   s:  addOperator
        •   m:  overloading:dataType:list
            •   s:  define list
            •   s:  push element
        •   m:  classDecorator
            •   s:  @decoCall : decorate FctByCls
            •   s:  @decoRepr : decorate ClsByFct
        •   m:  dataClass
            •   s:  @decoDC.simple
            •   s:  @decoDC.slot    removed:PyVer>=3.10
            •   s:  @decoDC.field
        •   m:  genericClass
'''

''' !functions
        •   class
        •   dir         *   show instance members
        •   vars        *   show only temp attributes
        •   setattr     *   add a new attribute
        •   hasattr     *   check
        •   delattr     *   delete specific attribute
        •   del         *   delete-object
        •   super       *   call baseClass method
        •   issubclass  *   call baseClass method
'''

''' !decorator
        •   @classmethod
        •   @staticmethod
'''

''' !dunder methods
        •   __class__   *   body
        •   __name__    *   className
        •   __dict__    *   x.attributes
        •   __new__     *   createObject
        •   __init__    *   constructor
        •   __add__     *   operator:add
        •   __del__     *   destructor
        •   __str__     *   string
        •   __rep__     *   string
'''


#   === :header
import LIB_inc as m;    g = m.CLib();   sTc = 'tcClass'
g.f_header(sTc)

#   trace?
g_bTrace  = False

#   make random value
i,n     = 1,5
g_iRnd  = g.f_iRandom(n,i)      # i...n
g.f_puts("&&& random:%d" % g_iRnd)

#   set NL in menu
g_bNL   = True

#   ---------------------------------------------------------------------------
#   m:  define    !doc:[21.7]
#   ---------------------------------------------------------------------------

g.f_menu("define && intro to class handling",p_bNL=g_bNL)

class CIntro:

    #   class attribute - public
    m_iVal  = 5           # has a value

    #   class method - public
    def f_infoVal(self) -> None:
        g.f_text("myVal =:'%d'" % (self.m_iVal))    # access via self

# end of class definition

#   create an object to the class
g.f_menuS1("create object")
xIntr  = CIntro()

#   show type of class object
g.f_menuS2("show my class type")
g.f_text("class type(x):%s" % (type(xIntr)))

#   call public class.attribute
g.f_menuS1("call public::class.attribute")
i = xIntr.m_iVal  # access directly
g.f_text("The class value is =:'%d'" % i)

#   call punlic classs.method
g.f_menuS1("call public::class.method")
xIntr.f_infoVal()

#   --------------------------------------------------------------------------
#   m:  instanceInfo  !doc:[21.3]
#   --------------------------------------------------------------------------

g.f_menu("info:ofInstance",p_bNL=g_bNL)

class CInstanceInfo:
    def f_Type(self) -> str:        # self immer 1. Parameter
        sRc = str(type(self))       # show my type
        return sRc
    def f_Class(self) -> str:
        sRc = str(self.__class__)
        return sRc
    def f_Who(self) -> str:
        sRc = self.__class__.__name__
        return sRc
#   --- eoc

#   create object
xInfo = CInstanceInfo()

#   call methods
g.f_menuS2("call my methods")
g.f_text("x.f_Type  =:'%s'"     % (xInfo.f_Type()))
g.f_text("x.f_Class =:'%s'"     % (xInfo.f_Class()))
g.f_text("x.f_Who() =:'%s'"     % (xInfo.f_Who()))

#   ---------------------------------------------------------------------------
#   m:  callableInfo
#   ---------------------------------------------------------------------------

#   $url: https://www.programiz.com/python-programming/methods/built-in/callable

g.f_menu("info:isCallable", p_bNL=True)

#   variable
i = 5
bRc = callable(i)
g.f_text("callable(i)   => %r" % bRc)       # false
assert (bRc is False)
#   function
def f_callTest() -> None:
    return

bRc = callable(f_callTest)
g.f_text("callable(f)  => %r" % bRc)        # true
assert (bRc is True)

#   class
class CCallTest:
    m_iVal = 5
bRc = callable(CCallTest)
g.f_text("callable(classC)  => %r" % bRc)   # true
assert (bRc is True)

#   instance
x = CCallTest()
bRc = callable(x)
g.f_text("callable(objectX) => %r" % bRc)   # false
assert (bRc is False)

#   ---------------------------------------------------------------------------
#   m:  methods with input-output-parameter
#   ---------------------------------------------------------------------------

g.f_menu("class method with I/O parameters",p_bNL=g_bNL)

class CIoParameter:
    m_sId   = str(g_iRnd)
    m_sName = '?name'
    m_iYear = -199
    def f_id(self) -> str:
        sRc = "Id:" + self.m_sId
        return sRc
    def f_iCalcTwo(self,p_iVal: int) -> int:
        return p_iVal * 2
    def f_sWho(self) -> str:       # self immer 1. Parameter
        sRc = "Who:"  + self.__class__.__name__ + " at:" + str(g.f_sLoc())
        return sRc
    def f_setName(self,p_sName: str) -> None:
        self.m_sName = p_sName      # dynamic add class member
    def f_setYear(self,p_iYear: int) -> None:
        self.m_iYear = p_iYear      # dynamic add class member
    def f_myPrint(self) -> None:
        g.f_text("Name='%s',Year='%d'"
            % (self.m_sName,self.m_iYear))
#   --- eoc

#   create object
xIoPa = CIoParameter()

#   call methods
g.f_menuS2("call public class methods")
g.f_text("x.f_id   =: <%s>"     % (xIoPa.f_id()))
g.f_text("x.f_sWho =: <'%s'>"   % (xIoPa.f_sWho()))
i = 2; iRc = xIoPa.f_iCalcTwo(i)
g.f_text("x.f_calc2(%d)  =: <%d>"   % (i,iRc))
assert (iRc == 2 * i)

#   show memberA
g.f_menuS2("value classAttribute A")
xIoPa.f_myPrint()

#   update class attributes
xIoPa.f_setName("peter")
xIoPa.f_setYear(2015)

#   show memberB
g.f_menuS2("value classAttribute B")
xIoPa.f_myPrint()

#   show attributes using dict      !doc:[21.2.4]
g.f_menuS2("show classAttributes any")
g.f_text("a) x.__Dict__ : '%s' * by Dict"   % (xIoPa.__dict__))

#   ---------------------------------------------------------------------------
#   m:  constructor && destructor
#   ---------------------------------------------------------------------------

g.f_menu("constructor && destructor",p_bNL=g_bNL)

class CConstructorDestructorTest:

    def __init__(self,p_sName: str,p_iYear: int) -> None:
        sNam = self.__class__.__name__; sLoc = g.f_sLoc()
        g.f_text("method.ini:<%s> is called at:{%s}" % (sNam,sLoc))
        self.m_sName = p_sName      # dynamic add class member
        self.m_iYear = p_iYear      # dynamic add class member

    def __del__(self) -> None:
        sNam = self.__class__.__name__; sLoc = g.f_sLoc()
        g.f_text("method.del:<%s> is called at:{%s}" % (sNam,sLoc))

    def f_print(self) -> None:
        sNam = self.__class__.__name__; sLoc = g.f_sLoc()
        g.f_text("Name='%s',Year='%d' at:{%s;%s}"
            % (self.m_sName,self.m_iYear,sNam,sLoc))

#   --- eoc

#   s:call::constructor
g.f_menuS2("call:constructor")
g.f_trace("create X")
xCDTs = CConstructorDestructorTest("Harvey",2022)

#   s:call::destructor
xCDTs.f_print()
#   delete object - using destructor
g.f_text("delete X...")

#   call explicitely destructor
g.f_menuS2("call:destructor")
del (xCDTs)

#   check X
g.f_text("? existing X...")
bEc = False
try:
    print(xCDTs)
except NameError:
    bEc = True
    g.f_warning("X is not defined")
else:
    g.f_text("X is an object")
assert (bEc is True)

#   ---------------------------------------------------------------------------
#   m:  __new__
#   ---------------------------------------------------------------------------

#   https://www.geeksforgeeks.org/singleton-pattern-in-python-a-complete-guide/
#   A Singleton pattern in python is a design
#       pattern that allows you to create just one instance of a class,
#       throughout the lifetime of a program.
#   Using a singleton pattern has many benefits.
#   A few of them are:
#       To limit concurrent access to a shared resource.
#       To create a global point of access for a resource.
#       To create just one instance of a class,
#           throughout the lifetime of a program.

g.f_menu("__new__ vs __init__",p_bNL=g_bNL)


class CData:

    def __new__(cls, p_sName: str):
        sNam = cls.__name__
        g.f_text(f"__new__ of : <{sNam}>")
        return object.__new__(cls)

    def __init__(self, p_sName: str) -> None:
        sNam = self.__class__.__name__
        g.f_text(f"__ini__ of : <{sNam}>")
        self.m_sName = p_sName

#  ---  eoc.CData

#   s:  new vs init
g.f_menuS1("__new__ vs __init__",p_bNL=g_bNL)

#   using class constructor
X = CData("Harvey")

#   s:  Singleton
g.f_menuS1("SingleTon",p_bNL=g_bNL)

class CSingleTon:

    m_bObject = None  # Keep instance reference

    def __new__(cls, *args, **kwargs):
        if not cls.m_bObject:
            g.f_text("<<< create NEW object")
            cls.m_bObject = object.__new__(cls, *args, **kwargs)
        else:
            g.f_text("<<< object already created")
        return cls.m_bObject

#   --- eoc.CSingleTon

xSingleTon1 = CSingleTon()
g.f_text("mem(x1)  : '%0x'" % id(xSingleTon1))

xSingleTon2 = CSingleTon()
g.f_text("mem(x2   : '%0x'" % id(xSingleTon2))

assert (id(xSingleTon1) == id(xSingleTon2))
g.f_text("? (&x1 == &x2) : '%r'" % True)

#   ---------------------------------------------------------------------------
#   m:  memberAccessSpecifier:public|protected?|private
#   ---------------------------------------------------------------------------

#   $url:
#   https://www.tutorialsteacher.com/python/property-decorator
#   https://www.tutorialsteacher.com/python/public-private-protected-modifiers
#   https://www.datacamp.com/tutorial/python-private-methods-explained

#   REM.proteced:
#       Python doesn't support member namespace "protected" -
#       you can use an property decorator instead

#   REM.private:
#       But private is supported

#   REM.overview
#       baseClass                  ---->    derivedClass
#           attribute   private                 noAccess
#           attribute   public                  noAccess
#           method      private                 noAccess
#           method      public                  Access


g.f_menu("(attributes,methods) x (public,protected,private)",p_bNL=g_bNL)

class CAccessSpecifierTest:

    #   attributes
    __p_iVal    = -981          # private.Attribute   => 2x '_'
    _r_iVal     = 4711          # protected? 1x '_'   => not supported
    m_iVal      = 123           # public.Attribute    => noNameConvention

    #   methods
    def __p_value(self) -> int:     # private.Method  * 2x __f()
        return self.__p_iVal

    def f_value(self) -> int:       # public.Metod *  noNameConvention
        return self.m_iVal

#   --- eoc


# use
xAcSp = CAccessSpecifierTest()

#   s:  access to:baseClass
g.f_menuS1("access to:baseClass")

#   =:= u:  access.attribute.base
g.f_menuS2("access.attributes.base")

#   try access attribute
try:
    g.f_text("x.public      =: %d"  % (xAcSp.m_iVal))   # allowed
    g.f_text("x.protected ? =: %d"  % (xAcSp._r_iVal))  # access is possible!
    g.f_text("x.private     =: %d"  % (xAcSp.__p_iVal))     # exception
except Exception as sExc:
    bEc = True
    g.f_text("x.private    => EXC:%s" % sExc,g.C_COLOR_RED_DARK)

#   =:= u:access.method.base
g.f_menuS2("access.method.base")

#   try access methods
bEc = False
try:
    g.f_text("m.public     =: %d"  % (xAcSp.f_value()))     # allowed
    g.f_text("m.private    =: %d"  % (xAcSp.__p_value()))   # exception
except Exception as sExc:
    bEc = True
    g.f_text("m.private    => EXC:%s" % sExc,g.C_COLOR_RED_DARK)
assert (bEc is True)

#   s:access to:derivedClass
g.f_menuS1("access to:derivedClass")

class CAccessSpecifierTest_derived(CAccessSpecifierTest):
    m_iId = 123

#   --- eoc

#   create object to derived class
yAcSp = CAccessSpecifierTest_derived()

#   access to public.member in of derived class
bEc = False
g.f_text("y.m_iId  =: %d"   % (yAcSp.m_iId))    # exception!

#   =:= u:  access.attribute.base
g.f_menuS2("access.attributes.base")

#   access to public.member in derived class - fails
bEc = False
try:
    g.f_text("y.public      =: %d"      % (yAcSp.m_iVal))   # OK
except Exception as sExc:
    bEc = True
    g.f_text("y.public => EXC:%s" % sExc,g.C_COLOR_RED_DARK)
assert (bEc is False)

#   =:= u:  access.method.derived - ok
g.f_menuS2("access.method.derived")

#   access to public method
bEc = False
try:
    g.f_text("x.f_value()   =: %d"  % (yAcSp.f_value()))    # ok
except Exception as sExc:
    bEc = True
    g.f_text("x.f_value() => EXC:%s" % sExc,g.C_COLOR_RED_DARK)
else:
    g.f_text("done.")
assert (bEc is False)

#   access to private method
bEc = False
try:
    g.f_text("x.__p_value() =: %d"  % (yAcSp.__p_value()))  # exception
except Exception as sExc:
    bEc = True
    g.f_text("x.__p_value() => EXC:%s" % sExc,g.C_COLOR_RED_DARK)
else:
    g.f_text("done.")
assert (bEc is True)

#   ---------------------------------------------------------------------------
#   m:  property   !doc:[21.10]
#   ---------------------------------------------------------------------------

#  Eine Property kann als ein virtuelles,globales Attribut
#           verstanden werden.
#       Der Zugriff auf diese, wird ueber gesonderte get/set-Methoden
#       definiert. D
#  Dabei koennen mehrere (reale) Attribute zum
#       Holen(get) oder Setzen(set) verwendet werden.

g.f_menu("property",p_bNL=True)

#   s:  property.basic     ------------------------------------------------
g.f_menuS1("property basic")

class CPropertyTest:

    #   private member
    def __init__(self) -> None:
        self.__m_sId = '?NoId'

    #   private methods READ+WRITE access
    def __get(self) -> str:
        return self.__m_sId
    def __set(self,p_sId) -> None:      # UTF8-error
        self.__m_sId = p_sId

    #   init property(fget=None, fset=None, fdel=None, doc=None)
    ppt = property(__get,__set)

#   --- eoc

#   use class with 1 property
xProp = CPropertyTest()

#   read default
g.f_text("read x.ppt =: '%s'" % (xProp.ppt))

#   implicitely write with property "__set"
xProp.ppt = 'PeterIstHier'

#   read
g.f_text("read x.ppt =: '%s'" % (xProp.ppt))


#   s:  property.advanced    -----------------------------------------------
g.f_menuS1("advanced")


class CCelsiusProperty:

    __sDoc = 'Celsius2Fahrenheit'

    m_iCtr = 0

    def __init__(self) -> None:
        self.__fVal = -273.1

    def f_Celsius2Fahrenheit(self) -> float:
        return (self.__fVal * 1.8) + 32

    def __get(self) -> float:
        try:
            return self.__fVal
        except AttributeError:
            g.f_text("EXC AttError")
            return -999.9

    def __set(self,p_fVal: float) -> None:
        self.__fVal = p_fVal

    def __del(self) -> None:
        g.f_text("--- delAttr")
        del self.__fVal

    #   init property
    ppt = property(__get,__set,__del,__sDoc)

#   ---  eoc


xCels = CCelsiusProperty()

#   read default
g.f_text("read x.ppt    =: '%s'" % (xCels.ppt))

#   write
xCels.ppt = 30.5

g.f_text("Celsius(X)    =: '%s'" % (xCels.ppt))
g.f_text("Fahrenheit(X) =: '%s'" % (xCels.f_Celsius2Fahrenheit()))

#   delete?
sKey = 'm_iCtr'
try:
    delattr(xCels,sKey)
except Exception as sExc:
    g.f_text("EXC:%s" % sExc)       # exception
else:
    g.f_text("done.")

g.f_text("Celsius(X)    =: '%s'" % (xCels.ppt))


#   s:  property.expert   --------------------------------------------------
g.f_menuS1("expert:decorator")

class CDecoratorProperty():

    def __init__(self,p_sId: str) -> None:
        self.__m_sId = p_sId

    @property
    def f_name(self) -> str:
        g.f_text("call ppy")
        try:
            return self.__m_sId
        except AttributeError:
            g.f_text("EXC AttError")
            return '?'

    @f_name.setter
    def f_name_set(self,p_sId: str) -> None:
        g.f_text("call ppt.setter")
        self.__m_sId = p_sId

    @f_name.getter
    def f_name_get(self) -> str:
        g.f_text("call ppt.getter")
        return self.__m_sId

    @f_name.deleter
    def f_name_del(self) -> None:
        g.f_text("call ppt.delete")
        del self.__m_sId

#   --- eoc

#   init
xDeco = CDecoratorProperty('Johnny')

#   get
g.f_text("x:%s" % (xDeco.f_name))

#   change and get
s = 'Luthor'
xDeco.f_name_set = s
sRc = xDeco.f_name_get
g.f_text("x:%s" % sRc)
assert (sRc == s)

#   delete
del xDeco.f_name_del

#   ---------------------------------------------------------------------------
#   m:  staticAttribute of class||instance
#   ---------------------------------------------------------------------------
#   static attribute
#       ?   by instance
#       ?   by class

#   $url:https://builtin.com/software-engineering-perspectives/python-attributes


g.f_menu("static attribute",p_bNL=g_bNL)

class CStaticAttributeTest():
    m_iCtr = 0      # attribute or variable
#   -- eoc

#
#   s:  use:staticAttribute.instance
#

g.f_menuS1("attribute::ofInstance")

#   first X
xStAt = CStaticAttributeTest()
xStAt.m_iCtr += 3

#   then Y
yStAt = CStaticAttributeTest()
g.f_text("x.iCtr =: %d"  % xStAt.m_iCtr)     # 3
g.f_text("y.iCtr =: %d"  % yStAt.m_iCtr)     # 0

#
#   s:  use:staticAttribute.class     =:staticClassVariable C++
#

g.f_menuS1("attribute::ofClass")

#   using short notation : <className>.attribute

CStaticAttributeTest.m_iCtr  += 1
g.f_text("class.iCtr1 =: %d"  % CStaticAttributeTest.m_iCtr)     # 1
CStaticAttributeTest.m_iCtr   += 1
g.f_text("class.iCtr2 =: %d"  % CStaticAttributeTest.m_iCtr)     # 2
CStaticAttributeTest.m_iCtr   += 8
g.f_text("class.iCtr3 =: %d"  % CStaticAttributeTest.m_iCtr)     # 10

#   ---------------------------------------------------------------------------
#   m:  dynamicAttribute of class||instance
#   ---------------------------------------------------------------------------

#   $url:
#   https://www.geeksforgeeks.org/dynamic-attributes-in-python/

#   add or change object/class attributes during runtime
#       s1: add <class.attribute>
#       s2: add <instance.attribute>


g.f_menu("dynamic attribute",p_bNL=g_bNL)

class CDynamicAttribute:
    m_iId   = g.f_iRandom(1000,1)           # <class.attribute>
    def f_id(self) -> str:
        sRc = "Id:"  + str(self.m_iId)
        return sRc
    def f_sWho(self) -> str:        # self immer 1. Parameter
        sRc = "Who:["  + self.__class__.__name__ + "] at:" + g.f_sLoc()
        return sRc
#   --- eoc

#   create object
xDyAt = CDynamicAttribute()

#   call methods
g.f_text("x.f_id   =: <%s>"     % (xDyAt.f_id()))
g.f_text("x.f_sWho =: <'%s'>"   % (xDyAt.f_sWho()))


#
#  =:= s:   add::dynamicAttribute.class    !doc:[21.2.4]
#

g.f_menuS1("add.classAttribute",p_bNL=True)

#   add class.attribute it and show
CDynamicAttribute.m_iNewYear = 2024   # new attribute
g.f_text("x.CDynamicAttribute.m_iNewYear =:'%d'" % (xDyAt.m_iNewYear))

#   check:class.Attribute

#   =:= u:  vars(object):ca
g.f_menuS2("check.class.Attribute:vars")  # $doc:[21.2.4]
hRc = vars(x)
g.f_text("MEMBER(X)=> %s" % hRc)  # empty! {}

bRc = ('m_iNewYear' in hRc)
assert (bRc is False)

#   =:= u:  dir(class):ca
g.f_menuS2("check.class.Attribute:dir")
lRc = dir(CDynamicAttribute)
g.f_text(f"lRc.dirClass:={lRc}")
bRc = ('m_iNewYear' in lRc)
assert (bRc is True)

#   Has the class changed after added the member
#   We are using the class again
g.f_menuS2("uses added attribute")

#   the object y will get the new attribute
yDyAt   = CDynamicAttribute()

#   show
g.f_text("y.m_id    =: <%s>"     % yDyAt.m_iId)     # ==: x.m_iId
g.f_text("y.CDynamicAttribute.m_iNewYear =:'%d'" % (yDyAt.m_iNewYear))  # 2024

#
#   s:add::dynamicAttribute.instance
#

#   restore
xDyAt = CDynamicAttribute()
yDyAt = CDynamicAttribute()

#   init vars
sKey,sVal = 'm_sName','Theodor'

#   =:= u:  add::setAttr<X,key,val>
g.f_menuS1("add.instanceAttribute",p_bNL=True)
g.f_text("setAttr(x,%s,%s)..." % (sKey,sVal))
setattr(xDyAt,sKey,sVal)

#   check via vars variable members

#   =:= u:  vars(object):ia
g.f_menuS2("check.X.vars")
hRc = vars(xDyAt)
g.f_text("vars(X) => %s" % hRc)
bRc = (sKey in hRc); assert (bRc is True)
bRc = (sVal in hRc); assert (bRc is False)

#   =:= u:  dir(class):ia
g.f_menuS2("check.X.dir")
lRc = dir(xDyAt)
bRc = (sKey in lRc); assert (bRc is True)
g.f_text("dir(X) => %s" % lRc)


#   check via hasAttr object X and Y

#   =:= u:  chk::hasAttr<X,key>

#   object X
g.f_menuS2("check.X.hasAttr")
bRc = hasattr(xDyAt,sKey); assert (bRc is True)
g.f_text("? has(X,<'%s'>) =: '%r'" % (sKey,bRc))        # True

#   object Y
g.f_menuS2("check.Y.hasAttr")
bRc = hasattr(yDyAt,sKey); assert (bRc is False)
g.f_text("? has(Y,<'%s'>) =: '%r'" % (sKey,bRc))        # False

#   =:= u:  get::getAttr<X,key>

g.f_menuS2("get Attribute")
sRc = getattr(xDyAt,sKey); assert (sRc == sVal)
g.f_text("getAttribute(X,<%s>)   = '%s'" % (sKey,sRc))  # Theodor


#   =:= u:  del::delAttr<X,key>   * delete attribute
g.f_menuS2("delete Attribute?")
delattr(xDyAt,sKey)
g.f_text("delAttribute(X,%s)..." % (sKey))
bRc = hasattr(xDyAt,sKey); assert (bRc is False)        # False

#   ---------------------------------------------------------------------------
#   m:  MethodType:instance|class|static
#   ---------------------------------------------------------------------------

#   $url:https://pynative.com/python-class-method/

#   instance method:
#       Used to access or modify the object state.
#       If we use instance variables inside a method,
#           such methods are called instance methods.
#       It must have a "self" parameter to refer to the current object.

#   class method:
#       Used to access or modify the class state.
#       In method implementation, if we use only class variables,
#       then such type of methods we should declare as a class method.
#       The class method has a "cls" parameter which refers to the class.

#   static method:
#       It is a general utility method that performs a task in isolation.
#       Inside this method, we don?t use instance or class variable
#       because this static method doesn?t take any parameters
#               like "self" and "cls".


#   $url:https://www.digitalocean.com/community/tutorials/python-static-method
g.f_menu("MethodType:instance|class|static",p_bNL=g_bNL)

class CMethodTypeTest():

    #   class-variable with start value
    __m_iCtr = 1000

    #   private member
    def __init__(self,p_iCtr:int):
        self.__m_iCtr = p_iCtr

    #   access via 'self'
    def f_add(self,v1,v2):
        return self.__m_iCtr + v1 + v2

    #   access via 'cls'
    @classmethod
    def f_add__cm(cls,v1,v2):
        cls.__m_iCtr += 1       # each call increment
        return cls.__m_iCtr + v1 + v2

    #   no access
    @staticmethod
    def f_add__sm(v1,v2):
        return v1 + v2

#   --- eoc

#   set parameter
a = g.f_iRandom(100)
b = g.f_iRandom(80,20)

#   s:  methodType:instance
g.f_menuS2("methodType:instance")
xMeTy       = CMethodTypeTest(100)      # start value
iSum    = xMeTy.f_add(a,b)              # memberCall via Object

#   s:  methodType:class
g.f_menuS2("methodType:class")
iSum_cm = CMethodTypeTest.f_add__cm(a,b)  # directCall
iSum_cm2 = CMethodTypeTest.f_add__cm(a,b)  # directCall

#   s:  methodType:static
g.f_menuS2("methodType:static")
iSum_sm = CMethodTypeTest.f_add__sm(a,b)  # directCall

#   results
g.f_text("X.f_add(%d,%d)        =: %d"  % (a,b,iSum))       # a+b + 100
g.f_text("f_add__CM(%d,%d)      =: %d"  % (a,b,iSum_cm))    # a+b + 10001
g.f_text("f_add__CM(%d,%d).2    =: %d"  % (a,b,iSum_cm2))   # a+b + 10002
g.f_text("f_add__SM(%d,%d)      =: %d"  % (a,b,iSum_sm))    # a+b

#   ---------------------------------------------------------------------------
#   m:  inheritance     !doc:[21.12]
#   ---------------------------------------------------------------------------

g.f_menu("inheritance",p_bNL=True)

#
#   s:monkey    -----------------------------------------------------------
#

g.f_menuS1("CMonkey")

class CMammal():
    __m_sNam    = 0
    __m_iLeg    = 0
#   --- eoc

class CMonkey(CMammal):

    __m_iIQ     = 80    # own attr

    def __init__(self,p_sNam,p_iLeg,p_iIQ):
        self.__m_sNam = p_sNam      # attr of mammal
        self.__m_iLeg = p_iLeg      # attr of mammal
        self.__m_iIQ  = p_iIQ

    def f_show(self):
        g.f_text("Name:'%s' legs:%d IQ:'%d'" %
                (self.__m_sNam,self.__m_iLeg,self.__m_iIQ))

#   --- eoc

xMnky = CMonkey('Judy',4,91)
xMnky.f_show()

#
#   s:  actor -------------------------------------------------------------
#

g.f_menuS1("CActor",p_bNL=True)

EColor = {'any','black','brown','red','blue','white','yellow',}

class CPerson:

    def __init__(self,p_sName,p_fHeight,p_eColor,p_iZip):
        self.__m_sName   = p_sName
        self.__m_fHeight = p_fHeight
        if (p_eColor in EColor):
            self.__m_eColor  = p_eColor
        else:
            self.__m_eColor  = 'any'
        self.__m_iZip    = p_iZip

    def f_show(self):
        sRc = self.__m_sName + ","          \
            + str(self.__m_fHeight) + ","   \
            + self.__m_eColor       + ","   \
            + str(self.__m_iZip)
        return sRc

#   --- eoc


class CActor(CPerson):

    def __init__(self, p_sName,p_fHeight,p_eColor,p_iZip,
                    p_sMovie,p_fSalary):

        #   run baseClass init()
        super().__init__(p_sName,p_eColor,p_fHeight,p_iZip)

        #   set own Variables
        self.__m_sMovie     = p_sMovie
        self.__m_fSalary    = p_fSalary

    def f_show(self):           # overload CPerson.fShow()
        sRc = super().f_show()  # call baseClass CPerson.fShow()
        sRc += "|" + \
                self.__m_sMovie      + ","           \
                + str(self.__m_fSalary)
        return sRc

#   --- eoc


#   rambo
g.f_menuS2("CPerson.Rambo")
xPers = CPerson('JohnRambo', 1.75, 'brown', 10789)
g.f_text("x:%s" % (xPers))
g.f_text("x => %s" % (xPers.f_show()))

#   bruce
g.f_menuS2("CActor.BruceWillis")
xActr = CActor('BruceWillis',1.82,'blue', 24821,'ToDieFor',132.200)
g.f_text("x:%s" % (xActr))
g.f_text("x => %s" % (xActr.f_show()))

#   ---------------------------------------------------------------------------
#   m:  multiple-inheritance        !doc:[21.13]
#   ---------------------------------------------------------------------------

#   $url:
#   https://docs.python.org/3/tutorial/classes.html#multiple-inheritance
#   https://realpython.com/lessons/multiple-inheritance-python/
#   https://www.python.org/download/releases/2.3/mro/

#   Das Diamond(=Rauten)-Problem, beschreibt die Situation,
#   in der bei der Mehrfachvererbung es zu Mehrdeutigkeiten
#   kommen kann.
#   Die Funktionen Super reduziert dieses Problem aber.

#   sheme:
#       class B <= class A
#       class C <= class A
#       class D <= class (B,C)

g.f_menu("inheritance: multiple - diamond problem",p_bNL=True)

class A:
    def f_who(self,p_sPa: str) -> None:
        sCls = self.__class__.__name__
        g.f_text("A.who('%s') \t=> CLASS=<%s>" % (p_sPa,sCls))
#   --- eoc

class B(A):
    def f_who(self,p_sPa: str) -> None:
        sCls = self.__class__.__name__
        g.f_text("B.who('%s') \t=> CLASS=<%s>" % (p_sPa,sCls))
        super().f_who('by:classB')
#   --- eoc

class C(A):
    def f_who(self,p_sPa: str) -> None:
        sCls = self.__class__.__name__
        g.f_text("C.who('%s') \t=> CLASS=<%s>" % (p_sPa,sCls))
        super().f_who('by:classC')
#   --- eoc

class D(B,C):
    def f_tmp(self) -> None:
        return None
#   --- eoc

#   show classes
g.f_text("A := %s" % A)
g.f_text("B := %s" % B)
g.f_text("C := %s" % C)
g.f_text("D := %s" % D)

#   show mro method resolution order
sRc = D.mro()
g.f_text("D.mro =: %s" % sRc,g.C_COLOR_CYAN)

#   s:  runMultiple
g.f_menuS1("run.multiple",p_bNL=True)

#   object.a
g.f_menuS2("object:a")
a = A()
a.f_who('Anton')

#   object.b
g.f_menuS2("object:b")
b = B()
b.f_who('Berta')

#   object.c
g.f_menuS2("object:c")
c = C()
c.f_who('Cleo')

#   object.d
g.f_menuS2("object:d")
d = D()
d.f_who('Dora')

#   s:  multi.Inheritance:isType
g.f_menuS1("check.isType",p_bNL=True)

#   ? type(X) == ownClass
g.f_text("[type(a):'%s' == A]  =: %r" % (type(a),True)); assert (type(a) == A)
g.f_text("[type(b):'%s' == B]  =: %r" % (type(b),True)); assert (type(b) == B)
g.f_text("[type(c):'%s' == C]  =: %r" % (type(c),True)); assert (type(c) == C)
g.f_text("[type(d):'%s' == D]  =: %r" % (type(d),True)); assert (type(d) == D)

#   ? type(X) == inheritedClass
g.f_text("[type(d):'%s' == B]  =: %r" % (type(d),False)); assert (type(d) != B)


#   s:  multi.Inheritance:isInstance
g.f_menuS1("check.isInstance",p_bNL=True)

#   ? isInstance(ownClass)
bRc = isinstance(a,A); g.f_text("? isInstance(a,A) =: %r" % bRc)
bRc = isinstance(b,B); g.f_text("? isInstance(b,B) =: %r" % bRc)
bRc = isinstance(c,C); g.f_text("? isInstance(c,C) =: %r" % bRc)
bRc = isinstance(d,D); g.f_text("? isInstance(d,D) =: %r" % bRc)

#    ? isInstance(inheritedClass)
b1 = isinstance(d,A);  g.f_text("? isInstance(d,A) =: %r" % bRc)
b2 = isinstance(d,B);   g.f_text("? isInstance(d,B) =: %r" % bRc)
b3 = isinstance(d,C);   g.f_text("? isInstance(d,C) =: %r" % bRc)


#   s:  multi.Inheritance:isSubclass
g.f_menuS1("check.isSubClass",p_bNL=True)

bRc  = issubclass(A,B); g.f_text("? isSubClass(%s,%s) => %s" % (A,B,bRc))   # F
assert (bRc is False)

bRc  = issubclass(B,A); g.f_text("? isSubClass(%s,%s) => %s" % (B,A,bRc))   # T
assert (bRc is True)

bRc  = issubclass(C,A); g.f_text("? isSubClass(%s,%s) => %s" % (C,A,bRc))   # F
assert (bRc is True)

bRc  = issubclass(D,B); g.f_text("? isSubClass(%s,%s) => %s" % (D,B,bRc))   # F
assert (bRc is True)

bRc  = issubclass(D,C); g.f_text("? isSubClass(%s,%s) => %s" % (D,C,bRc))   # F
assert (bRc is True)

#   implicitely subClass
bRc  = issubclass(D,A); g.f_text("? isSubClass(%s,%s) => %s" % (D,A,bRc))   # F
assert (bRc is True)

#   ---------------------------------------------------------------------------
#   m:abstractClass
#   ---------------------------------------------------------------------------

#   $url:
#       https://docs.python.org/3/library/abc.html
#       https://www.geeksforgeeks.org/abstract-classes-in-python/

#   An abstract class can be considered a blueprint for other classes.
#   It allows you to create a set of methods that must be created
#       within any child classes built from the abstract class.
#   A class that contains one or more abstract methods is called
#        an abstract class.
#   An abstract method is a method that has a declaration
#       but does not have an implementation.
#   We use an abstract class while we are designing
#       large functional units or when we want to provide a
#       common interface for different implementations of a component.

#   java:   interface
#   c++     virtual class
#           https://www.geeksforgeeks.org/virtual-base-class-in-c/


g.f_menu("abstractClass",p_bNL=True)

#   abc = "abstract base class"
from abc import ABC, abstractmethod

#   s:  abstract.baseClass
g.f_menuS1("baseClass")
class CAnimal(ABC):

    #   this method can be used
    def f_show(self,p_sText:str) -> None:
        sCls = self.__class__.__name__
        g.f_text("'%s' by:<%s>" % (p_sText,sCls))

    #   this method must be defined in subClass
    @abstractmethod
    def f_move(self) -> None:
        pass

#   --- eoc

#   s:  abstract.derivedClass
g.f_menuS1("derivedClass")
class CHuman(CAnimal):
    def f_move(self) -> None:
        self.f_show("I can walk and run")       # using baseClass method
#   --- eoc

class CSnake(CAnimal):
    def f_move(self) -> None:
        self.f_show("I can crawl")
#   --- eoc

class CDog(CAnimal):
    def f_move(self) -> None:
        self.f_show("I can bark")
#   --- eoc

g.f_text("try instance of BaseClass...")
#   try access methods
bEc = False
try:
    xAnim = CAnimal()
except Exception as sExc:
    bEc = True
    g.f_text("X=C   => EXC:%s" % sExc,g.C_COLOR_RED_DARK)
assert (bEc is True)

# Driver code
xHuma = CHuman()
xHuma.f_move()

xSnak = CSnake()
xSnak.f_move()

xDog = CDog()
xDog.f_move()

#   ---------------------------------------------------------------------------
#   m:  dunder_overloads_buildIn   !doc:[21.4.2]
#   ---------------------------------------------------------------------------

#   dunder : __<fct>__()   overloads  wrapper|buildIn <fct>())

#   __str__     overloads buildIn:  str()
#   __repr__    overloads buildIn:  repr()
#   We change behaviour of functions
#       str() and repr()
g.f_menu("overloading:str|repr()",p_bNL=g_bNL)


class CStrReprOverload:

    def __init__(self,p_sText: str) -> None:
        self.m_sText = p_sText

    def __str__(self) -> str:
        return "*** StringOf('"  + self.m_sText + "')"

    def __repr__(self) -> str:
        return "*** ReprstOf('"  + self.m_sText + "')"

#   --- eoc

# =:= s:  str|repr:overloaded
g.f_menuS1("overloaded")
xStRe = CStrReprOverload('MuhammedAli')
g.f_text("str(x)   => %s" % str(xStRe))
g.f_text("repr(x)  => %s" % repr(xStRe))

#   s:  print:overloaded
g.f_menuS1("overloaded:print")
xStRe = CStrReprOverload('MagnusCarlsen')
print(xStRe)    # calls str(x)

#   s:str|repr:standard showing:DateTime
g.f_menuS1("standard example:DateTime")
import datetime as g_tDtm
tDtm = g_tDtm.datetime.now()
g.f_text("tDt        => %s" % (str(tDtm)))
g.f_text("type(tDt)  => %s" % (type(tDtm)))
g.f_text("str(tDtm)  => %s" % str(tDtm))   # 2024-02-09 19:53:59.39165
g.f_text("repr(tDtm) => %s" % repr(tDtm))  # datetime.datetime(2024, 2,...

#   $url:https://www.geeksforgeeks.org/str-vs-repr-in-python/
g.f_menuS1("complex")

class CComplex:

    def __init__(self, real: int, imag: int) -> None:
        self.real = real
        self.imag = imag

    def __repr__(self) -> str:
        return 'Rational(%s, %s)' % (self.real, self.imag)

    def __str__(self) -> str:
        return '%s + i%s' % (self.real, self.imag)


#   --- eoc


#   Driver program to test above
xCmpx = CComplex(10, 20)
g.f_text("str(x)    => %s" % str(xCmpx))
g.f_text("repr(x)   => %s" % repr(xCmpx))


#   ---------------------------------------------------------------------------
#   m:  overloading:operator:+          !doc:[21.14]
#   ---------------------------------------------------------------------------

g.f_menu("overloading:operator:Plus", p_bNL=True)

from typing import Any

class CDim:
    #   hash for unit 2 metric conversion
    __hU2M: dict[str,Any] = {
            "mm":1e-3,
            "cm":1e-2,
             "m":1,
            "km":1e+3,
            "ft":0.3048,
            "yd":1609.344}

    def __init__(self, p_fUnit: float, p_sUnit: str) -> None:
        self.__m_fUni = p_fUnit
        self.__m_sUni = p_sUnit

    @classmethod    # without object usable
    def f_U2M(cls,p_sKey: str) -> float:    # key,val = mm,0.001...
        return cls.__hU2M[p_sKey]

    @classmethod
    def f_sFormat(cls,p_fVal: float) -> str:
        return ("{xVal:3.3f}".format(xVal=p_fVal))

    def __add__(self, other:object) -> tuple[str,str]:   # overloaded 'add'
        fSum  = self.f_Uni2Mtr_my() + other.f_Uni2Mtr_my()
        fVal  = self.f_Mtr2Uni(fSum)
        sVal  = self.f_sFormat(fVal)
        return (sVal, self.__m_sUni)

    def __str__(self) -> str:
        g.f_trace(p_bEnabled=g_bTrace)
        sRc = '*** dimStr:<'
        sRc += self.f_sFormat(self.__m_fUni)
        sRc += self.__m_sUni
        sRc += '> ***'
        return sRc

    def __repr__(self) -> str:
        g.f_trace(p_bEnabled=False)
        sRc = str((self.__m_fUni,self.__m_sUni))
        return sRc

    def f_Uni2Mtr(self,p_fUni: float) -> float:
        _s = self.__m_sUni
        fRc = p_fUni * self.f_U2M(self.__m_sUni)
        return fRc

    def f_Uni2Mtr_my(self) -> float:
        fRc = self.f_Uni2Mtr(self.__m_fUni)
        return fRc

    def f_Mtr2Uni(self,p_fMtr: float) -> float:
        fRc = p_fMtr / self.f_U2M(self.__m_sUni)
        return fRc

#   --- eoc

#
#   s:  fExpr
#

g.f_menuS1("expr")
f = 1e1
g.f_text("fExp := %f" % (f))
f = 1e-2
g.f_text("fExp := %f" % (f))

g.f_menuS1("CDim")
xDim = CDim(14,"mm")
yDim = CDim(25,"m")
zDim = CDim(7,"cm")
g.f_text("x.CDim := %s" % (str(xDim)))
g.f_text("y.CDim := %s" % (str(yDim)))
g.f_text("z.CDim := %s" % (repr(zDim)))

#
#   s:  addOperator
#

g.f_menuS1("add operator")

#   make new variable with values above
g.f_menuS2("z=x+y")
zDim = xDim + yDim
g.f_text("x = %s" % repr(xDim))
g.f_text("y = %s" % repr(yDim))
g.f_text("z:= x+y => %s" % (str(zDim)))

#   new values
g.f_menuS2("yd+m")
xDim = CDim(3,"yd")
yDim = CDim(50,"m")
zDim = xDim + yDim
g.f_text("x = %s" % repr(xDim))
g.f_text("y = %s" % repr(yDim))
g.f_text("z:= x+y => %s" % (str(zDim)))

#   ---------------------------------------------------------------------------
#   m:  overloading:dataType:list       !doc:[21.15]
#   ---------------------------------------------------------------------------

g.f_menu("overloading:dataType", p_bNL=True)


#   Die Klasse CList erweitert die Klasse list um die Methode
#       'f_push'.
#   Diese ruft letztlich die Methode
#       'append'
#   der list-Klasse auf.

class CListOverloaded(list):

    def __init__(self,p_lVal: list) -> None:
        list.__init__(self,p_lVal)  # call Constructor of class:List

    def f_push(self,p_xElem: int) -> None:
        self.append(p_xElem)        # method fPush(x) calls l.Append(x)

#   s:define list
l = CListOverloaded([5,1,6])
g.f_text("l  => %s" % (l))

#   s:push element
i  = 3
l.f_push(i)
g.f_text("l.fPush(%d)  => l=%s" % (i,l))


#   ---------------------------------------------------------------------------
#   m:  classDecorator
#   ---------------------------------------------------------------------------


#   https://www.geeksforgeeks.org/class-as-decorator-in-python/

#   We can define a decorator as a class in order to do that,
#   we have to use a __call__ method of classes.
#   When a user needs to create an object that acts
#   as a function then function decorator needs to return
#   an object that acts like a function, so __call__ can be useful.


g.f_menu("classDecorator",p_bNL=True)


#   s:  @decoCall : decorate FctByCls

g.f_menuS1("@decoCall:FByC",p_bNL=False)

#   Python program showing
#   use of __call__() method

from typing import Callable

class CDecoText:

    def __init__(self, p_fctPtr: Callable) -> None:
        self.m__fctPtr = p_fctPtr

    def __call__(self,p_sText: str) -> None:
        # We can add some code
        # before function call
        sOut = f"&&& deco <{p_sText}> &&& "
        self.m__fctPtr(sOut)
        # We can also add some code
        # after function call.


#   define text
sHelloText = "HelloWorld"
g.f_text("showText: '%s'" % sHelloText)  # showText: 'HelloWorld'

#   define function with adding class decorator
@CDecoText
def f_geek(s:str) -> None:
    g.f_text(s)

#   call function
f_geek(sHelloText)

#   result:
#   with deco       :   '&&& deco <HelloWorld> &&&'
#   without deco    :   'HelloWorld'


#   s:  @decoRepr : decorate ClsByFct
g.f_menuS1("@decoRepr:CByF",p_bNL=False)


#   decorate a class wih a function

from typing import Any

def f_deco_betterRepr(cls: Any) -> Any:

    """Improve representation of a class"""

    #   show Text
    g.f_text("&&& decorating...")

    #   innerMethod: define my own repr()
    def f_custom_repr(self) -> str:
        sCls = type(self).__name__
        sFct = g.f_sLoc('F')
        sVar = vars(self)
        sRc  = f"<{sVar}> at:[<{sCls}>.<{sFct}>] "
        return sRc

    #   overwrite __repr__
    cls.__repr__ = f_custom_repr

    #   return class instance
    return cls


@f_deco_betterRepr
class CShow:
    def __init__(self, p_sTxt: str) -> None:
        g.f_text("&&& Init the instance")
        self.m_sTxt = p_sTxt

sMyText = "MyNameIsPeter"
sRc     = CShow(sMyText)
g.f_text("CShow('%s') = <%s>" % (sMyText,sRc))


#   ---------------------------------------------------------------------------
#   m:  dataClass
#   ---------------------------------------------------------------------------

#   $url:
#   https://docs.python.org/3/library/dataclasses.html

#   @dataclasses.dataclass(*,
#       init=True, repr=True, eq=True, order=False,
#       unsafe_hash=False, frozen=False, match_args=True,
#       kw_only=False, slots=False, weakref_slot=False)?

g.f_menu("dataClass",p_bNL=True)
from dataclasses import dataclass


#
#   s:  @decoDC.simple
#

g.f_menuS1("@decoDataClass:simple",p_bNL=False)

#   define class using decorator @dataClass

@dataclass
class CUser:
    m_sName:str
    m_iAge:int
    m_fWht:float
    def f_hello(self) -> None:
        g.f_text("Hello my name is: '%s'" % self.m_sName)

#   create an Object
xUser = CUser("Peter",59,69.91)
#   show
g.f_text("user1: '%s' " % xUser)
# <<<   user: 'CUser(m_sName='Peter', m_iAge=59, m_fWht=69.91)'

#   run method
xUser.f_hello()

#   show dict
s   = str(xUser.__dict__)
g.f_text("X.__dict() =: '%s' " % s)

#
#   s:  @decoDC.slot - removed
#

#   pyVersion V>=3.10

#
#   s:  @decoDC.field
#

#   $url:
#   https://docs.python.org/3/library/dataclasses.html#dataclasses.field
#   https://www.infoworld.com/article/3563878/how-to-use-python-dataclasses.html

g.f_menuS1("@decoDataClass:field",p_bNL=False)

from dataclasses import field

@dataclass
class CStudent:
    m_sName: str
    m_iAge: int
    m_bIsActive: bool = False
    m_lRoom: list[int] = field(
        default_factory=list, # noqa
        compare=False,
        hash=False,
        repr=False)
    def f_hello(self) -> None:
        g.f_text("I am Student: '%s'" % self.m_sName)


#   new student
xStud = CStudent("Christine",21,True,[27,256,401])

#   run method
xStud.f_hello()

#   show dict
s   = str(xStud.__dict__)
g.f_text("X.__dict() =: \n\t%s " % s)

#   access 1 component
b = xStud.m_bIsActive
g.f_text("X.isActive =: '%r' " % b)

#   ---------------------------------------------------------------------------
#   m:  genericClass   in C++ Template
#   ---------------------------------------------------------------------------

g.f_menu("generic class")

from logging import Logger
from typing import Generic
from typing import TypeVar

TLogger = TypeVar("TLogger")

class CLoggedVar(Generic[TLogger]):

    def __init__(self, value: TLogger, name: str, logger: Logger) -> None:
        self.name = name
        self.logger = logger
        self.value = value

    def set(self, p_new: TLogger) -> None:
        self.log("Set " + repr(self.value))
        self.value = p_new

    def get(self) -> TLogger:
        self.log("Get " + repr(self.value))
        return self.value

    def log(self, message: str) -> None:
        self.logger.info("%s: %s", self.name, message)
        g.f_text("Message:%s" % message)


def F_test_genClass() -> None:
    lv1 = CLoggedVar(1, "Jan", Logger("a"))      #  noqa
    lv2 = CLoggedVar(1.0, "Jan", Logger("b"))    #  noqa : noLinter check
    lv1.log('helpMe')

if __name__ == "__main__":
    F_test_genClass()


#   === :footer
g.f_footer(sTc)
