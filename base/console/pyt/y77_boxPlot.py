#   ***************************************************************************
#   My Python Tutorial  ::  boxPlot         [2026-10-28]
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


#   Sample data

#   Salary data for HR department
#   Salary data for IT department
#   Salary data for Finance department

L_hr_salary = [30000, 32000, 35000, 40000, 42000, 38000, 36000] 
L_it_salary = [50000, 55000, 60000, 62000, 58000, 70000, 75000] 
L_fd_salary = [45000, 47000, 52000, 50000, 53000, 49000, 51000] 

#   Combine data
#   Groups all department salary data into one list for plotting
L_combined_salary = [L_hr_salary, L_it_salary, L_fd_salary] 

#   Create figure
#   Sets the size of the plot window
P.figure(figsize=(8, 5)) 

#   Create box plot
P.boxplot(L_combined_salary, label=["HR", "IT", "Finance"]) 
# Shows distribution of salaries (median, quartiles, outliers) for each department

#   Add y-axis label
#   Labels the vertical axis as Salary
P.ylabel("Salary") 


#   Display Chart and start timout timer
F_plotTimer(5)
P.show()	

#   b:  footer
g.f_footer(sTc)
