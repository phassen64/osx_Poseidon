#   ***************************************************************************
#   My Python Tutorial  ::  getOpt
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   usage:
#   $>  python .\y45_getOpt.py --h -o peter -v -x --trace 5 willi franz
#   $>  _y  # here allowed

#   --- content:
#       b:  helper
#       b:  class
#       b:  body
#           s:  define my options
#           s:  overview sOpt vs lOpts
#           s:  reading option KEY|Value
#           s:  start getOpt())
#           s:  show option&&arg.List.debug
#           s:  show option&&arg.List.verbose
#           s:  leave if OptError
#
#  url: :https://docs.python.org/3.1/library/getopt.html

'''
1)  argument list
    Parses command line options and parameter list. args is the argument
    list to be
    parsed, without the leading reference to the running program.
    Typically, this means sys.argv[1:].

2)  shortopts is the string of option letters that the script
     wants to recognize, with options that require an argument
         followed by a colon.
     (':'; i.e., the same format that Unix getopt() uses).

3)   Long options on the command line can be recognized so
         long as they provide
     a prefix of the option name that matches exactly one of
         the accepted options.
     For example, if longopts is ['foo', 'frob'], the option --fo will
     match as --foo, but --f will not match uniquely,
         so GetoptError will be raised.
'''

#   ===========================================================================
#   b:  helper
#   ===========================================================================


def f_usage():
    s = "%s %s <opts> <args>" % (g.f_sOsCompiler(),g_sScp)
    g.f_text("<<< usage := \t$> %s" % s)

def f_showVersion():
    g.f_text("<<< version:= <%s>" % gVar.m_sVersion)


def f_parse() -> None:

    #   init globals
    f_varInit()

    #   parse
    try:
        p_sOptsShort = gVar.m_sOptsShort
        p_lOptsLong  = gVar.m_lOptsLong
        lOpts, lArgs  = getopt.getopt(
            sys.argv[1:],                   # arg1,...,argN
            p_sOptsShort,                   # use parameter opts
            p_lOptsLong                     # use parameter longOpts
        )
        '''
            -h      | --help
            -n      | --name    <sName>
            -i      | --age     <iAge>
            -w      | --weight  <fWeight>
            -v      | --version
            <none>  | --verbose
        '''
    except getopt.GetoptError as tEc:
        #   s:  leave if OptError
        print(tEc)  # will print something like "option -a not recognized"
        g.f_text("type(tEc) => %s"   % (type(tEc)))
        sys.exit(2)

    #   s:  show option&&arg.List.debug
    if (gVar.m_bDebug):
        if (bool(lOpts) is True):
            g.f_text("lOpts => '%s'"   % lOpts)
        if (bool(lArgs) is True):
            g.f_text("lArgs => '%s'"   % lArgs)

    i = 0
    for (xOptKey,xOptVal) in lOpts:

        if xOptKey in ("-h", "--help"):
            gVar.m_bUsage   = True
        elif xOptKey in ("-v","--version"):
            gVar.m_bVersion = True
        elif xOptKey in ("--verbose"):
            gVar.m_bVerbose = True
        elif xOptKey in ("-n", "--name"):
            gVar.m_sName = xOptVal
        elif xOptKey in ("-i", "--age"):
            gVar.m_iAge     = int(xOptVal)
        elif xOptKey in ("-w", "--weight"):
            gVar.m_fWeight  = float(xOptVal)
        else:
            raise Exception     # False, "?unhandled option"
        if (gVar.m_bDebug):
            i += 1
            g.f_text("opt[%d] = <'%s'>:<'%s'>"   % (i,xOptKey,xOptVal))

    g.f_puts("--- result",g.C_COLOR_BLUE)
    if (gVar.m_bUsage):
        f_usage()
    elif (gVar.m_bVersion):
        f_showVersion()
    else:
        g.f_text("rc.Name   :   <%s>" % gVar.m_sName)
        g.f_text("rc.Age    :   <%d>" % gVar.m_iAge)
        g.f_text("rc.Weight :   <%f>" % gVar.m_fWeight)

    return None


#   ===========================================================================
#   b:  class
#   ===========================================================================

class CVariable:
    m_sOptsShort    = "hv i: n: w:"
    m_lOptsLong     = ["help","name=","age=","weight=","verbose","version"]
    m_iId           = 4711
    m_bDebug        = False
#   results of parsing
    m_bVerbose      = False
    m_bVersion      = False
    m_sVersion      = 'v240409.1'
    m_bUsage        = False
    m_sName         = '?Name'
    m_iAge          = -1
    m_fWeight       = 0.0

def f_varInit() -> None:
    gVar.m_bVerbose      = False
    gVar.m_bVersion      = False
    gVar.m_bUsage        = False
    gVar.m_sName         = '?Name'
    gVar.m_iAge          = -1
    gVar.m_fWeight       = 0.0


#   ===========================================================================
#   b:  body
#   ===========================================================================

#   import
import LIB_inc as m;    g = m.CLib();   sTc = 'tcGetOpt'
import getopt
import os
import pathlib
import sys


#   globals
gVar        = CVariable
gOptList    = ["--version",
                "--name Peter --age 50 --weight 69.1 --verbose",
                "--n Harvey -i 12 -w 2.4 ",
                "unknownArgument",
                "-h"
]

#   debug ?
gVar.m_bDebug   = False

#   SCP
F       = pathlib.Path(__file__)
g_sScp  = F.name


if len(sys.argv) == 1:
    #   === :header
    g.f_header(sTc)

    g.f_trace("context:isMain")
    F       = pathlib.Path(__file__)
    sCpl    = g.f_sOsCompiler()
    sRun    = sCpl + ' ' + g_sScp + ' '

    for x in range(0,len(gOptList)):
        i = x
        s = gOptList[x]
        g.f_text("Opts[%d] :<%s>" % (i,s))
        sCmd    = sRun  + gOptList[x]
        os.system(sCmd)

    #   === :footer
    g.f_footer(sTc)

else:
    #   globals
    g.f_textmode(p_bColor=True)
    g.f_trace("context:isSubm")
    f_parse()
