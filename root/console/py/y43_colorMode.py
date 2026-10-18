#   ***************************************************************************
#   My Python Tutorial  :: colorMode
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

'''
    !content:
    !keyword:
    !function:
'''

import LIB_inc as m; g = m.CLib(); sTc = "tcColorMode"

#   === :header
g.f_header(sTc,p_bColor=True)

#   define
eColor = {
    g.C_COLOR_RED,
    g.C_COLOR_RED_DARK,
    g.C_COLOR_GREEN,
    g.C_COLOR_GREEN_DARK,
    g.C_COLOR_YELLOW,
    g.C_COLOR_BLUE,
    g.C_COLOR_BLUE_DARK,
    g.C_COLOR_MAGENTA,
    g.C_COLOR_CYAN,
    g.C_COLOR_CYAN_DARK,
    g.C_COLOR_WHITE
}

#   show all colors
i = 0
for xColor in eColor:
    i += 1
    g.f_text("color[%2.2d] : '%s'" % (i,xColor),xColor)

#   === :footer
g.f_footer(sTc)
