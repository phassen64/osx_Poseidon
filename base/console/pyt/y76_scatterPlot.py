#   ***************************************************************************
#   My Python Tutorial  ::  scatterPlot     [2026-10-28]
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

#   m:  body


#   Sample data
#   x
L_ad_spend = [ 
    20000, 25000, 30000, 35000, 40000, 45000, 50000, 55000]

#   y
L_sales_revenue = [
    180000, 195000, 210000, 230000, 260000,
                    280000, 300000, 330000] 


#   Set figure size
#   Defines the size of the plot window for better readability
P.figure(figsize=(8, 5)) 


#   Create scatter plot
#   Plots individual points to show relationship between 
#       ad spend and revenue
P.scatter(L_ad_spend, L_sales_revenue) 

#   Add title
P.title('Advertising Expenditure vs Sales Revenue') 

#   Label x-axis
P.xlabel('Advertising Expenditure')

#   Label y-axis
P.ylabel('Sales Revenue') 

#   Display Chart and start timout timer
F_plotTimer(8)
P.show()	

#   b:  footer
g.f_footer(sTc)
