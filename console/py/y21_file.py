#   ***************************************************************************
#   My Python Tutorial :: fileHandling
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$
#   url:    https://www.w3schools.com/python/python_file_handling.asp
#   url:    https://docs.python.org/3/library/pathlib.html#methods-and-properties

#   --- content
#       b:  helper
#       b:  body

'''
    !Content:
        m:  filePath
        m:  check
        m:  txtfile.create
        m:  txtfile.write
        m:  textfile.read
        m:  textfile.read.with
        m:  size
        m:  binfile.create
        m:  binfile.write
        m:  binfile.read
'''


#   ===========================================================================
#   b:  helper
#   ===========================================================================


def F_tryPathlib(p_sFilePath:str) -> bool:

    #   --  create object and show
    F   = pathlib.Path(p_sFilePath)
    g.f_text("sFilePathObject =  %r" % (F))       # WindowsPath('D:...')

    #   F.content
    sRc = str(F)
    g.f_text("sFile =  %s" % (sRc))         # 'D:...'

    #   F.isFile
    bRc = F.is_file()
    g.f_text("F.IsFile      =  %r" % (bRc))         # True

    #   F.isDir
    bRc = F.is_dir()
    g.f_text("F.IsDir       =  %r" % (bRc))         # False

    #   F.isAbsolute
    #   D:\repository\GIT\console\tutorial\py\y21_file.py
    bRc = F.is_absolute()
    g.f_text("F.IsAbsolute  =  %r" % (bRc))         # True

    #   F.Drive
    sRc  = F.drive
    g.f_text("F.drive   =  %s" % (sRc))     # D:

    #   F.Name
    sRc = F.name
    g.f_text("F.name    =  %s" % (sRc))     # y21_file.py

    #   F.Stem
    tRc = F.stem
    g.f_text("F.stem    =  %s" % (tRc))     # y21_file

    #   F.Suffix
    sRc = F.suffix
    g.f_text("F.suffix  =  %s" % (sRc))             # py

    #   F.Parts
    #   ('D:\\', 'repository', 'GIT',
    #       'console', 'tutorial', 'py', 'y21_file.py')
    lRc = F.parts
    g.f_text("F.parts   =  %s" % (str(lRc)))

    #   F.posix
    #   Return a string representation of the path with forward slashes (/):
    #   D:/repository/GIT/console/tutorial/py/y21_file.py
    tRc = F.as_posix()
    g.f_text("F.posix   =  %s" % (tRc))

    #   F.absolute
    tRc = F.absolute()
    g.f_text("F.abs     =  %s" % (tRc))

    #   F.strlen(absolute)
    sPth   = str(tRc)
    iRc    = len(sPth)
    g.f_text("len(F.abs)     =  %d" % (iRc))

    #   F.DirName or parent
    #   D:\repository\GIT\console\tutorial\py
    tRc     = F.parents[0]
    g.f_text("F.parents[0]   =  %s" % (tRc))

    #   F.DirName.Posix
    #   D:/repository/GIT/console/tutorial/py
    tRc     = F.parents[0].as_posix()
    g.f_text("F.dir.posix   =  %s" % (tRc))

    return True


def F_chkFilePath(p_sFilePath:str) -> bool:

    F   = pathlib.Path(p_sFilePath)
    s   = str(F.parents[0].as_posix())
    g.f_text(("sFilePath =  %s" % (s)),g.C_COLOR_CYAN)
    bFile = os.path.isfile(s); g.f_text("os.path.isFile =>  %r" % (bFile))  # T
    bFile = os.path.exists(s); g.f_text("os.path.exists =>  %r" % (bFile))  # T

    #   change
    s = s + 'x'
    g.f_text(("sFilePath =  %s" % (s)),g.C_COLOR_CYAN)
    bFile = os.path.isfile(s); g.f_text("os.path.isFile =>  %r" % (bFile))  # F
    bFile = os.path.exists(s); g.f_text("os.path.exists =>  %r" % (bFile))  # F

    #   check Dir
    s = str(F.parents[0].as_posix())
    g.f_text(("sDir =  %s" % (s)),g.C_COLOR_CYAN)
    bFile = os.path.isfile(s); g.f_text("os.path.isFile =>  %r" % (bFile))  # F
    bFile = os.path.exists(s); g.f_text("os.path.exists =>  %r" % (bFile))  # T

    return True


#   ===========================================================================
#   b:  body
#   ===========================================================================

#   === :header
import os
import pathlib
import LIB_inc as m;    g = m.CLib();   sTc = 'TcFileHandling'
g.f_header(sTc)

#   m:  filePath

g.f_menu("filePath")
bRc = F_tryPathlib(__file__)
assert (bRc is True)

#   fetch log-directory
sLogDir  = g.f_sLogDirectory()

#   prepare my objet in Body
F   = pathlib.Path(__file__)
g_sFileBdy = str(F.stem)

#   m:  check
g.f_menu("fileCheck")
bRc = F_chkFilePath(__file__)


#   m:  txtfile.create

g.f_menu("file create")
sFileTxt   = g_sFileBdy
sFileTxt  += ".txt"
g.f_text(f"I create file : {sFileTxt} ...")

#   make path
pFileTxt = g.f_sJoinFilePath(sLogDir,sFileTxt)

#   create and check
bRc,sRc = g.f_bFileCreate(pFileTxt,True)
assert (bRc is True)
g.f_text("I have created file :'%s' : '%r':'%s'" % (sFileTxt,bRc,sRc))

#
#   m:  txtfile.write
#

#   OPEN mode
#   'r' :   oPen for reading (default)
#   'w' :   oPen for writing, truncating the file first
#   'x' :   oPen for exclusive creation, failing if the file already exists
#   'a' :   oPen for writing, appending to the end of the file if it exists
#   'b' :   Binary Mode
#   't' :   text mode (default)
#   '+' :   oPen a disk file for updating (reading and writing)

g.f_menu("textFile write")

fp  = open(pFileTxt,"w")
i = 0
t = ('Harvey','Vika','Vadim','Dorothea','Ines')
l = len(t)
g.f_text("show(t)    : %s" % (g.f_sTuple(t)))
i = 0
while i < l:
    s = t[i]
    g.f_text("value=(%s)" % (s))
    fp.write(s)
    i += 1
g.f_text("I have written into file :'%s'" % sFileTxt)
fp.close()

#
#   m:  textfile.read
#

g.f_menu("textFile read")

fp      = open(pFileTxt,"r")
if (fp == 0):
    g.f_exit(-2,"open textFile")
else:
    iLine   = 1
    for tLine in fp:
        sLine = tLine.rstrip()
        if (len(sLine) == 0):
            continue
        g.f_text("line[%d]:%s" % (iLine,sLine))
        iLine += 1
    fp.close()
#
g.f_text("!fileRead:<%d> lines " % iLine)


#
#   m:  textfile.read.with
#

g.f_menu("textFile read.with")
with open(pFileTxt) as fp:
    iLine   = 1
    for tLine in fp:
        sLine = tLine.rstrip()
        if (len(sLine) == 0):
            continue
        g.f_text("line[%d]:%s" % (iLine,sLine))
        iLine += 1

#   fclose not needed
g.f_text("!fileRead2:<%d> lines " % iLine)

#
#   m:  size
#

g.f_menu("textFile size")

iRc = g.f_iFileSize(pFileTxt)
if iRc:
    g.f_text("fileSize:'%d' Bytes" % iRc)
assert (iRc == 27)

#
#   m:  binFile.create - define new name
#

g.f_menu("binFile-create")
sFileBin   = g_sFileBdy
sFileBin  += ".bin"

#   make path
pFileBin = g.f_sJoinFilePath(sLogDir,sFileBin)

#   create and check
bRc,sRc     = g.f_bFileCreate(pFileBin,True)
assert (bRc is True)
g.f_text("I have created file :'%s' : '%r':'%s'" % (sFileBin,bRc,sRc))

#
#   m:  binFile.write
#

g.f_menu("binFile-write")
# t = (0x21,0x41,0x42,0x43,0x44,0x0D,0x0A)
t = ('!','A','B','C','D','\r','\n')
g.f_text("show(t) : %s" % (g.f_sTuple(t)))

fp = open(pFileBin,"wb")
assert (fp != 0)

i = 0
while i < len(t):
    iAsc = ord(t[i])
    g.f_text("* try write[%d] value=x(%X)" % (i,iAsc))
    ay = bytes([iAsc])  # convert int=>byteArray
    fp.write(ay)
    i += 1

fp.close()

#
#   m:  binFile.read
#

g.f_menu("binFile-read")

iRc = g.f_iFileSize(pFileBin)
assert (iRc > 0)
g.f_text("fileSize.BIN:'%d' Bytes" % iRc)
assert (iRc == 7)

#   read
fp  = open(pFileBin,"rb")
i = 0
while (i < 100):        # no EOF  - or (i<iSz)
    ay  = fp.read(1)    # read only 1 byte
    if not ay:
        g.f_text("&&& found:EOF:break")
        break
    x   = ay[0]     # convert byteArray => byte
    iRc = int(x)    # convert byte=>int
    g.f_text("* read[%d] value=x[%02x]" % (i,iRc))
    i += 1
else:
    g.f_text("* OK:while ready")
g.f_text("ready file read byteS : %s" % (i))
fp.close()


#   === :footer
g.f_footer(sTc)
quit()
