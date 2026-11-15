#   ***************************************************************************
#   My Python Tutorial  ::  pieChart    [2026-10-28]
#   ***************************************************************************
#   coding:UTF8
#   !@€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ≈+÷×Ø∂¡¿¢£¤¥¦§¨©«¬®°±²³¶·¹º»¼½¾ÄÖÜäöüßαβγδλμπΩ.$


#   m:  header
import sys
assert sys.version_info >= (3,9)

#   m:  import.LIB
import LIB_inc as m;  g = m.CLib();   sTc = 'TcBarChart'
g.f_header(sTc)

#   m:  import.Ploter
try:
    import matplotlib.pyplot as P
except ImportError as e:
    sEc = e.__str__()
    g.f_warning(sEc); g.f__exit(0)


#   m:  define timer function
def F_plotTimer(p_iTimer:int = 10) -> None:
    pFig     = P.gcf()
    tTimer   = pFig.canvas.new_timer(interval=1000*p_iTimer)
    print("+ I stop in :[%d] seconds" % p_iTimer)
    tTimer.add_callback(P.close)
    tTimer.start()

#   m:  body

#   s:  lists
L_brands        = ["Samsung", "Apple", "Xiaomi", "Oppo", "Others"]
L_market_share  = [30, 25, 20, 15, 10] 

#   s:  run
P.pie(L_market_share, labels=L_brands, autopct='%1.1f%%')
P.title("Smartphone Market Share")
F_plotTimer(5)
P.show()	

#   b:  footer
g.f_footer(sTc)
