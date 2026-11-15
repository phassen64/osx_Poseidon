#   ***************************************************************************
#   My Python Tutorial  ::  environment    [2026-11-10] 
#   ***************************************************************************

#   coding:UTF8
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   bsh$>   v_mod_bClr='true'; export v_mod_bClr

#   input
#   muss ausserhalb definiert worden sein

print("&&& dummy.header")

x = 'v_mode_bClr'   

print("=== farbentest")

C_UNDEFINED = '?undefined'
C_DEFAULT   = '?default'

tVariable = (
     x,
    'USER'
)

import LIB_inc as m


print("libid := '%s'" % (m.g_sId))

g = m.CLib()

#   muss importiert werden, 
#   LIB reicht nichts zurück in die Bash
import os       

i=0
for x in tVariable:
    i+=1
    try:    
        s = os.environ[x]    #   s = os.getenv(x,C_DEFAULT)
    except Exception:
        s = C_UNDEFINED
    print("<<< os.environ[%d] : '%s' -> '%s'" % (i,str(x),s))    

x = 'v_mode_bClr'   
s = os.getenv(x,'?getenv')  
print("<<< os.getenv('%s') -> '%s'" % (str(x),s))    


#   exit()
print("... weiter1")


#   Variable mit LIB auslesen
#   !CRQ-261114: python erkennt dennoch nicht 'x'
x = 'v_mode_bClr'   
bRc,sRc = g.f_bsEnv(x)
g.f_puts("< reply.bsEnv('%s') bRc|sRc==:['%r'|'%s'] " % (x,bRc,sRc))

#   Status Ausgabe  > keine Farben
print("+ status der lib")
g.f_status()

#   Farben manuell aktivieren
#   g.f_lib_configuration(True) 
#   g.f_lib_prepare()

g.f_puts("+ Ausgabe der Farben",g.C_COLOR_GREEN)

#   temp setarray
eColor = {
    g.C_COLOR_RED,
    g.C_COLOR_GREEN,
    g.C_COLOR_GREEN_DARK,
    g.C_COLOR_YELLOW,
    g.C_COLOR_BLUE,
    g.C_COLOR_WHITE
}

#   show all colors
i = 0
for xColor in eColor:
    i += 1
    g.f_text("color[%2.2d] : '%s'" % (i,xColor),xColor)

print("&&& dummy.footer")