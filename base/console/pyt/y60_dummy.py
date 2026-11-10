#   ***************************************************************************
#   My Python Tutorial  ::  environment    [2026-11-10] 
#   ***************************************************************************

#   coding:UTF8
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

import os 

C_UNDEFINED = '?undefined'
C_DEFAULT   = '?default'

tVariable = (
    'v_FWK_mode_bColor',
    'v_mode_bClr',
    'USER'
)

i=0
for x in tVariable:
    i+=1
    try:    
        s = os.getenv(x,C_DEFAULT)
    except Exception:
        s = C_UNDEFINED
    print("<<< envVar[%d] : '%s' -> '%s'" % (i,str(x),s))    


import LIB_inc as m; g = m.CLib()

#   Set library depending on env variables
g.f_lib_configuration(
        (g.f_bsEnv('v_mode_bClr')),
        (g.f_bsEnv('v_mode_bVbs')),
        1   # v_mode_iLog
)

#   define
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
