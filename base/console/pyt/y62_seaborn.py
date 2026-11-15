#   ***************************************************************************
#   My Python Tutorial  ::  seaborn      [2026-10-27]
#   ***************************************************************************
#   coding:UTF8
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   === :header
import sys
assert sys.version_info >= (3,9)

#   import.LIB
import LIB_inc as m;  g = m.CLib();   sTc = 'TcSeaborn'
g.f_header(sTc)

#   import.MOD
try:    
    # Imports seaborn library
    #   for statistical visualization
    import seaborn as sns 

    # Imports matplotlib
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


#   === :content
'''
    !content:
        •   m:  seaborn
'''

#   m:  seaborn

#   Load sample dataset
#   Loads built-in tips dataset
tips = sns.load_dataset("tips") 

#   Create scatter plot
#   Plots relationship between bill and tip
sns.scatterplot(x="total_bill", y="tip", data=tips) 

#   Adds title to the graph
P.title("Total Bill vs Tip") 

#   show
F_plotTimer(3)
P.show()

#   === :footer
g.f_footer(sTc)
