#   ***************************************************************************
#   My Python Tutorial  ::  heatMap         [2026-10-28]
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
    import pandas           as  pd
    import seaborn          as  sns 
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


#   Sample dataset 
#   Age values of individuals

data = {

    #   Age values of individuals
    'Age': [22, 25, 47, 52, 46, 56, 48, 55],

    #   Salary values corresponding to individuals
    'Salary': [25000, 30000, 80000, 90000, 85000, 95000,
                87000, 99000],

    #   Years of experience
    'Experience': [1, 2, 20, 25, 22, 30, 24, 28],

    #   Performance scores

    'Performance': [60, 65, 90, 95, 92, 98, 94, 97]
}

#   Convert dictionary into a DataFrame
#   Organizes data into tabular format (rows and columns)
df = pd.DataFrame(data) 

#   Compute correlation matrix
#   Finds relationships between numerical features
corr_matrix = df.corr() 

#   Create figure
P.figure(figsize=(6, 4)) 

#   Create heatmap
sns.heatmap(
    corr_matrix,
    annot=True,
    cmap='coolwarm', 
    fmt='.2f')

#   Add title
P.title('Feature Correlation Heat Map') 

#   Display Chart and start timout timer
F_plotTimer(5)
P.show()	

#   b:  footer
g.f_footer(sTc)
