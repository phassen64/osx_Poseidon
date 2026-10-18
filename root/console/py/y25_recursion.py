#   ***************************************************************************
#   My Python Tutorial  :: recursion
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   === :header
import LIB_inc as m;    g = m.CLib();   sTc = 'tcRecursion'
g.f_header(sTc)


#   Es wird fie Fibonnaci-Zahlen-Reihe definiert.
#   Fn = Fn-1 + Fn-2
#   => 0,1,1,2,3,5,8,13,21,34,55,89

#   ===========================================================================
#   functions
#   ===========================================================================

#   Loesung:rein-recursiv
def f_fib1(n):
    if n == 0:
        return 0
    elif n == 1:
        return 1
    else:
        return f_fib1(n - 1) + f_fib1(n - 2)

#   Loesung:interativ
def f_fib2(n):
    a,b = 0,1
    #   a   = 0
    #   b   = 1
    for _i in range(n):
        a, b = b, a + b
        # oder  a   = b
        #       b   = a + b
    return a

#   Loesung:memoisation
hMemo = {0:0, 1:1}      # start Hash
g.f_text("h=%s, type(h)=%s" % (hMemo,type(hMemo)))
def f_fib3(n):
    if n not in hMemo:
        hMemo[n] = f_fib3(n - 1) + f_fib3(n - 2)
    return hMemo[n]     # direct hash add

#   ===========================================================================
#   body
#   ===========================================================================

#   *** const
n = 30
t = ('recursive','interative','memoisation')
C_showValue = True

#   *** test function

def f_test(p_iFct):
    g.f_menu("test(fct=%d):'%s'..." % (p_iFct,t[p_iFct - 1]))
    iTime0      = g.f_iDtm2Unix()
    y = 0
    for i in range(1,n + 1):
        if p_iFct == 1:
            y = f_fib1(i)
        elif p_iFct == 2:
            y = f_fib2(i)
        elif p_iFct == 3:
            y = f_fib3(i)
        if C_showValue:
            if i == 1:
                s  = "y["
                s += str(p_iFct)
                s += "]("
                s += str(n)
                s += ") :="
                s += str(y)
            else:
                s = "," + str(y)
            print(s,end="",flush=True)
    iTime1      = g.f_iDtm2Unix()
    iDiffTime   = iTime1 - iTime0
    g.f_puts("!",g.C_COLOR_CYAN)
    g.f_text("(fct=%d): elapsed time =: <%d>ms" % (p_iFct,iDiffTime))

#   *** run
i = 0
for i in range(3):
    f_test(i + 1)

#   === :footer
g.f_footer(sTc)
