#   ***************************************************************************
#   My Python Tutorial  ::  arePlotChart    [2026-10-28]
#   ***************************************************************************
#   coding:UTF8
#   !@€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ≈+÷×Ø∂¡¿¢£¤¥¦§¨©«¬®°±²³¶·¹º»¼½¾ÄÖÜäöüßαβγδλμπΩ.$


#   b:  header
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

#   b:  body


#   12 month
L_month = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", 
            "Jul", "Aug", "Sep"]

#   Website traffic (cumulative values)
#   the same dimension as month
L_traffic = [1000, 2500, 4500, 7000, 10000, 13500,0,0,0]


#   Plot line on top of area fill
P.plot(L_month, L_traffic, marker='o', color='red') 

#   Create area plot (filled region under the line)
P.fill_between(L_month, L_traffic, color='skyblue',alpha=0.5) 


#   Label x-axis
P.xlabel("Months") 

#   Label y-axis
P.ylabel('Cumulative Traffic') 

#   Add title
P.title('Cumulative Website Traffic Over Months') 

#   Display Chart and start timout timer
F_plotTimer(5)
P.show()	

#   b:  footer
g.f_footer(sTc)
