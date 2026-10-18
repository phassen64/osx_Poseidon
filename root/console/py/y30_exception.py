#   ***************************************************************************
#   My Python Tutorial :: exception
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   !url:
#   https://docs.python.org/3/library/exceptions.html#exception-hierarchy
#   BaseException
#    ├── BaseExceptionGroup ...
#    ├── SystemExit
#    └── Exception ...
#        ── Warning

'''
    !content:Exceptions
'''

#   === :header
import sys
import LIB_inc as m;    g = m.CLib();   sTc = 'tcException'
g.f_header(sTc)

#   =================================================================
#   functions
#   =================================================================

#   a) multiple exceptions
def f_exc1(p_iVal,p_tVal):
    g.f_trace()
    iNum = p_iVal
    t    = p_tVal
    while True:
        iIdx = 0
    #   for iDiv in t : # besser
        bEc = False
        while not bEc:
            try:
                sTmp = "f(" + str(iNum) + "," + "?" + ") => "
                iDiv = t[iIdx]
                sTmp = "f(" + str(iNum) + "," + str(iDiv) + ") => "
                fSum = iNum / iDiv
                sTmp += str(fSum)
            except ZeroDivisionError as iExc:      # 1 Exc => 1 clause
                sTmp += "?excZero=["
                sTmp += str(iExc)
                sTmp += "]"
            except (IOError, KeyError) as iExc:     # 2 Exc => 1 clause
                sTmp += "?excIo_or_Key=["
                sTmp += str(iExc)
                sTmp += "]"
            except Exception as iExc:               # common Exc
                bEc = True
                sTmp += "?excANY=["
                sTmp += str(iExc)
                sTmp += "]"
            iIdx += 1
            g.f_text("%s" % (sTmp))
        else:
            g.f_text("...for1 finished")
            break
#   End


#   b) exc with ELSE
def f_exc2(p_iVal,p_tVal):
    g.f_trace()
    iNum,t = p_iVal,p_tVal
    try:
        while True:
            for iDiv in t:
                sTmp = "f(" + str(iNum) + "," + str(iDiv) + ") => "
                fSum = iNum / iDiv
                sSum = "{x1:05.2f}".format(x1=fSum)
                sTmp += sSum
            else:
                g.f_text("...for2 finished")
                break
    except Exception as iExc:               # common Exc
        sTmp += "?excANY=["
        sTmp += str(iExc)
        sTmp += "]"
        g.f_text("%s" % (sTmp))
    else:
        sTmp += ":!ok"                      # try-ELSE clause

#   c) exc info
def f_exc3(p_iVal,p_tVal):
    g.f_trace()
    iNum,t = p_iVal,p_tVal
    try:
        while True:
            for iDiv in t:
                g.f_text("Divisor3:%d" % (iDiv))
                _fSum = iNum / iDiv
            else:
                g.f_text("...for3 finished")
                break
    except Exception:                             # general clause
        g.f_trace("sys.exc_info...")
        (tTyp, tVal, tTraceBack) = sys.exc_info()  # sys()
        sTyp,sVal,sTrc = str(tTyp),str(tVal),str(tTraceBack)
        sTmp  = "{tTyp,tVal,tTrc}=:{"
        sTmp  += sTyp + ',' + sVal + ',' + sTrc + '}'
        g.f_text("%s" % (sTmp))

#   End

#   d) exc raise by Fct
def f_exc4(p_iNum,p_tVal):
    g.f_trace()
    for iDiv in p_tVal:
        g.f_text("Divisor4:%d" % (iDiv))
        if (iDiv == 0):
            raise SyntaxError("?excFCT:DivByZero")

#   e) exc raise by Class
class TMyExceptionError(Exception):     # naming T...Error
    m_iVal = 4711

def f_exc5(p_iNum,p_tVal):
    g.f_trace()
    for iDiv in p_tVal:
        g.f_text("Divisor5:%d" % (iDiv))
        if (iDiv == 0):
            raise TMyExceptionError("?excCLS:DivByZeroFound")

#   f) exc finally
def f_exc6(p_iNum,p_tVal):
    g.f_trace()
    for iDiv in p_tVal:
        sTmp = "f(" + str(p_iNum) + "," + str(iDiv) + ") => "
        try:
            fSum = p_iNum / iDiv
            sTmp += str(fSum)
        except Exception:
            sTmp += "?Exc"
        finally:
            sTmp += ";fine"  # called after: try AND except
        g.f_text("%s" % (sTmp))

#   =================================================================
#   Body
#   =================================================================

g.f_trace()
sCol = g.C_COLOR_CYAN

#   a) define
g.f_menu("exc to define")
iNum,tNum = 10,(4,0,5)
g.f_text(("use: iNum:='%s', tNum=<%s>" % (iNum,g.f_sTuple(tNum))),sCol)
f_exc1(iNum,tNum)

#   b) try-ELSE
g.f_menu("exc with try-ELSE")
iNum,tNum = 10,(7,1,3)
g.f_text("use: iNum:='%s', tNum=<%s>" % (iNum,g.f_sTuple(tNum)),sCol)
f_exc2(iNum,tNum)

#   c) sysInfo
g.f_menu("exc sysInfo")
iNum,tNum = 10,(6,0,8)
g.f_text("use: iNum:='%s', tNum=<%s>" % (iNum,g.f_sTuple(tNum)),sCol)
f_exc3(iNum,tNum)

#   d) fctRaise
g.f_menu("exc raise by function")
iNum,tNum = 10,(6,0,5)
g.f_text("use: iNum:='%s', tNum=<%s>" % (iNum,g.f_sTuple(tNum)),sCol)
try:
    f_exc4(iNum,tNum)
except Exception as e:
    g.f_text("MAIN got EXC=<%s>" % (e))

#   e) classRaise
g.f_menu("exc raise by class")
g.f_text("use: iNum:='%s', tNum=<%s>" % (iNum,g.f_sTuple(tNum)),sCol)
iNum,tNum = 10,(9,0,5)
try:
    f_exc5(iNum,tNum)
except Exception as e:
    g.f_text("MAIN-cls got EXC=<%s>" % (e))
    g.f_text("excInfo...")
    (tTyp, tVal, tTrc) = sys.exc_info()  # sys()
    sTyp,sVal,sTrc = str(tTyp),str(tVal),str(tTrc)
    sTmp  = "\tTYPE=" + sTyp + ";\n\tVAL=" + sVal + ";\n\tTRC=" + sTrc
    print(sTmp)

#   f) finally
g.f_menu("exc finally")
g.f_text("use iNum:='%s', tNum=<%s>" % (iNum,g.f_sTuple(tNum)),g.C_COLOR_CYAN)
iNum,tNum = 10,(2,0,3)
f_exc6(iNum,tNum)

#   === :footer
g.f_footer(sTc)
