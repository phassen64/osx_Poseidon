#   ***************************************************************************
#   My Python Tutorial  ::  barChart    [2026-10-28]
#   ***************************************************************************
#   coding:UTF8
#   !@€ƒ„…†‡ˆ‰Š‹ŒŽ +‘“”•—™š›œžŸ≈+÷×Ø∂¡¿¢£¤¥¦§¨©«¬®°±²³¶·¹º»¼½¾ÄÖÜäöüßαβγδλμπΩ.$


#   === :header
import sys
assert sys.version_info >= (3,9)

#   import.LIB
import LIB_inc as m;  g = m.CLib();   sTc = 'TcBarChart'
g.f_header(sTc)

#   import.MOD
try:
    import matplotlib.pyplot as P
except ImportError as e:
    sEc = e.__str__()
    g.f_warning(sEc); g.f__exit(0)


#   define a function - no return
def F_plotTimer(p_iTimer:int = 10) -> None:
    pFig     = P.gcf()
    tTimer   = pFig.canvas.new_timer(interval=1000*p_iTimer)
    print("+ I stop in :[%d] seconds" % p_iTimer)
    tTimer.add_callback(P.close)
    tTimer.start()

#   Product categories
#   Categories on x-axis
L_products = ["Laptops", "Smartphones", "Tablets"] 

#   Number of units sold
#   Values for each product
L_sales = [120, 200, 80]	

#   Create bar chart
#   Plots comparison between categories
P.bar(L_products, L_sales)	

#   Add title and labels
#   Chart title
P.title("Sales Comparison of Electronic Devices") 

#   X-axis label plt.ylabel("Units Sold")	
#   Y-axis label
P.xlabel("Products")	

#   Display chart
#   Shows the final graph
F_plotTimer(3)
P.show()	

#   === :footer
g.f_footer(sTc)
