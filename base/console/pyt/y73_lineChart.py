#   ***************************************************************************
#   My Python Tutorial  ::  lineChart    [2026-10-28]
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

#   s:  input

L_month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
           "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

#   Einkommensquelle
L_revenue = [100, 110, 105, 120, 130, 140, 150, 
                160, 155, 170, 180, 190]


#   s:  do

#   Connects data points to show trend over time
P.plot(L_month, L_revenue, marker="o")

#   Label x-axis
P.xlabel("Months") 

#   Label y-axis
#   Names the y-axis as Revenue in thousands
P.ylabel("Revenue (in $K)")

#   Add grid lines for better readability
P.grid(True)

#   Add title to the graph
P.title("Monthly Revenue Growth") 

#   display Chart
F_plotTimer(5)
P.show()	

#   b:  footer
g.f_footer(sTc)
