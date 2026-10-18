#   ***************************************************************************
#   My Python Tutorial  ::  process
#   ***************************************************************************
#   coding:UTF8
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$


#   === :header
import time
from multiprocessing import Process
import LIB_inc as m;  g = m.CLib();   sTc = 'TcProcess'


#   === :content
'''
    !content:
    b:  helper
        m:  create
        m:  start
        m:  join
        m:  close
        m:  calc
    b:  body
'''

#
#   b:  helper
#

def F_main() -> None:

    #   m:  create
    g.f_menu("create")
    tPrc = [Process(target=g.f_isPrime, args=(n,)) for n in g.C_LIST_number]

    #   m:  start
    g.f_menu("start")
    iStart = time.perf_counter_ns()
    [p.start() for p in tPrc]

    #   m:  join
    g.f_menu("join")
    [p.join() for p in tPrc]
    iStopp = time.perf_counter_ns()
    assert (iStopp > iStart)

    #   m:  close
    g.f_menu("close")
    [p.close() for p in tPrc]

    #   calc
    g.f_menu("calc")
    fTime = (iStopp - iStart) / 1000000.0
    iPrec = 2
    fTime = round((iStopp - iStart) / 1000000.0, iPrec)
    g.f_text(f"calcPrimeTime.Proc : {fTime} [ms]")

#
#   b:  body
#

if __name__ == "__main__":
    g.f_header(sTc)
    F_main()
    g.f_footer(sTc)
