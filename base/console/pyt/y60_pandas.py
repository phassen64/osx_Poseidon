#   ***************************************************************************
#   My Python Tutorial  ::  pandas    [2026-10-27]
#   ***************************************************************************
#   coding:UTF8
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

### not working!

#   === :header
import sys
assert sys.version_info >= (3,9)

#   import.LIB
import LIB_inc as m;  g = m.CLib();   sTc = 'TcPandas'
g.f_header(sTc)

#   import.pandas
try:
    import pandas as pd
except ImportError as e:
    sEc = e.__str__()
    g.f_warning(sEc); g.f__exit(0)

#   === :content
'''
    !content:
        •   m:  pandas
'''

#   m:  pandas
g.f_menu("pandas")


#   Create a DataFrame as a Dictionary
hValue = { 
    "Name"  : ["Alice", "Bob", "Charlie"],
    "Age"   : [25, 30, 22],
}

#   Converts dictionary into DataFrame
df = pd.DataFrame(hValue) 

print(df) 


#   === :footer
g.f_footer(sTc)
