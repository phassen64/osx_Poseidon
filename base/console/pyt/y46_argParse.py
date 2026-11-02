#   coding:UTF8
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   ***************************************************************************
#   My Python Tutorial  :: argParse
#   ***************************************************************************

#   usage:
#       $>  _y <script.py>  # no args

#   REM:
#       The script calls itself --- see py2pycall

#   or: 
#   psh>    python .\y46_argParse.py --iAge 50 --sName Peter --weight 25 -v

#   url: https://docs.python.org/3/library/argparse.html

#   --- content:
#       b:  helper
#       b:  body

#   ===========================================================================
#   b:  helper
#   ===========================================================================

def f_parse() -> None:
    parser = argparse.ArgumentParser(
            prog='program:=sortMyFiles',
            usage="How to",
            description='Description.PROG',
            epilog='Ende der HILFE'
    )
    parser.add_argument(
        '-f','--foo',
            help='### Try Hello'
    )
    parser.add_argument(
        '-a', '--iAge',
            type=int,
            nargs="+",      # MUST para
            required=True,
            help='### enter Age:'
    )
    parser.add_argument(
        '-n', '--sName',
            type=str,
            nargs="+",  # MUST para
            required=True,
            help='### enter Name:'
    )
    parser.add_argument(
        '-r','--range',
            type=int,
            nargs=3,              # exact 3 arguments
            default=[1,2,3],
    #       required = True,
            metavar=('start', 'end', 'step'),
            help='### help range'
    )
    parser.add_argument(
        '-w','--weight',
            type=float,
            nargs='?',
            default=22.14,            # not required
            help='### help Weight'
    )
    parser.add_argument(
        '-v','--verbose',
    #       action  = 'count',          # counts each '-'
            action="store_true",
            help='### verbose'
    )
    parser.add_argument(
        '--version',
            action='version',        # expects 'version='
            version="The version of '%(prog)s' is:= 2024-02-11",
            help='### version'
    )

    args        = parser.parse_args()
    bVerbose    = args.verbose

    if (bVerbose):
        g.f_puts("\t>>> begOfVerbose")
        i = 0
        hArg = vars(parser.parse_args())
        for xKey,yVal in hArg.items():
            i += 1
            g.f_text("arg[%d]:'%s' => '%s'" % (i,xKey,yVal))
        g.f_puts("\t<<< endOfVerbose")


#   ===========================================================================
#   b:  body
#   ===========================================================================

import sys
import os
import pathlib
import argparse


import LIB_inc as m;    g = m.CLib();   sTc = 'tcArgParse'

lOpt    = [
                "-n Peter  -a 50 --verbose",
                "--version",
                "-n Harvey -a 16 -w 2.4 ",
                "-n Vika -a 41 -r 18 27 36 --verbose "
            ]

if len(sys.argv) == 1:

    #   === :header
    g.f_header(sTc)

    g.f_trace("context:isMain")
    F       = pathlib.Path(__file__)
    sScp    = F.name
    sCpl    = g.f_sOsCompiler()
    sRun    = sCpl + ' ' + sScp + ' '

    #   call this script again
    for x in range(0,len(lOpt)):
        sCmd    = sRun  + lOpt[x]
        g.f_text("MyCmd :<%s>" % sCmd)
        os.system(sCmd)

    #   === :footer
    g.f_footer(sTc)

else:
    print("--- beg.now")
    g.f_textmode(p_bColor=True)
    g.f_trace("context:isSubm")
    g.f_text(f"argv     := {sys.argv}")
    g.f_text(f"argc     := {len(sys.argv)}")
    f_parse()
    print("--- end_of_program")
