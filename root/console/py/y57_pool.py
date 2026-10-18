#   ***************************************************************************
#   My Python Tutorial  ::  processPool
#   ***************************************************************************
#   pool = "Process-based parallelism"
#   https://docs.python.org/3/library/multiprocessing.html
#   coding:UTF8
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$


#   === :header
import time
from multiprocessing import Pool
import LIB_inc as m;  g = m.CLib();   sTc = 'TcPool'

#   === :content
'''
        b:  helper
            m:  start
            m:  run
            m:  stop
            m:  show
        b:  body
'''

#
#   b:  helper
#
def F_main() -> None:

    #   m:  start
    g.f_menu("start")
    iStart = time.perf_counter_ns()

    #   m:  run
    g.f_menu("run")
    with Pool() as p:
        LRc = p.map(g.f_isPrime, g.C_LIST_number)

    #   m:  stop
    g.f_menu("stop")
    iStopp = time.perf_counter_ns()
    assert (iStopp > iStart)
    iPrec = 2
    fTime = round((iStopp - iStart) / 1000000.0, iPrec)
    g.f_text(f"calcPrimeTime.Pool : {fTime} [ms]")

    #   m:  show
    g.f_menu("show results")
    i = 0
    for x in LRc:
        iPrime = g.C_LIST_number[i]
        g.f_text("?isPrime[%d] = %d => '%r'" % (i,iPrime,x))
        i += 1

#
#   b:  body
#

if __name__ == "__main__":
    g.f_header(sTc)
    F_main()
    g.f_footer(sTc)
