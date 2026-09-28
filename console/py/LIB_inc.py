#   coding:UTF-8 ** Zeile am Anfang
#   python-specials in UTF-8 and ruff
#   !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ

#   ***************************************************************************
#   Python-Library 2015-2024
#   ***************************************************************************

#   •   doc
#       BP3:   Buch "Einführung in Python 3", Hanser-Verlag, Bernd Klein

#   •   url
#       https://www.tutorialspoint.com/python/index.htm

#   •   using:
#           Powershell/DOS variable: v_FWK_exitCode
#           psh$ (gci env:v_FWK_exitCode).Value

#
#   •   file info functions
#       how-to-determine-file-function-and-line-number
#       http://stackoverflow.com/questions/6810999/

#   •   ruff
#       $>_cls; ruff check .\LIB_inc.py


#   content:
#       •   b:  import


#
#   b:  import
#

import inspect
import math
import os
import random
import shutil
import sys
import time
import zipfile
from array import array
from datetime import datetime


#   === :content
'''
    !content:
        m:  define.exitCode
        m:  globalFunction
        m:  define.Label
        m:  class.base
        m:  class.info
        m:  class.converter
        m:  class.ctype
        m:  class.math
        m:  class.help
        m:  class.IOM
        m:  class.Timer
        m:  class.menu
        m:  class.Zip
        m:  class.test
        m:  class.final

'''

#   m:  globals
g_sId       = "240125"        # date of Lib 2020-08-12 bis heute
g_bLogging  = True

#   m:  doc
g_sTutorReadmeFile   =   "Readme-PY.txt"

#   environment variables
g_bMode_batch   = 'v_mode_bBat'
g_bMode_color   = 'v_mode_bClr'
g_bMode_verbose = 'v_mode_bVbs'
g_iMode_logging = 'v_mode_iLog'

#   tmpDir exists?

#   ===========================================================================
#   m:  define.exitCode
#   ===========================================================================

C_EC_OK = int(0)            # standard reply by Tc - OK
C_EC_WARNING = int(3)       # warning
C_EC_ERROR = int(1)         # standard error - PSH script

try:
    g_iEc = int(os.environ['v_FWK_exitCode'])
except Exception:
    g_iEc = C_EC_WARNING    # for bash/dos: 0...255

#   ===========================================================================
#   m:  globalFunction
#   ===========================================================================

def F_who() -> None:
    print(C_LABEL)

def F_hello() -> str:
    return "LIB::glob:HelloPythonLibrary2024"


#   ===========================================================================
#   m:  define.Label
#   ===========================================================================

C_LABEL = "mATe64 UG/P.Hassen/PythonLibrary 2024"   # 2020..2024


#   ===========================================================================
#   m:  class.base
#   ===========================================================================

class CBase:

    __m_cDirectorySeparator_MSWIN   = '\\'
    __m_cDirectorySeparator_POSIX    = '/'

    def f__sPythonRoot(self) -> str:
        s = os.path.dirname(sys.executable)
        return s

    def f_bPythonVpy(self) -> bool:         # !CRQ-241209:checkVpy
        s = self.f__sPythonRoot()
        s = s.lower()
        print("PyRoot:<%s>" % s)
        if ( s == 'c:\\vcast' ) :
            return True
        else :
            return False

    def f__bIsPosix(self) -> bool:
        if os.name == 'posix':
            return True
        else:
            return False

    def f_bOsPosix(self) -> bool:
        return self.f__bIsPosix()

    #   which compiler
    def f_sOsVersion(self) -> str:
        return sys.version

    #   !CRQ-241209:besserVersionBestimmen t.b.d
    def f_sOsCompiler(self) -> str:
        sRc = 'python'
        bRc = self.f__bIsPosix()
        if bRc:
            sRc += '3'
        return sRc

    #   clear screen
    def f_clearSreen(self) -> None:
        bOsPosix = self.f__bIsPosix()
        if bOsPosix:
            sCmd = 'clear'
        else:
            sCmd = 'cls'
        os.system(sCmd)
        return None

    def f__sOsDirSeparator(self) -> str:
        bOsPosix = self.f__bIsPosix()
        if (bOsPosix):
            cSep = self.__m_cDirectorySeparator_POSIX
        else:
            cSep = self.__m_cDirectorySeparator_MSWIN
        return cSep

    #   directory with write access
    def f__sOsDirTmp(self) -> str:
        bOsPosix = self.f__bIsPosix()
        if (bOsPosix):
            sDir = "/var/tmp"
        else:
            sDir    = os.environ['UserProfile']     # better
            sDir   += os.environ['v_USR_scratch_relPath']   # !CRQ-250725
            sDir    = sDir.replace(
                            self.__m_cDirectorySeparator_POSIX,
                            self.__m_cDirectorySeparator_MSWIN )
        # fi
        bDir = os.path.exists(sDir)
        if (not bDir):
            os.makedirs(sDir)
        return sDir

    def f__bOsVariable(self,p_sOsVariable:str) -> bool:
        try:
            s = os.environ[p_sOsVariable]
        except Exception:
            return False
        s = s.lower()
        #   Posix vs Windows
        bRc = False
        if self.f__bIsPosix():
            if (s == '0'):
                bRc = True
        else:
            if (s == 'true'):
                bRc = True
        return bRc

    def f__iOsVariable(self,p_sOsVariable:str) -> tuple[bool,int]:
        try:
            s = os.environ[p_sOsVariable]
        except Exception:
            return False,-9
        s = s.lower()
        bRc = False
        try:
            bRc = True
            iRc = int(s)
        except ValueError:
            iRc = -1
        return bRc,iRc

    def f_bsEnv(self,p_sEnv:str) -> tuple[bool,str]:
        bRc = False
        sRc = '?'
        bRc = self.f__bOsVariable(p_sEnv)
        if bRc:
            sRc = '$'
        return bRc,sRc

class CSys:

    def f_sleep(self,p_iSec=None) -> None:
        if (p_iSec is None):
            p_iSec = 1
        #   python doesn't work asyn with os
        #   if (p_iSec > 1) :
        #    i = 0
        #    n = p_iSec - 1
        #    for i in range(n):
        #        print('.',end='')
        #        time.sleep(1)
        #    print(';')
        #   time.sleep(1)
        time.sleep(p_iSec)
        return None

    def f_version(self,p_bTuple = False) -> str:
        sRc = sys.version
        if (p_bTuple) :
            tRc = sys.version_info
            sRc = str(tRc)
        return sRc

    def f__exit(self,p_iExc = 0) -> None:
        sys.exit(p_iExc)
        return None

#   ===========================================================================
#   m:  class.stack
#   ===========================================================================

class CStack:

    __m_iStackDepth     = 2

    def __f_stack(self, p_iStackSize:int = __m_iStackDepth):
        rCallerRecord   = inspect.stack()[p_iStackSize]
        tFrame          = rCallerRecord[0]
        tInfo           = inspect.getframeinfo(tFrame)
        self.m_dbg = 123
        return tInfo

    def f_iLine(self) -> int:   # $CRQ-240424:useiLine
        p = self.__f_stack(3)
        return p.lineno

    def f_tLoc(self) -> tuple[str,str,str,str]:
        p = self.__f_stack(3)
        sLine = ("%3.3d" % int(p.lineno))
        sFunc = str(p.function)
        if (sFunc == '<module>'):
            sFunc = 'Body'
        sFile = os.path.basename(p.filename)
        s = sFunc + ";" + sFile + ';' + sLine
        return s,sFile,sLine,sFunc

    #   old f_info
    def f_sLoc(self,p_sFct:str = '') -> str:   # return str|int
        #   IN: {'N'=FileName,'L'=Line,'F'=Function}
        pInfo = self.__f_stack()
        if ((p_sFct is None) or (p_sFct == 'L')):
            return str(pInfo.lineno)
        elif (p_sFct == 'F'):
            return str(pInfo.function)
        elif (p_sFct == 'N'):
            return str(pInfo.filename)
        else:
            return '?'


#   ===========================================================================
#   m:  class.string
#   ===========================================================================

class CString:

    #   s:  show DataType

    def f_sBool(self,p:bool) -> str:
        if p:
            return "TRUE"
        return "FALSE!"

    def f_sArgs(self,p_bNum:bool = False) -> str:
        iLen = len(sys.argv)
        if iLen == 0:
            return "?A"
        s = "A(" + str(iLen) + "):"
        s += "{"
        i = 0
        for x in sys.argv:
            if (i > 0):
                s += ","
            s += str(i) + ":" + "<" + x + ">"
            i += 1
        s += "}"
        sRc = s
        return sRc

    def f_sList(self, p:list, p_bNum:bool = False, p_sFmt:str = '') -> str:
        sRc = "?L"
        if not isinstance(p,list):
            return sRc
        if len(p) == 0:
            return sRc
        sRc = "L:["
        i = 0
        for x in p:
            if i > 0:
                sRc += ","
            if (p_bNum):
                sRc += "{"
                sRc += str(i)
                sRc += "}:"
            if (p_sFmt is None): s = ascii(x)
            else: s = format(x,p_sFmt)
            sRc += s
            i += 1
        sRc += "]"
        return sRc

    def f_sTuple(self, p:tuple, p_bNum:bool = False,p_sFmt:str = '') -> str:
        sRc = "?T"
        if not isinstance(p,tuple):
            return sRc
        i = 0
        sRc = "T:("
        for x in p:
            if i > 0:
                sRc += ","
            if (p_bNum):
                sRc += "{"
                sRc += str(i)
                sRc += "}:"
            if (p_sFmt is None): s  = ascii(x)
            else: s  = format(x,p_sFmt)
            sRc += s
            i += 1
        sRc += ")"
        return sRc

    def f_sHash(self,p:dict,p_bNum:bool = False) -> str:
        sRc = "?H"
        if not isinstance(p,dict):
            return sRc
        i = 0
        sRc = "H:{"
        for x in p:
            if i > 0:
                sRc += ","
            if (p_bNum):
                sRc += "["
                sRc += str(i)
                sRc += "]:"
            sKey = x
            sVal = ascii(p[x])  # ==ascii(str(p[i]))
            s = "{xKey}=>{xVal}".format(xKey=sKey,xVal=sVal)
            sRc += s
            i += 1
        sRc += "}"
        return sRc

    def f_sSet(self,p:set,p_bNum:bool = False) -> str:
        sRc = "?S"
        if not isinstance(p,set):
            return sRc
        sRc = "S:<"
        i = 0
        for x in p:
            if i > 0:
                sRc += ","
            if (p_bNum):
                sRc += "["
                sRc += str(i)
                sRc += "]:"
            sRc += ascii(x)
            i += 1
        sRc += ">"
        return sRc

    #   s:  string change

    def f_sChomp(self, p_sVal:str, p_bMark:bool = False) -> str:
        # lines with : '\r\n' '\r' or '\n'
        L = p_sVal.splitlines()
        sRc = ""
        iLen = len(L)
        i = 0
        for x in L:
            i += 1
            sRc += x
            if (p_bMark):
                if (i < iLen):
                    sRc += ';'
        # --- endFor
        return sRc

    def f_sTrim(self, p_sVal:str, p_bInside:bool = False) -> str:
        #   1. remove all white spaces
        #   2. in opposite to split() also inside the a string
        #       and replace multiple space with 1
        #   check
        sNone = ''
        if not isinstance(p_sVal,str):
            return sNone
        # p1: replace NL \r by ';'
        sRc = self.f_sChomp(p_sVal)
        # p2:   remove inprintable
        s = sRc
        sRc = ""
        for i in range(0,len(s)):
            c = s[i]
            bRc = c.isprintable()
            if (not bRc):
                continue
            sRc += c
        #   p3:   remove Space leading+trailing
        s = sRc
        lRc = s.strip()
        s   = ''.join(lRc)
        sRc = s
        #   p4: ? strip inside - replace n space with 1 ?
        if (p_bInside):
            sRc = ''
            for i in range(0,len(s)):
                c = s[i]
                if (i + 1 < len(s)):
                    cNext = s[i + 1]
                    if (c.isspace() and cNext.isspace()):
                        continue
                sRc += c
            # - endFor
        # - endIf
        return sRc

    def f_sReplace(self, p_sVal:str, p_cSep:str, p_iPos:int) -> str:
        # search in sVal cSep at position N
        sNone = ''
        if not isinstance(p_sVal,str):
            return sNone
        if not isinstance(p_cSep,str):
            return sNone
        if len(p_sVal) <= p_iPos:
            return sNone
        lTmp = list(p_sVal)
        lTmp[p_iPos] = p_cSep
        sRc = "".join(lTmp)
        return sRc


#   ===========================================================================
#   m:  class.converter
#   ===========================================================================

class CSequenceConverter:

    #
    #   === IN: s
    #

    def f_move_s2l(self,p_sVal:str) -> tuple[bool,list]:
        if ((type(p_sVal) is not str) or (len(p_sVal) == 0)):
            return False,[]
        lRc = list(p_sVal)
        #   lRc = list()
        #   for c in p_sVal:
        #       lRc.append(c)
        return True,lRc

    def f_move_s2t(self,p_sVal:str) -> tuple[bool,tuple]:
        if ((type(p_sVal) is not str) or (len(p_sVal) == 0)):
            return False,()
        tRc = tuple(p_sVal)
        return True,tRc

    #
    #   === IN: l
    #

    def f_move_l2s(self,p_lVal:list,p_cSep:str = '') -> tuple[bool,str]:
        if ((type(p_lVal) is not list) or (len(p_lVal) == 0)):
            return False,'?'
        sRc  = str()
        bSep = False
        bExt = (p_cSep is not None)
        for x in p_lVal:
            if (bExt):
                if (bSep):  sRc += p_cSep
                else:       bSep = not bSep
            sRc += str(x)
        #   sRc = "".join(p_lVal)
        return True,sRc

    def f_move_l2t(self,p_lVal:list) -> tuple[bool,tuple]:
        if ((type(p_lVal) is not list) or (len(p_lVal) == 0)):
            return False,()
        tRc = tuple(p_lVal)
        return True,tRc

    def f_move_l2e(self,p_lVal:list) -> tuple[bool,set]:
        if ((type(p_lVal) is not list) or (len(p_lVal) == 0)):
            return False,set()
        eRc = set(p_lVal)
        return True,eRc

    def f_move_l2h(self,p_lVal:list) -> tuple[bool,dict]:
        if ((type(p_lVal) is not list) or (len(p_lVal) == 0)):
            return False,{}
        hRc = dict.fromkeys(p_lVal)
        return True,hRc

    #
    #   === IN: t
    #

    def f_move_t2s(self, p_tVal:tuple, p_cSep:str = '') -> tuple[bool,str]:
        if ((type(p_tVal) is not tuple) or (len(p_tVal) == 0)):
            return False,""
        sRc  = str()
        bSep = False
        bExt = (p_cSep is not None)
        for e in p_tVal:
            if (bExt):
                if (bSep):  sRc += p_cSep
                else:       bSep = not bSep
            sRc += str(e)
        return True,sRc

    def f_move_t2l(self, p_tVal:tuple) -> tuple[bool,list]:
        if ((type(p_tVal) is not tuple) or (len(p_tVal) == 0)):
            return False,[]
        lRc = list(p_tVal)
        return True,lRc

    #   IN: e set:=enum
    def f_move_e2l(self, p_eVal:set) -> tuple[bool,list]:
        if ((type(p_eVal) is not set) or (len(p_eVal) == 0)):
            return False,[]
        eTmp = p_eVal.copy()
        lRc  = []
        for x in eTmp:
            lRc += [x]
        return True,lRc

    #   IN: h hash:=dictionary
    def f_move_h2l(self, p_hVal:dict) -> tuple[bool,list]:
        if ((type(p_hVal) is not dict) or (len(p_hVal) == 0)):
            return False,[]
        lRc  = []
        for x in p_hVal:
            xKey = x
            xVal = p_hVal[x]
            lRc.append(xKey)
            lRc.append(xVal)
        return True,lRc


class CArrayConverter:

    #
    #   === IN: string || list
    #

    def f_move_s2a(self,p_sVal:str) -> tuple[bool,array]:
        aRc = array('u',[])
        if ((type(p_sVal) is not str) or (len(p_sVal) == 0)):
            return False,aRc
        # array types {b, B, u, h, H, i, I, l, L, q, Q, f, d}
        aRc  = array('u',p_sVal)
        return True,aRc

    def f_move_l2a(self,p_lVal:list) -> tuple[bool,array]:
        aRc = array('u',[])
        if ((type(p_lVal) is not list) or (len(p_lVal) == 0)):
            return False,aRc
        _b,s,i,f = True,"t",123,1.23
        x = p_lVal[0]  # check first
        if type(x) == type(i):
            aRc  = array('i',p_lVal)
        elif type(x) == type(s):
            i = 0
            aRc  = array('u',x)
            for e in p_lVal:
                aRc += array('u',e)
        elif type(x) == type(i):
            aRc  = array('i',p_lVal)
        elif type(x) == type(f):
            aRc  = array('f',p_lVal)
        else:
            aRc  = array('i',p_lVal)
        return True,aRc

    #
    #   === IN: array
    #

    def f_move_a2s(self, p_asVal:array, p_cSep:str = '') -> tuple[bool,str]:
        if ((type(p_asVal) is not array) or (len(p_asVal) == 0)):
            return False,'?'
        sRc  = str()
        bSep = False
        bExt = (p_cSep is not None)
        for i in range(0,len(p_asVal)):
            if (bExt):
                if (bSep):  sRc += p_cSep
                else:       bSep = not bSep
            sRc += p_asVal[i]
        return True,sRc

    def f_move_a2l(self,p_aVal:array) -> tuple[bool,list]:
        #   a = array('i', [1, -4, 3])
        lRc: list = []
        if ((type(p_aVal) is not array) or (len(p_aVal) == 0)):
            return False,lRc
        lRc = p_aVal.tolist()
        return True,lRc


class CConverter(CSequenceConverter,CArrayConverter):
    m_iConverter = 0

#   ===========================================================================
#   m:  class.ctype
#   ===========================================================================

class CType:

    def f_isFct(self,p_sFct:str,p_sVal:str) -> tuple[bool,int]:
        #   returns (bRc,iIdx)
        bEc    = False  # noError
        iRc     = -1
        n       = len(p_sVal)   # 0...n-1
        for iIdx in range(0,n):
            bRc = False
            s   = p_sVal[iIdx]
            if p_sFct  == "isalnum":
                bRc = s.isalnum()
            elif p_sFct  == "isdigit":
                bRc = s.isdigit()
            elif p_sFct  == "isalpha":
                bRc = s.isalpha()
            elif p_sFct  == "isupper":
                bRc = s.isupper()
            elif p_sFct  == "islower":
                bRc = s.islower()
            elif p_sFct  == "istitle":
                bRc = s.istitle()
                #   The istitle() method returns True if
                #       all words in a text start with a
                #   upper case letter,
                #   AND the rest of the word are lower case letters,
                #   otherwise False.
                #   example "Peter Is At Home"
            elif p_sFct  == "isspace":
                bRc = s.isspace()
            elif p_sFct  == "isprint":
                bRc = s.isprintable()
            elif p_sFct  == "isgraph":
                i = ord(s)
                if (i > ord(' ')):
                    bRc = True
            elif p_sFct  == "iscntrl":
                i = ord(s)
                if (i < ord(' ')):
                    bRc = True
            elif p_sFct  == "ispunct":
                t = ('.',';',':')
                for e in t:
                    if s == e:
                        bRc = True
                        break
            elif p_sFct  == "isxdigit":
                if s.isalnum():
                    if s.isdigit():
                        bRc = True
                    else:
                        x = s.upper()
                        i = ord(x)
                        if ((i >= ord('A')) or (i <= ord('F'))):
                            bRc = True
            else:
                bEc = True  # make EXCEPTION ! !PHA:toDo
            if (bEc):
                iRc = -999
                break
            elif (not bRc):
                break
            #   print("loop:%d" % iIdx)
            iRc = iIdx + 1      # wieviele Werte ok

        return bRc, iRc
        #   f~isFct

#   ===========================================================================
#   m:  class.math
#   ===========================================================================

class CMath:

    __m_bRandomSeed = False
    C_LIST_number = [
        1102023313711321,
        2102023313556361,
        2133132415198713,
        2456241020233131,
        2102124102331313,
        2102023151513137,
        2102023313112511,
    ]

    def f_iRandom(self,p_iMax=1000,p_iMin=1) -> int:   # 1...10
        i,n = p_iMin,p_iMax
        if (not self.__m_bRandomSeed):
            #   random.seed(0)  # $CRQ-240403:should be real rand
            self.__m_bRandomSeed  = True
        iRc = random.randint(i,n)        # i...n
        return iRc

    def f_isPrime(self,n: int) -> bool:
        if n < 2:
            return False
        if n in {2, 3, 5, 7}:
            return True
        if n % 2 == 0 or n % 3 == 0 or n % 5 == 0 or n % 7 == 0:
            return False
        iUpperLimit = int(math.sqrt(n)) + 1
        return all(n % i != 0 for i in range(11, iUpperLimit, 2))

#   ===========================================================================
#   m:  class.help
#   ===========================================================================

class CHelp:

    def f_help(self) -> bool:
        """ docString:myLib of
            Python Library 2024-01-10
        """
        # usage:
        #   DOS> Python
        #   python> import(myLib)
        #   python> help (myLib)
        #   python< ... mit doc~String
        #   sys.exit()
        return True

    def f_hello(self) -> bool:
        print("LIB::class:HelloMyTutor2024")
        return True

    def f_who(self) -> None:
        print("who1:<%s>" % C_LABEL)
        s = os.path.dirname(sys.executable)
        print("installation DIR   : <%s>" % (s))
        s = sys.version
        print("interpreter version: <%s>" % (s))


#   ===========================================================================
#   m:  class.IOM
#   ===========================================================================

#   s:  io.open
#   Character Meaning
#       'r' :   open for reading (default)
#       'w' :   open for writing, truncating the file first
#       'a' :   open for writing, appending to the end of the file if it exists
#       'b' :   binary mode
#       't' :   text mode (default)
#       '+' :   open a disk file for updating (reading and writing)
#       'U' :   universal newlines mode (for backwards compatibility;

#   s:  io.flags
#       O_RDONLY    :   read
#       O_WRONLY    :   write
#       O_RDWR      :   read+write
#       O_CREAT     :   create, if not exist
#       O_APPEND    :   write appends at end of file

#   example: fp = os.open("myFile.txt", os.O_WRONLY|os.O_CREATE)


class CDir:

    def f_bIsDir(self,p_sDir:str) -> bool:
        return os.path.isdir(p_sDir)

    def f_bCd(self,p_sDir:str) -> bool:
        try:
            os.chdir(p_sDir)
        except Exception:
            return False    # "?Cd:"+p_sDir
        return True

    def f_sPwd(self) -> str:
        sRc = os.getcwd()
        return sRc

    def f_attribDir(self,p_sDir:str,p_cMode:str) -> tuple[bool,str]:
        #   Diese Funktion ersetzt den Aufruf
        #   sDir=<xyz.dir>
        #   os.system("attrib -R " + sDir + "\* /s")
        #   recursive set attributes
        c = p_cMode.upper()
        if c == 'R':
            iMod = 0o444
        elif c == 'W':
            iMod = 0o777
        else:
            return False,'?'
        # print("c:%s,iMode:%s" % (c,iMod))
        for sRoot, lDirs, lFiles in os.walk(p_sDir):
            for x in lDirs:
                os.chmod(os.path.join(sRoot, x), iMod)
            for x in lFiles:
                os.chmod(os.path.join(sRoot, x), iMod)
        return True,"$"

    def f_mkDir(self,p_sDir:str) -> tuple[bool,str]:
        if os.path.isdir(p_sDir):
            return True,"!isDirAlready"
        try:
            os.mkdir(p_sDir)
        except Exception as e:
            return False,str(e)
        if (not os.path.isdir(p_sDir)):
            return False,"?not makeDir"
        return True,"$"


class CFile:

    m_cDriveSeparator = ":"
    m_cFileExtensionSeparator = '.'

    def f_bIsFile(self,p_sFile:str) -> bool:
        return os.path.isfile(p_sFile)

    def f_cFilePathSep(self) -> str:
        return os.sep

    def f_sFile(self,s:str) -> str:
        return self.f_sFileName(s)

    def f_sFilePath(self,p_sFile:str) -> str:
        sRc = os.path.abspath(p_sFile)
        return sRc

    def f_sFilePath_make(self,p_sDir:str,p_sFile:str) -> str:
        sFile = os.path.basename(p_sFile)
        sRc = p_sDir
        if (p_sDir[len(p_sDir) - 1] != os.path.sep):
            sRc += os.path.sep
        sRc += sFile
        return sRc

    def f_sFilePathDrive(self,p_sFilePath:str) -> str:
        sNone  = '?'
        cSep = self.m_cFileExtensionSeparator
        sFilePath = os.path.abspath(p_sFilePath)  # get real
        tRc = sFilePath.partition(cSep)
        if (len(tRc) < 2):
            return sNone
        return tRc[0]

    def f_sFileName(self,p_sFilePath:str) -> str:
        sFilePath = os.path.abspath(p_sFilePath)
        sRc = os.path.basename(sFilePath)
        return sRc

    def f_sDirName(self,p_sFilePath:str) -> str:
        sRc = os.path.dirname(p_sFilePath)
        return sRc

    def f_sFileNameBody(self,p_sFile:str) -> str:
        sNone  = '?'
        cSep = self.m_cFileExtensionSeparator
        sFileName = os.path.basename(p_sFile)
        tRc = sFileName.partition(cSep)
        if (len(tRc) < 2):
            return sNone
        return tRc[0]

    def f_sFileNameExtension(self,p_sFile:str) -> str:
        sNone   = '?'
        cSep        = self.m_cFileExtensionSeparator
        sFileName   = os.path.basename(p_sFile)
        tRc = sFileName.partition(cSep)
        if (len(tRc) < 2):
            return sNone
        sRc = cSep + tRc[2]
        return sRc      # in:file.txt; out:.txt

    def f_bFileExists(self,p_sFile:str) -> bool:
        bRc = os.path.exists(p_sFile)
        if (not bRc):
            return False
        bRc = os.path.isfile(p_sFile)
        if (not bRc):
            return False
        bRc = os.access(p_sFile, os.R_OK)
        if (not bRc):
            return False
        return True

    def f_bhFilePath_member(self,p_sFilePath:str,p_bCheck:bool = False) \
                                -> tuple[bool,dict]:
        #   IN  d:/tmp/otto.txt
        if p_bCheck:
            bRc = self.f_bFileExists(p_sFilePath)
            if (not bRc):
                return False,{}
        else:
            bRc = True

        sPth        = os.path.abspath(p_sFilePath)
        sNam        = os.path.basename(p_sFilePath)
        sExt        = self.f_sFileNameExtension(p_sFilePath)
        sBdy        = self.f_sFileNameBody(p_sFilePath)
        iLen        = len(sPth) - len(sNam)
        sDir        = sPth[0:iLen - 1]      # adjust
        hRc = {
                'm_sPth' : sPth,        # d:/tmp/otto.txt
                'm_sDir' : sDir,        # d:/tmp
                'm_sNam' : sNam,        # otto.txt
                'm_sBdy' : sBdy,        # otto
                'm_sExt' : sExt         # .txt
        }
        return bRc,hRc


    def f_sJoinFilePath(self, p_sDir:str, p_sFnm:str) -> str:
        #   fJoin('d:\tmp'.'otto.txt') => d:\tmp\otto.txt
        cSep    =   self.f_cFilePathSep()
        s       =   p_sDir
        if ( len(s) == cSep ) :
            s = s[0:len(s) - 1]     # cut last
        s = s + cSep
        s = s + p_sFnm
        return s



class CIom(CBase,CDir,CFile):

    m_iIom = 0

    #   --- dir

    def f_rmDir(self,p_sDir:str) -> tuple[bool,str]:
        if not os.path.isdir(p_sDir):
            return False,"?isDir"
        bOsPosix = self.f__bIsPosix()
        if (not bOsPosix):
            os.system("attrib -R " + p_sDir + '/* /s')   # $CRQ-231210:DirSep
        try:
            shutil.rmtree(p_sDir,ignore_errors=True)
        except Exception as e:
            return False,str(e)
        if os.path.isdir(p_sDir):
            return False,"?not removed"
        return True,"$"

    #   --- file

    def f_bFileCreate(self,p_sFile:str,p_bOvw:bool = False) -> tuple[bool,str]:
        if (self.f_bFileExists(p_sFile)):
            if not p_bOvw:
                return True,"!FileAlreadyExists"
        try:
            fp = open(p_sFile,'w+')
        except Exception:
            return False,'?CreateFile'
        fp.close()
        #   check again
        if (not (self.f_bFileExists(p_sFile))) :
            return False,"?CreateFileAndCheck"
        #   ok
        return True,"$"

    def f_bFileDelete(self,p_sFile:str) -> tuple[bool,str]:
        bRc = self.f_bFileExists(p_sFile)
        if not bRc:
            return False,"?os.path.isfile"
        try:
            os.remove(p_sFile)
        except Exception as iExc:
            return False,str(iExc)
        if not os.path.isfile(p_sFile):
            return False,"?os.path.isfile2"
        return True,"$"

    def f_bFileMove(self,p_sFilePath_src:str,p_sDir_obj:str) -> tuple[bool,str]:
        if not os.path.isdir(p_sDir_obj):
            return False,"?DirExists"
        if not self.f_bFileExists(p_sFilePath_src):
            return False,"?FileExists:"     # p_sFilePath_src
        sFileName_src   = self.f_sFileName(p_sFilePath_src)
        sFilePath_obj   = self.f_sFilePath_make(p_sDir_obj,sFileName_src)
        if not self.f_bFileDelete(sFilePath_obj):
            return False,"?FileDelete"
        try:
            shutil.move(p_sFilePath_src,p_sDir_obj)
        except Exception as e:
            return False,str(e)
        return True,"$"

    def f_iFileWrite(self,p_sFile:str,p_sBuffer:str) -> int:
        bFile = self.f_bFileExists(p_sFile)
        if not bFile:
            return -1
        fp = open(p_sFile,'a')
        assert (fp != 0)
        s = "%s" % p_sBuffer
        fp.write(s)
        fp.close()
        iRc = os.path.getsize(p_sFile)
        return iRc

    def f_sFileRead(self,p_sFile:str) -> tuple[int,str]:
        fp = open(p_sFile,'r')
        assert (fp != 0)
        sBuffer = fp.read(-1)   # read the whole file
        fp.close()
        iRc = os.path.getsize(p_sFile)
        return iRc,sBuffer

    def f_iFileSize(self,p_sFile:str) -> int:
        bRc = os.path.isfile(p_sFile)
        if (not bRc):
            return -1
        return os.path.getsize(p_sFile)

#   ===========================================================================
#   m:  class.Timer
#   ===========================================================================

class CDateTime:

    __m_tDTM    = datetime.now()

    def f_sFileTime(self,p_sFile:str, p_sFmt:str = '%Y-%m-%d,%H:%M:%S') -> str:
        pDtm    = os.path.getmtime(p_sFile)
        tTime   = time.gmtime(pDtm)
        sTime   = time.strftime(p_sFmt,tTime)
        return sTime

    def f_sDateTime(self,
            p_tDtm:datetime = None,
            p_sFmt:str = "%y%m%d.%H%M%S") -> str:
        if (p_tDtm is None):
            tDtm = datetime.now().replace(microsecond=0)
        else:
            tDtm = p_tDtm
        tDtm = tDtm.replace(microsecond=0)
        s  = tDtm.strftime(p_sFmt)
        return s

    def f__sGetDtm(self, p_sFmt:str) -> str:
        dtm = datetime.now()            # 2024-02-07 15:22:42.612130
        self.__m_tDTM = dtm             # save
        sMs = dtm.strftime("%f")        # =>  612130
        sMs = sMs[:2]                   # =>  61
        iMs = int(sMs) % 60             # =>  0..59
        sf  = "_%02d" % (iMs)           # $CRQ-200804:better as format(i,"2d")
        s   = dtm.strftime(p_sFmt)
        s += sf
        return s

    def f_sNow(self,p_sFmt:str = "%y%m%d.%H%M%S") -> str:
        pDtm = datetime.now()
        self.__m_tDTM =  pDtm             # save
        sRc = pDtm.strftime(p_sFmt)
        return sRc

    def f_sNowDiff(self,p_sFmt:str = "%y%m%d.%H%M%S") -> tuple[str,str]:
        pDtm = datetime.now()
        sDtm = pDtm.strftime(p_sFmt)
        fSub = (pDtm - self.__m_tDTM).total_seconds()
        iSub = math.trunc(fSub)
        sSub = str(iSub)
        return sDtm,sSub


class CTimer:

    __tDTM_ini = datetime.now()
    __tDTM_now = datetime.now()

    def f_sTime(self, p_tDtm:datetime = None) -> str:
        if (p_tDtm is None):
            __tDTM_now = datetime.now()
        else:
            __tDTM_now = p_tDtm
        s   = __tDTM_now.strftime("%H:%M:%S.%f")
        s   = s[:-3]
        return s

    def f_sDate(self,p_tDtm:datetime = None) -> str:
        if (p_tDtm is None):
            __tDTM_now = datetime.now()
        else:
            __tDTM_now = p_tDtm
        s   = __tDTM_now.strftime("%y-%m-%d")
        return s

    def f_iDtm2Unix(self,p_tDtm:datetime = None) -> int:
        #   calcs difference NOW-1970
        if (p_tDtm is None):
            __tDTM_now = datetime.now()
        else:
            __tDTM_now = p_tDtm
        tNow  = __tDTM_now
        tUnx  = datetime(1970, 1, 1)
        _iRc  = -1
        t     = tNow - tUnx
        #   Anstelle von ys benoetigen wir msec
        fMs  = 1000 * (t.days * 24 * 60 * 60
                       + t.seconds) + (t.microseconds / 1000)
        iMs  = round(fMs)
        #   print("DT:%f=%d" % (fMs,iMs))
        return iMs

    def f_iDtm_start(self) -> datetime:
        dtm = self.__tDTM_ini
        self.__tDTM_ini = datetime.now()  # run new diff
        return dtm  # returns old one

    def f_iDtm_stop(self) -> int:
        self.__tDTM_now = datetime.now()  # run new diff
        iIni = self.f_iDtm2Unix(self.__tDTM_ini)
        iNow = self.f_iDtm2Unix(self.__tDTM_now)
        return iNow - iIni


#   ===========================================================================
#   m:  class.menu
#   ===========================================================================

class CMode(CBase):

    __m_bModeBatch      = False
    __m_bModeVerbose    = False
    __m_bModeColor      = False
    __m_iModeLogging    = 0
    __m_bVerboseInfo    = False     # only if verbose
    __m_bVerboseTrace   = False

    #
    #   f:  mode.batch
    #

    def f__modeBatch_get(self) -> bool:
        bRc = self.__m_bModeBatch
        return bRc

    #
    #   f:  mode.color
    #

    def f__modeColor_get(self) -> bool:
        bRc = self.__m_bModeColor
        return bRc

    def f__modeColor_set(self,p_bColor:bool = False) -> bool:
        if (self.__m_bModeBatch):
            return False
        self.__m_bModeColor = p_bColor
        return True

    #
    #   f:  mode.verbose
    #

    def f__modeVerbose_get(self) -> bool:
        return self.__m_bModeVerbose

    def f__modeVerboseInfo(self) -> bool:
        return self.__m_bVerboseInfo

    def f__modeVerboseTrace(self) -> bool:
        return self.__m_bVerboseTrace

    def f__modeVerbose_set(self,p_bVerbose:bool = False) -> None:
        self.__m_bModeVerbose   = p_bVerbose
        self.__m_bVerboseInfo   = p_bVerbose
        self.__m_bVerboseTrace  = p_bVerbose
        return None

    #
    #   f: base.logging
    #

    def f__modeLogging_get(self) -> tuple[bool,int]:
        bLog = False
        iLog = self.__m_iModeLogging
        if (iLog > 0) :
            bLog = True
        return bLog,iLog

    def f__modeLogging_set(self,p_iLogMode:int) -> None:
        if ((p_iLogMode >= 0) and (p_iLogMode <= 2)) :
            self.__m_iModeLogging = p_iLogMode
        return None

    #
    #   f: base.environment
    #

    def f_lib_prepare(self) -> None:
        self.__m_bModeBatch     =   self.f__bOsVariable(g_bMode_batch)
        self.__m_bModeColor     =   self.f__bOsVariable(g_bMode_color)
        self.__m_bModeVerbose   =   self.f__bOsVariable(g_bMode_verbose)
        bLog,iLog = self.f__iOsVariable(g_iMode_logging)
        if ( bLog ) :
            self.__m_iModeLogging  = iLog
        return None

    #       p_bInfo:bool = False,           #   beides verbose
    #       p_bTrace:bool = False,
    def f_lib_configuration(self,
                            p_bColor:bool = False,
                            p_bVerbose:bool = False,
                            p_iLog:int = 0 ) -> None:
        self.f__modeColor_set(p_bColor)
        self.f__modeVerbose_set(p_bVerbose)
        self.f__modeLogging_set(p_iLog)
        return None

    def f_lib_verbose(self, p_bInfo:bool = False, p_bTrace:bool = False) -> None:
        bVerbose = self.f__modeVerbose_get()
        if bVerbose :
            self.__m_bVerboseInfo   = p_bInfo
            self.__m_bVerboseTrace  = p_bTrace
        return None


#   c:  --- class.Print

class CPrint(CMode):

    C_COLOR_NONE            = 'E_none'
    C_COLOR_BLACK           = 'E_black'
    C_COLOR_RED             = 'E_red'
    C_COLOR_RED_DARK        = 'E_red_dark'
    C_COLOR_GREEN           = 'E_green'
    C_COLOR_GREEN_DARK      = 'E_green_dark'
    C_COLOR_YELLOW          = 'E_yellow'
    C_COLOR_BLUE            = 'E_blue'
    C_COLOR_BLUE_DARK       = 'E_blue_dark'
    C_COLOR_MAGENTA         = 'E_magenta'
    C_COLOR_CYAN            = 'E_cyan'
    C_COLOR_CYAN_DARK       = 'E_cyan_dark'
    C_COLOR_WHITE           = 'E_white'
    C_COLOR_WHITE_DARK      = 'E_white_dark'
    C_COLOR_GRAY            = 'E_gray'

    def __print(self,p_sEscString:str) -> bool:
        print(p_sEscString,end='')
        return True

#   $URL:https://pypi.org/project/colorama/

    def f_print(self,p_sString:str,
                p_sColor:str = '', p_bNL:bool = False) -> None:

        # *u01*  color?
        bColor = False
        if ((p_sColor != '') and (p_sColor != self.C_COLOR_NONE)):
            bColor = self.f__modeColor_get()

        # *u02*  print.noColorMode
        if (not bool(bColor)):      # $CRQ-200824
            if (p_bNL):
                print(p_sString)
            else:
                print(p_sString,end='')
            return

        # *u03*  ColorMode - try import
        bEc = False
        try:
            import colorama
            colorama.init()
            from colorama import Back
            from colorama import Fore
            from colorama import Style
        except Exception:
            bEc = True

        # *u04*  print.ColorMode && exception
        if (bEc):
            if (p_bNL):
                print(p_sString)
            else:
                print(p_sString,end='')
            return None

        # *u05*  print.ColorMode
        if p_sColor == self.C_COLOR_BLACK:
            self.__print(Style.BRIGHT)
            self.__print(Fore.BLACK + p_sString)
        elif p_sColor == self.C_COLOR_RED:
            self.__print(Style.BRIGHT)
            self.__print(Fore.RED + p_sString)
        elif p_sColor == self.C_COLOR_GREEN:
            self.__print(Style.BRIGHT)
            self.__print(Fore.GREEN + p_sString)
        elif p_sColor == self.C_COLOR_YELLOW:
            self.__print(Style.BRIGHT)
            self.__print(Fore.YELLOW + p_sString)
        elif p_sColor == self.C_COLOR_BLUE:
            self.__print(Style.BRIGHT)
            self.__print(Fore.BLUE + p_sString)
        elif p_sColor == self.C_COLOR_MAGENTA:
            self.__print(Style.BRIGHT)
            self.__print(Fore.MAGENTA + p_sString)
        elif p_sColor == self.C_COLOR_CYAN:
            self.__print(Style.BRIGHT)
            self.__print(Fore.CYAN + p_sString)
        elif p_sColor == self.C_COLOR_WHITE:
            self.__print(Style.BRIGHT)
            self.__print(Fore.WHITE + p_sString)
#   specials
        elif p_sColor == self.C_COLOR_RED_DARK:
            self.__print(Style.NORMAL)
            self.__print(Fore.RED + p_sString)
        elif p_sColor == self.C_COLOR_GREEN_DARK:
            self.__print(Style.DIM)
            self.__print(Fore.GREEN + p_sString)
        elif p_sColor == self.C_COLOR_BLUE_DARK:
            self.__print(Style.DIM)
            self.__print(Fore.BLUE + p_sString)
        elif p_sColor == self.C_COLOR_WHITE_DARK:
            self.__print(Style.NORMAL)
            self.__print(Fore.WHITE + p_sString)
#   specials.Gray
        elif p_sColor == self.C_COLOR_GRAY:     # !CRQ-241212:addGray
            self.__print(Style.DIM)
            self.__print(Fore.WHITE + p_sString)
        else:
            print(Fore.WHITE + Back.BLACK + p_sString,end='')

        # *u06*  print.NEWLINE in ColorMode
        if (p_bNL):
            print(Style.RESET_ALL)
        else:
            print(Style.RESET_ALL,end='')
        return

    def f_puts(self,p_sString:str, p_sColor:str = '') -> None:
        bColor = False
        if (p_sColor != ''):
            bColor = self.f__modeColor_get()
        if (bColor):
            self.f_print(p_sString, p_sColor, True)
        else:
            print(p_sString)
        return

    def f_textmode(self,p_bColor:bool = False) -> bool:
        if (p_bColor):
            self.f__modeColor_set(True)
        return p_bColor

    def f_colorTest(self) -> bool:
        i = 0
        i += 1; self.f_puts("%2.2d:\tblack" % (i),self.C_COLOR_BLACK)
        i += 1; self.f_puts("%2.2d:\tred" % (i),self.C_COLOR_RED)
        i += 1; self.f_puts("%2.2d:\tDark-Red" % (i),self.C_COLOR_RED_DARK)
        i += 1; self.f_puts("%2.2d:\tgreen" % (i),self.C_COLOR_GREEN)
        i += 1; self.f_puts("%2.2d:\tDark-Green" % (i),self.C_COLOR_GREEN_DARK)
        i += 1; self.f_puts("%2.2d:\tyellow" % (i),self.C_COLOR_YELLOW)
        i += 1; self.f_puts("%2.2d:\tblue" % (i),self.C_COLOR_BLUE)
        i += 1; self.f_puts("%2.2d:\tDark-Blue" % (i),self.C_COLOR_BLUE_DARK)
        i += 1; self.f_puts("%2.2d:\tmagenta" % (i),self.C_COLOR_MAGENTA)
        i += 1; self.f_puts("%2.2d:\tcyan" % (i),self.C_COLOR_CYAN)
        i += 1; self.f_puts("%2.2d:\twhite" % (i),self.C_COLOR_WHITE)
        i += 1; self.f_puts("%2.2d:\tDark-White" % (i),self.C_COLOR_WHITE_DARK)
        return True


class CLogging(CStack,CPrint,CDateTime,CFile):

    __m_bLogfile        = False
    __m_sLogfile        = "Tutor.log"

    def f_sLogDirectory(self) -> str:   # $CRQ-240118:logDir
        return self.f__sOsDirTmp()

    def f_sLogFile_get(self) -> str:
        return self.__m_sLogfile

    def f_sLogFile_set(self,p_sString:str) -> None:
        self.__m_sLogfile  = p_sString
        return None

    #   write text onto screen and into logFile - standard
    def f_fputs(self, p_sString:str, p_sColor:str = '') -> None:
        #   s:  print at screen
        self.f_puts(p_sString,p_sColor)
        #   s:  log string?!
        if (self.__m_bLogfile):
            s = "%s\n" % p_sString
            fp = open(self.__m_sLogfile,'a')
            assert (not fp == 0)
            fp.write(s)
        return None

    #   write text only into logFile
    def f_logs(self, p_sString:str) -> None:
        if (self.__m_bLogfile):
            s  = "%s\n" % p_sString
            fp = open(self.__m_sLogfile,'a')
            assert (not fp == 0)
            fp.write(s)
        return None

    def f_createLogfile(self, p_sString:str) -> bool:
        #   logMode?
        bLog = self.f__modeLogging_get()
        if (not bLog):
            return False
        #   already created ?
        if (self.__m_bLogfile):
            return False
        #   save new LogFileName
        self.f_sLogFile_set(p_sString)
        pLog =  self.f_sLogFile_get()
        #   create and overwrite any old logfile
        try:
            fp = open(pLog,'w+')
        except Exception:
            return False
        #   write into new logfile
        sFnm = "*** automatically File:'%s' " % pLog
        sDtm = self.f_sDateTime(None,"%Y.%m.%d---%H:%M:%S")
        sDtm = "created at:[%s]\n" % sDtm
        s    = sFnm + sDtm
        fp.write(s)
        fp.close()
        #   store status
        self.__m_bLogfile = True
        return True


class CMenuHelper(CSys,CLogging):

    def f_status(self) -> None:
        bBat = self.f__modeBatch_get()
        bClr = self.f__modeColor_get()
        bVbs = self.f__modeVerbose_get()
        bLog,iLog = self.f__modeLogging_get()
        bInf = self.f__modeVerboseInfo()
        bTrc = self.f__modeVerboseTrace()
#       s = '<<< i:  status {bBat|bVbs|bClr|iLog} = ' {[%r]:[%r]:[%r]:[%d]}" % (bBat,bVbs,bClr,iLog)
        s,sFile,sLine,sFunc = self.f_tLoc()
        s,sFile,sLine,sFunc = self.f_tLoc()
        sTxt = 'status {bBat|bClr|bVbs|iLog|bInf|bTrc} = '
        sTxt += "{%r,%r,%r,%d,%r,%r}" % (bBat,bClr,bVbs,iLog,bInf,bTrc)
        s = "<<< s:  %s \n\tat:[%s;%s;%s]" % (sTxt,sFile,sFunc,sLine)
        self.f_fputs("%s" % s,self.C_COLOR_YELLOW)
        return None

    def f_info(self, p_sTxt:str = '?t') -> bool:
        bInf = self.f__modeVerboseInfo()
        if (not bInf):
            return False
        s,sFile,sLine,sFunc = self.f_tLoc()
        s = 4 * ' '
        s += "i:  %s at:[%s]" % (p_sTxt,sLine)
        self.f_puts(s,self.C_COLOR_GRAY)        # !CRQ-241212:yellow-gray
        return True

    def f_trace(self, p_sTxt:str = '?t',/,p_bEnabled:bool = True) -> bool:
        bTrc = self.f__modeVerboseTrace()
        if ((not p_bEnabled) or (not bTrc)):
            return False
        s,sFile,sLine,sFunc = self.f_tLoc()
        s = 4 * ' '
        s += "t:  %s at:[%s;%s;%s]" % (p_sTxt,sFile,sFunc,sLine)
        self.f_puts(s,self.C_COLOR_MAGENTA)
        return True

    def f_warning(self,p_sTxt:str = '?w') -> None:
        s,sFile,sLine,_sFunc = self.f_tLoc()
        s = "<<< b:  WARNING('%s') at:[%s;%s]" % (p_sTxt,sFile,sLine)
        self.f_puts("%s" % s,self.C_COLOR_YELLOW)
        return None

    def f_error(self,p_sTxt:str = '?e') -> None:
        s,sFile,sLine,_sFunc = self.f_tLoc()
        s = "<<< b:  ERROR('%s') at:[%s;%s]" % (p_sTxt,sFile,sLine)
        self.f_puts("%s" % s,self.C_COLOR_RED)
        self.f__exit()
        return None

    def f_bug(self,p_sTxt:str = '?b') -> None:
        s,sFile,sLine,_sFunc = self.f_tLoc()
        s = "<<< b:  BUG('%s') at:[%s;%s]" % (p_sTxt,sFile,sLine)
        self.f_puts("%s" % s,self.C_COLOR_RED)
        self.f__exit()
        return None

    def f_exit(self, p_iEc:int = -999, p_sTxt:str = '') -> None:
        if p_sTxt == '':
            p_sTxt = 'ANYREASON'
        if p_iEc == -999:
            iEc = self.f_iLine()
            sEc = '?NO'
        elif p_iEc == C_EC_OK:
            iEc = int(g_iEc)
            sEc = '!OK'
        elif p_iEc > 0:
            iEc = int(p_iEc)
            sEc = '+GT'
        else:
            iEc = -1
            sEc = '?EC'
        s,sFile,sLine,_sFunc = self.f_tLoc()
        s = "<<< e:  EXIT('%s'):=<%s;%i> at:[%s;%s]" \
            % (p_sTxt,sEc,iEc,sFile,sLine)
        self.f_puts(s,self.C_COLOR_RED_DARK)
        self.f__exit()
        return None


class CMenu(CMenuHelper):

    __m_iEc             = g_iEc
    __m_sTab            = '    '      # 4 chars
    __m_sTab2           = '        '  # 8 chars
    __m_iMenu           = 0
    __m_iMenuS1         = 0
    __m_iMenuS2         = 0
    __m_iMenuS3         = 0
    __m_sFileName       = ''
    __m_sFileTime       = ''
    __m_btextmode_lineNo    = False

    def f_header(self,p_sText:str = "?H",/,
                 p_bColor:bool = False, p_bClear:bool = False) -> None:

        #   init my class members
        self.__m_iMenu = 0
        self.__m_iMenuS1 = 0
        self.__m_iMenuS2 = 0
        self.__m_iMenuS3 = 0

        #   fetch my Environment
        self.f_lib_prepare()
        bBatch = self.f__modeBatch_get()

        #   clear Screen ? or color
        if (not bBatch):
            if (p_bClear):
                self.f_clearSreen()
            if (p_bColor):
                self.f__modeColor_set(True)

        #   verbose? : !CRQ-241212: verboseByArg
        bVerbose = self.f__modeVerbose_get()
        if ( bVerbose ) :
            self.f_lib_verbose(True,True)

        ##   get my File
        sLoc,sTcFile,_sLine,_sFunc = self.f_tLoc()

        #   get FileTime and save
        sTime   = self.f_sFileTime(__file__,p_sFmt='%y%m%d:%H%M')
        self.__m_sFileName  = os.path.basename(__file__)
        self.__m_sFileTime  = sTime

        #   now
        sDtm  = self.f_sNow(p_sFmt='%y%m%d%H%M%S')

        #   my ErrorCode
        iEc  = self.__m_iEc

        #   get logMode and create first
        bLog,iLog = self.f__modeLogging_get()
        if ( bLog ) :
            sBdy    = self.f_sFileNameBody(sTcFile)
            sFile   = sBdy
            if ( iLog > 1 ) :
                sFile   += '_' + sDtm
            sFile  += ".log"
            sDir    = self.f_sLogDirectory()        # $CRQ-240118:logDir
            sFile   = sDir + '/' + sFile
            bRc = self.f_createLogfile(sFile)
            if (not bRc) :
                self.f_bug('createLogFile')


        #   prepare my logFile --- not used!
        s  = "=== h:  BEG:{%s}:%s:'%s':E=<%3.3d>" % (sLoc,sDtm,p_sText,iEc)

        #   show infoText
        self.f_fputs(s,self.C_COLOR_GREEN)

        #   ready header
        return None


    def f_footer(self,p_sText:str = "?F",/,*,p_bInfo:bool = True) -> None:
        if (p_bInfo):
            s  = 4 * ' '
            s  += "f:  %s(%s)" % (self.__m_sFileName,self.__m_sFileTime)
            self.f_fputs(s,self.C_COLOR_BLUE)
            time.sleep(1)
        sLoc,_sFile,_sLine,_sFunc     = self.f_tLoc()
        sDtm,sDiff  = self.f_sNowDiff('%y%m%d%H%M%S')
        #   logging ?
        bLog,iLog = self.f__modeLogging_get()
        if (bLog) :
            pLog =  self.f_sLogFile_get()
            s  = 4 * ' '
            s  += "i:  logged into File:<%s>" % pLog
            self.f_puts(s,self.C_COLOR_BLUE)
        #   show
        s  = "=== h:  END:{%s}:%s<%s>:'%s'" % (sLoc,sDtm,sDiff,p_sText)
        self.f_fputs(s,self.C_COLOR_GREEN)
        self.f__exit(g_iEc)
        return None

    def f_finish(self,p_sTxt:str = "?S",/) -> None:
        sLoc,_sFile,_sLine,_sFunc     = self.f_tLoc()
        sDtm = self.f_sNow('%y%m%d%H%M%S')
        s  = "<== m:  STP:{%s}:%s:[%s]" % (sLoc,sDtm,p_sTxt)
        sEc = C_EC_OK
        self.f_fputs(s,self.C_COLOR_YELLOW)
        self.f__exit(sEc)
        return None

    def f_menu(self,p_sTxt:str = '?M',/,*,p_bNL:bool = False) -> None:
        iLine = self.f_iLine()  # $CRQ-240424
        self.__m_iMenuS1 = 0
        self.__m_iMenu += 1
        s  = "--- m:  m%2.2d:\t'%s' at:[%i]" % (self.__m_iMenu,p_sTxt,iLine)
        if (p_bNL):      # $CRQ-240208
            s = '\n' + s + '\n'
        self.f_fputs(s,self.C_COLOR_GREEN)
        return None

    def f_menuS1(self,p_sTxt:str = '?S',/,*,p_bNL:bool = False) -> None:
        iLine = self.f_iLine()
        #   p.clear
        self.__m_iMenuS1 += 1
        self.__m_iMenuS2 = 0
        s  = "    s:  s%2.2d.%d:\t'%s' [%i]" \
                % (self.__m_iMenu,self.__m_iMenuS1,p_sTxt,iLine)
        if (p_bNL):      # $CRQ-240208
            s = '\n' + s + '\n'
        self.f_fputs(s,self.C_COLOR_GREEN)
        return None

    def f_menuS2(self, p_sTxt:str = '?U',/) -> None:
        iLine = self.f_iLine()
        self.__m_iMenuS2 += 1
        self.__m_iMenuS3 = 0
        s  = ("    u:  u%2.2d.%d.%d [%i]:\t'%s'") \
            % (self.__m_iMenu,self.__m_iMenuS1,self.__m_iMenuS2,iLine,p_sTxt)
        self.f_fputs(s,self.C_COLOR_GREEN_DARK)
        return None

    def f_menuS3(self, p_sTxt:str = '?V',/) -> None:
        self.__m_iMenuS3 += 1
        s  = ("=== v:  u%2.2d.%d.%d.%d:\t%s") \
            % (self.__m_iMenu,
               self.__m_iMenuS1,
               self.__m_iMenuS2,
               self.__m_iMenuS3,
               p_sTxt)
        self.f_fputs(s,self.C_COLOR_GREEN_DARK)
        return None

    def f_text(self,
                p_sTxt:str = '?T',/,
                p_sColor:str = '',
                *,p_bEnabled:bool = True) -> None:
        if (not p_bEnabled):
            return
        iLine = self.f_iLine()
        bColor = self.f__modeColor_get()
        if (bColor):
            s  = "%s%s" % (self.__m_sTab2,p_sTxt)
            self.f_print(s,p_sColor)
            s  = "%s[%i]" % (self.__m_sTab,iLine)
            self.f_puts(s,self.C_COLOR_WHITE_DARK)
        else:
            if (self.__m_btextmode_lineNo):
                s  = "*** *** %s [%i]" % (p_sTxt,iLine)
            else:
                s  = "%s%s" % (self.__m_sTab2,p_sTxt)
            self.f_puts(s)
        #   logging
        s  = "%s[%i]:%s" % (self.__m_sTab2,iLine,p_sTxt)
        self.f_logs(s)
        return None

    def f_textModeStatus(self, p_sTxt:str) -> None:
        bColor = self.f__modeColor_get()
        s  = (("=== texmode(%s):  bColor:<%r>") % (p_sTxt,bColor))
        self.f_fputs(s,self.C_COLOR_YELLOW)
        return None

#   ===========================================================================
#   m:  class.Zip
#   ===========================================================================

class CZip(CIom,CPrint):

    #   own trace
    def f_show(self, p_sText:str, p_bVerbose:bool = True) -> None:
        self.f_puts(p_sText)
        return None

    #   INI => ZIP
    def f_zipPack(self,
                p_lFiles:list,*,
                p_sFile:str = 'tmp.zip',
                p_bFlat:bool = False,
                p_bVerbose:bool = True) -> int:
        fp = zipfile.ZipFile(p_sFile, mode='w')
        assert (fp != 0)
        iRc = 0
        for x in p_lFiles:
            iRc += 1
            self.f_show(("\tzipPackFile[%d]:%s" % (iRc,x)),p_bVerbose)
            if (p_bFlat):
                fp.write(x,os.path.basename(x))
                s = "zip.Write<Flt>[%d] => '%s'" % (iRc,x)
            else:
                fp.write(x)
                s = "zip.Write<Std>[%d] => '%s'" % (iRc,x)
        if iRc > 0 :
            s = "\t" + s
            self.f_show(s,p_bVerbose)
        fp.close()
        return (iRc)

    #   parse ZIP - keyword Mandatory
    def f_zipInfo(self, p_sFile:str = 'tmp.zip', p_bVerbose:bool = True) -> int:
        #   info of zipFile meta Data
        iRc = -1
        if (not os.path.isfile(p_sFile)):
            self.f_show(("? noFile:'%s'" % p_sFile),p_bVerbose)
            return iRc
        if (p_bVerbose):
            self.f_puts("\trunZipFile=:<%s>" % (p_sFile))
        fp = zipfile.ZipFile(p_sFile, mode='r')
        iRc = 0
        for x in fp.infolist():
            iRc += 1
            sFnm  = x.filename
            _sCpr = x.compress_size
            iFsz  = x.file_size
            self.f_print("\t--- zipInfo.file[%d]:='%s' bytes=:%s\n"
                        % (iRc,sFnm,iFsz))
        return iRc

    #   ZIP => directory
    def f_zipExtract(self,
            p_sDir2Unzip:str,
            p_sFile:str = 'tmp.zip',
            p_bVerbose:bool = True) -> int:
        iRc = -1
        if (not os.path.isdir(p_sDir2Unzip)):
            self.f_show(("? noDir:'%s'" % p_sDir2Unzip),p_bVerbose)
            return iRc
        self.f_show(("zipExtract => '%s'" % p_sFile),p_bVerbose)
        fp = zipfile.ZipFile(p_sFile, mode='r')
        iRc = 0
        for xFile in fp.namelist():
            iRc += 1
            fp.extract(xFile,p_sDir2Unzip)
            self.f_show(("extractedFile[%d] = '%s'" % (iRc,p_sFile)),p_bVerbose)
        fp.close()
        return iRc


#   ===========================================================================
#   m:  class.common
#   ===========================================================================


class CCommon(CMenu,CTimer,CString,CMath,CType,CConverter):

    m_iCommon = 0

#   ===========================================================================
#   m:  class.test
#   ===========================================================================


class CTestLibHelper(CCommon):

    m_iHelper = 0

#   create a file and write dummy data
    def f_test_bFileMake(self,
                p_pFile:str,
                p_iMode:int = 0,
                p_iSize:int = 100,
                p_bRand:bool = False) -> bool:
        if (p_bRand) :
            n  = self.f_iRandom(p_iSize)  # 1..max
        else :
            n  = p_iSize
        #   handle
        if (p_iMode == 1) :     #   text
            try:
                fp = open(p_pFile,'w+')
            except Exception:
                return False
            #   use pattern
            s = 'abcdefghijklmnopqrestuvwxyz1234'
            l = [random.choice(s) for _ in range(n)]
            s = ''.join(l)
            fp.write(s)
            fp.close()
        elif (p_iMode == 2) :   #   binary
            try:
                fp = os.open(p_pFile, os.O_RDWR | os.O_CREAT)
            except Exception:
                return False
            ay = os.urandom(n)
            l  = len(ay)
            assert(l == n)
            os.write(fp,ay)
            os.close(fp)
        else :      # empty
            fp = os.open(p_pFile, os.O_RDWR | os.O_CREAT)
            os.close(fp)
        return True


    #   mount subDir tuple below a topDir
    def f_test_dirSub_create(self, p_sDir:str, p_tDir:tuple) -> list:
        lRc = list()
        for x in p_tDir :
            pDir    =   self.f_sJoinFilePath(p_sDir,x)
            bRc,sRc =   self.f_mkDir(pDir)
            assert (True is bRc)
            lRc.append(pDir)
        return lRc

    #   dummy FileName List, not create a file
    def f_test_fileMinor_prepare(self, p_sDir:str, p_bBin:bool = False) -> list:
        lRc = list()
        nFileMax = self.f_iRandom(10)     #   1..10
        for i in range(1,nFileMax+1):
            if (p_bBin) :
                s = 'beta' + str(i) + '.bin'
            else :
                s = 'alph' + str(i) + '.txt'
            pFile = self.f_sJoinFilePath(p_sDir,s)
            lRc.append(pFile)
        assert(len(lRc) > 0)
        return lRc

    #   create subDir,subDirFiles below a Dir
    def f_test_hFileMake(self,
                            p_sTopDir:str,      #   mount point
                            p_tSubdir:tuple,
                            p_iSize:int,
                            p_bRandom:bool) -> dict :
        hRc     =   dict()
        iDir    =   0
        bMode   =   False
        iMode   =   0
        lDir = self.f_test_dirSub_create(p_sTopDir, p_tSubdir)
        for xDir in lDir :
            lMinor  =   self.f_test_fileMinor_prepare(xDir, bMode)
            i = 0
            for xFnm in lMinor :
                i += 1
                bRc = self.f_test_bFileMake(xFnm,iMode,p_iSize,p_bRandom)
                assert (True is bRc)
            #   endFor.fnm
            bMode   =   not bMode
            iMode += 1
            iMode %= 3      # iMode = 0..3
            ##  save
            sDir        = os.path.basename(xDir)
            hRc[sDir]   = lMinor
        #   endFor.dir
        return hRc




#   ===========================================================================
#   m:  class.final
#   ===========================================================================

class CLib(CTestLibHelper,CHelp,CZip):

    m_iLib = 0

    m_cDriveSeparator = ":"
    m_cFileExtensionSeparator = '.'

    def f_sVersion(self,p_sFile:str = '') -> str:
        "mATe64 UG Python Library 2024"
        bLib = False
        if (p_sFile == ''):
            bLib = True
            sFile   = __file__
        else:
            sFile   = p_sFile
        sFmt    = "<%Y-%m-%d,%H:%M>"
        fDt     = os.path.getmtime(sFile)
        tTime   = time.gmtime(fDt)
        sTime   = time.strftime(sFmt,tTime)
        if (bLib):
            s = "L:%s" % self.f_sVersion.__doc__
        else:
            s = "S:%s" % sFile
        sRc     = s + ' Time:' + sTime
        return sRc

#   === :footer: beforeLastLine
