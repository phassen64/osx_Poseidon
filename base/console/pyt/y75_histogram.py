#   ***************************************************************************
#   My Python Tutorial  ::  historgram      [2026-10-28]
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

#   Student exam scores
L_score = [45, 56, 67, 70, 72, 75, 80, 82, 85, 88, 90, 91,
93, 95, 96,
78, 74, 69, 60, 50, 55, 65, 77, 84, 89, 92, 94,
58, 62, 73]     #   List of marks obtained by students

#   Create histogram
#   Divides data into 5 intervals (bins) and shows 
#   frequency distribution
P.hist(L_score, bins=5, color='skyblue', edgecolor='black') 

#   Add title
P.title('Distribution of Student Examination Scores') 

#   Label x-axis
P.xlabel('Scores')

#   Label y-axis
P.ylabel('Number of Students') 

#   Display Chart and start timout timer
F_plotTimer(8)
P.show()	

#   b:  footer
g.f_footer(sTc)
