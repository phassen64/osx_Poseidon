#   ***************************************************************************
#   My Python Tutorial  ::  mathplot     [2026-10-27]
#   ***************************************************************************
#   coding:UTF8
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$


#   === :header
import sys
assert sys.version_info >= (3,9)

#   import.LIB
import LIB_inc as m;  g = m.CLib();   sTc = 'TcMathplot'
g.f_header(sTc)

#   import.MOD
try:
    import matplotlib.pyplot as P
except ImportError as e:
    sEc = e.__str__()
    g.f_warning(sEc); g.f__exit(0)

#   === :content
'''
    !content:
        •   m:  mathplot
'''

#   m:  mathplot

#   define a function - no return
def F_plotTimer(p_iTimer:int = 10) -> None:
    pFig     = P.gcf()
    tTimer   = pFig.canvas.new_timer(interval=1000*p_iTimer)
    print("+ I stop in :[%d] seconds" % p_iTimer)
    tTimer.add_callback(P.close)
    tTimer.start()

#   Data
x = [1, 2, 3, 4, 5] # X-axis values
y = [10, 20, 25, 30, 40] # Y-axis values


#   Get the current figure and create a timer (3000 ms = 3 seconds)
F_plotTimer(3)

#   Create line plot
P.plot(x, y) # Plots a line graph using x and y values

# Display chart
P.show() # Shows the graph on screen


#   === :footer
g.f_footer(sTc)
