#   ***************************************************************************
#   My Python Tutorial  ::  os && shutil
#   ***************************************************************************
#   -$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   MOD:    os

#   === :header
import os
import LIB_inc as m;    g = m.CLib();   sTc = 'TcOs'
g.f_header(sTc)

#   === :content
'''
    content:
        m:  helper
        m:  prepare
        m:  basic
        m:  random
        m:  directory
        m:  fileStatus
        m:  osPath
        m:  fileHandling
        m:  restore
'''

#   b:  body

#   ===========================================================================
#   m:  helper
#   ===========================================================================

#   import random   !CRQ-241215: already imported

def F_dirTop_prepare() -> dict:
    hRc = dict()
    b,h     =   g.f_bhFilePath_member(__file__)
    assert (True is b)
    sBdy    =   h['m_sBdy']
    hRc['m_sHom']   =   g.f_sPwd()
    hRc['m_sScr']   =   g.f_sLogDirectory()       # !SCRATCH
    hRc['m_sTop']   =   g.f_sJoinFilePath(hRc['m_sScr'],sBdy[0:3])
    bRc,_sRc =  g.f_mkDir(hRc['m_sTop'])
    assert (True is bRc)
    return hRc

#   empty,txt,bin,doc
def F_fileMajor_prepare(p_sDir:str, p_tFnm:tuple) -> dict:
    hRc = dict()
    hRc['m_pZer']   =   g.f_sJoinFilePath(p_sDir,p_tFnm[0])
    hRc['m_pTxt']   =   g.f_sJoinFilePath(p_sDir,p_tFnm[1])
    hRc['m_pBin']   =   g.f_sJoinFilePath(p_sDir,p_tFnm[2])
    return hRc

#   ===========================================================================
#   m:  prepare
#   ===========================================================================

#   const
C_DELAY_TIME    = 2
g.f_status()
s = g.f_version()
g.f_text("version : '%s'" % s)
g.f_trace("traceMe")
g.f_info("anyInfo")

#   prepare.dir : TOP
hTopDir   =   F_dirTop_prepare()
g.f_text("dHome     : '%s'" % hTopDir['m_sHom'] )
g.f_text("dScratch  : '%s'" % hTopDir['m_sScr'] )
g.f_text("dirTop    : '%s'" % hTopDir['m_sTop'])

#   prepare.fnm : MAJOR
tFnm    =   ("f0.tmp", "f1.txt", "f2.bin")
hMajor  =   F_fileMajor_prepare(hTopDir['m_sTop'],tFnm)
g.f_text("pZer : '%s'" % hMajor['m_pZer'] )
g.f_text("pTxt : '%s'" % hMajor['m_pTxt'] )
g.f_text("pBin : '%s'" % hMajor['m_pBin'])
g.f_test_bFileMake(hMajor['m_pZer'],0,100,True)
g.f_test_bFileMake(hMajor['m_pTxt'],1,100,True)
g.f_test_bFileMake(hMajor['m_pBin'],2,256,False)

#   add docFile 2 Major
dPwd        =       g.f_sPwd()
sFileDoc    =       m.g_sTutorReadmeFile
hMajor['m_pDoc']   =   g.f_sJoinFilePath(dPwd,sFileDoc)
pFileDoc    =   hMajor['m_pDoc']
g.f_text("pDoc : '%s'" % pFileDoc)

#   make Minor
sDir    =   hTopDir['m_sTop']
tDir    =   ("dAmerica", "dBelarus", "dEspania")
iSize   =   100
bRnd    =   True
hFileMinor =  g.f_test_hFileMake(sDir, tDir, 100, bRnd)

#
#   show minor
#

bVerbose = g.f__modeVerbose_get()
if bVerbose:
    i = 0
    for xKey in hFileMinor.keys():
        L = hFileMinor[xKey]
        for xFile in L:
            i += 1
            g.f_info("H [%s][%d] : %s" % (xKey,i,xFile))
    g.f_trace("end.show.minor")


s = hMajor["m_pTxt"]
sFileTmp = os.path.basename(hMajor["m_pZer"])
sFileTxt = os.path.basename(hMajor["m_pTxt"])
sFileBin = os.path.basename(hMajor["m_pBin"])
g.f_text("dirPwd    : '%s'" % (sDir))
g.f_text("FileTmp   : '%s'" % sFileTmp)
g.f_text("FileTxt   : '%s'" % sFileTxt)
g.f_text("FileBin   : '%s'" % sFileBin)

#   g.f__exit()
#   ready.prepare

#   ===========================================================================
#   m:  basic
#   ===========================================================================

#   https://docs.python.org/3/library/os.html

g.f_menu("basic")

#
#   s:  X.name        https://www.w3schools.com/python/ref_os_name.asp
#

g.f_menuS1("os:{name}")

#   osCall
s = os.name
g.f_text("sRc : '%s'" % s)

#   save posix state
if s == 'posix':
    bOsPosix = True
else:
    bOsPosix = False

#   show
s = "isPosix:'%r'" % bOsPosix
g.f_text(s)

#
#   s:  X.getenv      https://www.w3schools.com/python/ref_os_getenv.asp
#

g.f_menuS1("os:{getEnv}")
if bOsPosix:
    v = 'NAME'
else:
    v = 'USERNAME'

#   osCall
s = os.getenv(v)
g.f_text("x.getenv('%s') =: '%s'" % (v,s))


#
#   s:  X.environ     https://www.geeksforgeeks.org/python-os-environ-object/
#

g.f_menuS1("os:{environ}")
if bOsPosix:
    v = 'NAME'
else:
    v = 'USERNAME'

#   osCall via a list
s = os.environ[v]
g.f_text("x.environ[%s] =: '%s'" % (v,s))


#
#   s:  X.system      https://www.w3schools.com/python/ref_os_system.asp
#

g.f_menuS1("os:{system}")

if bOsPosix:
    sCmd = 'ls'
else:
    sCmd = 'dir'
sCmd += ' *.txt'

#   osCall
g.f_puts(">>> begin output...")
s = os.system(sCmd)
g.f_text("x.system(%s) =: '%s'" % (sCmd,s))
g.f_puts("<<< end")


#
#   s:  X.times       https://docs.python.org/3/library/time.html
#

g.f_menuS1("os:{times}")

#   osCall
t = os.times()

#   show
s = str(t)
g.f_text("x.times() =: '%s'"   % s)


#
#   s:  X.strerror    https://www.geeksforgeeks.org/python-os-strerror-method/
#

g.f_menuS1("os:{strError}")

for i in range(0,10):
    #   osCall
    s = os.strerror(i)
    g.f_text("strerror [%d] =: '%s'" % (i,s))


#   ===========================================================================
#   m:  random
#   ===========================================================================

g.f_menu("random")

#
#   s:  X.urandom     https://www.geeksforgeeks.org/python-os-urandom-method/
#

#   r:  generate random characters

g.f_menuS1("os:{urandom}")

i = 5
ayRc = os.urandom(i)
l = len(ayRc)
g.f_text("f(%d) => '%s'[%d]"   % (i,ayRc,l))
assert (l == i)
assert (isinstance(ayRc,bytes))

#   show byteArray as int
for i in range(0,l) :
    x   = ayRc[i]   # convert : byteArray => byte
    iRc = int(x)    # convert : byte => int
    g.f_text("abRc[%d] = byte[%02x]" % (i,iRc))


#   ===========================================================================
#   m:  directory
#   ===========================================================================

g.f_menu("directory")

#
#   s:  X.sep
#

#   h:  https://docs.python.org/3/library/os.html

g.f_menuS1("os:{sep}")

#   osCall
cSep = os.sep

#   show
g.f_text("x.sep => '%s'"   % (cSep))
assert (cSep == g.f_cFilePathSep())

#
#   s:  X.getcwd      https://www.tutorialspoint.com/python/os_getcwd.htm
#

g.f_menuS1("os:{getcwd}")

#   osCall
sPwd = os.getcwd()
g.f_text("os.getCwd => dirPWD:='%s'"   % (sPwd))


#
#   s:  X.chdir       https://www.tutorialspoint.com/python/os_chdir.htm
#

#   r:  change directory
g.f_menuS1("os:{chdir}")

#   fetchDirs
sDirHome    = hTopDir["m_sHom"]
sDirScratch = hTopDir["m_sScr"]
sDirTop     = hTopDir["m_sTop"]

#   osCall
os.chdir(sDirHome)

#   show currentDir
sDir = os.getcwd()
g.f_text("x.chdir => '%s'" % (sDirHome))
assert (sDir == sDirHome)

#   osCall : gotoScratch
os.chdir(sDirScratch)

#   show
sDir = os.getcwd()
g.f_text("dirScratch : '%s'" % (sDir))
assert (sDir == sDirScratch)

#   goBack.to.home
os.chdir(sDirHome)

#
#   s:  X.access    https://www.w3schools.com/python/ref_os_access.asp
#

#   r:  accessRight of (dir)-pathes, not for files

g.f_menuS1("os:{access}")

#   goBack.to.scratch
os.chdir(sDirScratch)
sDir = os.getcwd()
g.f_text("PWD : '%s'" % (sDir))

#   osCall::x.access
s   =   '.'
bRc =   os.access(s,os.F_OK)
g.f_text("os.ACCESS(%s) => '%r'"   % (s,bRc))
assert (True is bRc)

#   osCall::x.access
s   =   '/XYZ'    # CRQ-231210:DirSep:='/'
bRc =   os.access(s,os.F_OK)
g.f_text("os.ACCESS(%s) => '%r'"   % (s,bRc))
assert (False is bRc)

#   osCall::x.access
if (not bOsPosix):
    sEnv    = os.getenv("windir")
    assert (isinstance(sEnv,str))
    bEnv    = os.access(sEnv,os.F_OK)
    g.f_text("os.ACCESS(%s,fOK) => '%r'"   % (sEnv,bEnv))
    assert (True is bEnv)

#   osCall::x.access
s   = hTopDir['m_sScr']     ###   sDirScratch
bRc = os.access(s,os.R_OK)
g.f_text("os.ACCESS(%s,rOK) => '%r'"   % (s,bRc))
assert (True is bRc)

#   osCall::x.access
sRc     = os.access(s,os.W_OK)
g.f_text("os.ACCESS(%s,wOK) => '%s'"   % (s,sRc))
assert (True is bRc)

#   osCall::x.access
sRc     = os.access(s,os.X_OK)
g.f_text("os.ACCESS(%s,xOK) => '%r'"   % (s,sRc))
assert (True is bRc)

#
#   s:  X.listdir   h:  https://docs.python.org/3/library/os.html#os.listdir
#

g.f_menuS1("os:{listDir}")

#   goBack.to.scratch
os.chdir(sDirHome)
sDir = os.getcwd()
g.f_text("PWD : '%s'" % (sDir))

#   osCall::x.listdir
LRc = os.listdir()

#   parse with listdir
L = list()
for x in LRc:
    if ((x.find('.ps1') > 0) or
        (x.find('.bsh') > 0) or
        (x.find('.py') > 0)  or
        (x.find('.txt') > 0))   :
        L.append(x)

#   check list
n = len(L)
g.f_text("len(L) : '%d'" % n)
assert (len(L) > 3)

#   show
g.f_text("listDir => '%s'" % g.f_sList(L))

#
#   s:  X.walk      h:  https://www.tutorialspoint.com/python/os_walk.htm
#

g.f_menuS1("os:{walk}")

#   goto HOME
os.chdir(sDirHome)

#   generator
G = os.walk(".")
s = type(G)
g.f_text("type(G) =: '%s'"   % s)   # <class 'generator'>'

#   osCall::x.walk
i = 0
for tPath in G:
    #   currentDir, subDirs, files
    sPath = tPath[0]
    g.f_text("os.walk[%d] => '%s'"   % (i,sPath))
    i += 1
assert (i > 0)

#   goback to TOP
os.chdir(sDirTop)

#   ===========================================================================
#   m:  fileStatus
#   ===========================================================================

g.f_menu("fileStatus")

#
#   s:  X.stat      h:  https://www.tutorialspoint.com/python/os_stat.htm
#

g.f_menuS1("os:{status}")

pFileTmp = hMajor['m_pZer']
g.f_text("pFileTmp   : '%s'" % pFileTmp)
g.f_text("sFileTmp   : '%s'" % sFileTmp)

#   osCall
t  = os.stat(pFileTmp)
s = type(t)
g.f_text("type(t) =: '%s'"   % s)   # '<class 'os.stat_result'>'

#   convert
y  = t.st_mode

#   show
g.f_text("x.stat('%s') => %X"   % (sFileTmp,y))
assert (y > 0)


#   ===========================================================================
#   m:  osPath
#   ===========================================================================

g.f_menu("osPath")


#
#   s:  X.path.exists
#   h:  https://docs.python.org/3/library/os.path.html#os.path.exists
#

g.f_menuS1("os:{path.exists}")

s   =   sFileTmp
bRc =   os.path.exists(s)
g.f_text("f.exists ('%s') => <%r>" % (s,bRc))
assert (True is bRc)

s   =   pFileTmp
bRc =   os.path.exists(s)
g.f_text("f.exists ('%s') => <%r>" % (s,bRc))
assert (True is bRc)

s  =    sDirScratch
bRc =   os.path.exists(s)
g.f_text("f.exists ('%s') => <%r>" % (s,bRc))
assert (True is bRc)

#
#   s:  X.path.getsize
#   h:  https://docs.python.org/3/library/os.path.html#os.path.getsize
#

g.f_menuS1("os:{path.getsize}")

iRc = os.path.getsize(pFileDoc)
g.f_text("fileSize ('%s') =: '%d' Bytes" % (sFileDoc,iRc))
assert (iRc > 10)


#
#   s:  X.path.dirName
#

#   h:  https://docs.python.org/3/library/os.path.html#os.path.dirname

g.f_menuS1("os:{path.dirname}")

s       =   sFileTmp
sRc     =   os.path.dirname(s)
g.f_text("f.dirName (%s) => '%s'"   % (s,sRc))
assert (isinstance(sRc,str))


#
#   s:  X.path.abs
#   h:  https://docs.python.org/3/library/os.path.html#os.path.abspath
#

g.f_menuS1("os:{path.abspath}")

s       =   '.'
sRc     =   os.path.abspath(s)
g.f_text("f.absPath ('%s') => '%s'" % (s,sRc))
assert (isinstance(sRc,str))

s       =   sFileTmp
sRc     =   os.path.abspath(s)
g.f_text("f.absPath ('%s') => '%s'" % (s,sRc))
assert (isinstance(sRc,str))

#
#   s:  X.path.base
#   h:  https://docs.python.org/3/library/os.path.html#os.path.basename
#

g.f_menuS1("os:{path.basename}")
s       =   pFileTmp
sRc     =   os.path.basename(pFileTmp)
g.f_text("f.baseName ('%s') => '%s'" % (s,sRc))
assert (isinstance(sRc,str))

#
#   s:  X.path.split
#   h:  https://docs.python.org/3/library/os.path.html#os.path.splitext
#

g.f_menuS1("os:{path.splitext}:<fileExtension>")
s       =   pFileTmp
sRc     =   os.path.splitext(s)[1]
g.f_text("f.fileExtension ('%s') => '%s'" % (s,sRc))
assert (isinstance(sRc,str))

#
#   osPath.check
#

#   goback
os.chdir(sDirHome)

#
#   s:  X.path.isdir
#   h:  https://docs.python.org/3/library/os.path.html#os.path.isdir
#

g.f_menuS1("os:{path.isdir}")

s   =   sFileTmp
bRc =   os.path.isdir(s)
g.f_text("f.isDir ('%s') => <%r>" % (s,bRc))
assert (False is bRc)

s   =   pFileTmp
bRc =   os.path.isdir(s)
g.f_text("f.isDir ('%s') => <%r>" % (s,bRc))
assert (False is bRc)

s   =   sDirScratch
bRc =   os.path.isdir(s)
g.f_text("f.isDir ('%s') => <%r>" % (s,bRc))
assert (True is bRc)

#
#   s:  X.path.isfile
#   h:  https://docs.python.org/3/library/os.path.html#os.path.isfile
#

g.f_menuS1("os:{path.isfile}")

s   =   sFileTmp
bRc =   os.path.isfile(s)
g.f_text("f.isFile ('%s') => <%r>" % (s,bRc))
assert (False is bRc)

s   =   pFileTmp
bRc =   os.path.isfile(s)
g.f_text("f.isFile ('%s') => <%r>" % (s,bRc))
assert (True is bRc)

s   =   sDirScratch
bRc =   os.path.isfile(s)
g.f_text("f.isFile ('%s') => <%r>" % (s,bRc))
assert (False is bRc)

#
#   s:  X.path.isabs
#   h:  https://docs.python.org/3/library/os.path.html#os.path.isabs
#

g.f_menuS1("os:{path.isabs}")

s   =   sFileTmp
bRc =   os.path.isabs(s)
g.f_text("f.isAbs ('%s') => <%r>" % (s,bRc))
assert (False is bRc)

s   =   pFileTmp
bRc =   os.path.isabs(s)
g.f_text("f.isAbs ('%s') => <%r>" % (s,bRc))
assert (True is bRc)

s   =   sDirScratch
bRc =   os.path.isabs(s)
g.f_text("f.isAbs ('%s') => <%r>" % (s,bRc))
assert (True is bRc)

#
#   s:  X.path.splitDrive
#   h:  https://www.tutorialspoint.com/python/os_path_splitdrive.htm
#

g.f_menuS1("os:{path.splitdrive}")

s       = pFileTmp
sRc     = os.path.splitdrive(s)
g.f_text("f(%s) =>  '%s'" % (s,sRc))


#   s:  X.path.splitText
#   h:  https://www.tutorialspoint.com/python/os_path_splitext.htm

g.f_menuS1("os:{path.splitext}")

s       = pFileTmp
sRc     = os.path.splitext(s)
g.f_text("f(%s) =>  '%s'" % (s,sRc))


#
#   s:  X.path.join
#   h:  https://docs.python.org/3/library/os.path.html#os.path.join
#

g.f_menuS1("os:{path.join}")

#   r:  sPth = f(sDrv,sFile1,sFile2,...sFileN)

if not bOsPosix:
    s,t     = "y:dir", ("abc","def","123")
    sRc     = os.path.join(s,t[0],t[1],t[2])
    g.f_text("f(%s,%s) => %s"   % (s,t,sRc))
    assert (sRc == 'y:dir\\abc\\def\\123')  #  y:dir\abc\def\123

if not bOsPosix:
    s,t     = "x:dir\\", (":1bc","def","xyz\\")
    sRc     = os.path.join(s,t[0],t[1],t[2])
    g.f_text("f(%s,%s) => %s"   % (s,t,sRc))
    assert (sRc == 'x:dir\\:1bc\\def\\xyz\\')

#
#   s:  X.path.normpath
#   h:  https://docs.python.org/3/library/os.path.html#os.path.normpath
#

g.f_menuS1("os:{path.normpath}")

#   r:  sPth = f(sPth1,.sPthN)

if bOsPosix:
    tDir  = ("abc.py/","/peter/otto/")
else:
    tDir  = ("abc.py/","x://peter/harvey/")

for i in range(0,len(tDir)):
    sDir = tDir[i]
    sRc  = os.path.normpath(sDir)
    g.f_text("f(%s) => %s"   % (sDir,sRc))

if bOsPosix:
    assert (sRc is not None)
else:
    assert (sRc == 'x:\\peter\\harvey')

#
#   s:  X.path.getTime_at
#

#   h:  https://docs.python.org/3/library/os.path.html#os.path.getatime

g.f_menuS1("os:{path.getatime}")

#   goto    :   TOP
os.chdir(sDirTop)

#   use
sFile = pFileTmp
g.f_text("using file : %s"   % sFile)

#   osCall:getatime
fRc   = os.path.getatime(sFile)     # access time
g.f_text("f.getTime_at  => %f"   % fRc)   # retun float
assert (fRc > 1550000000.0)

#
#   s:  X.path.getTime_,
#   h:  https://docs.python.org/3/library/os.path.html#os.path.getmtime
#

#   osCall:getmtime
fRc   = os.path.getmtime(sFile)             #   access time

g.f_text("f.getTime_m  => %f"   % fRc)      #   retun float
assert (fRc > 1550000000.0)

#
#   s:  X.path.getTime_c
#   h:  https://docs.python.org/3/library/os.path.html#os.path.getctime
#

if bOsPosix:
    fRc = os.path.getcTime(sFile)           #   access time
    g.f_text("f.getTime_c  => %f"   % fRc)  #   retun float
    assert (fRc > 1550000000.0)


#   ===========================================================================
#   m:  fileHandling
#   ===========================================================================

g.f_menu("FileHandling")

#   goto topDir
os.chdir(hTopDir["m_sTop"])
sDir = os.getcwd()

s = hMajor["m_pTxt"]
sFileTmp = os.path.basename(hMajor["m_pZer"])
sFileTxt = os.path.basename(hMajor["m_pTxt"])
sFileBin = os.path.basename(hMajor["m_pBin"])
g.f_text("dirPwd    : '%s'" % (sDir))
g.f_text("FileTmp   : '%s'" % sFileTmp)
g.f_text("FileTxt   : '%s'" % sFileTxt)
g.f_text("FileBin   : '%s'" % sFileBin)

#
#   s:  open        h:  https://docs.python.org/3/library/os.html#os.open
#

g.f_menuS1("os:{open} :fileOpen")

fp = os.open(sFileTmp, os.O_RDWR | os.O_CREAT)
g.f_text("open => fp = '%s'"   % (fp))

#
#   s:  write       h:  https://docs.python.org/3/library/os.html#os.write
#

g.f_menuS1("os:{write} :fileWrite")

#   osCall:write
os.write(fp, b"abcdefgh")

#   osCall:write array
ay = bytes([0xa1,0xa2])     # x  = ay[0]
os.write(fp,ay)

#
#   s:  X.lseek     h:  https://docs.python.org/3/library/os.html#os.lseek
#

g.f_menuS1("os:{lseek}")

#   osCall:lseek
os.lseek(fp,0,os.SEEK_SET)      # goto begin

#
#   s:  X.read      h:  https://docs.python.org/3/library/os.html#os.read
#

g.f_menuS1("os:{read} :fileRead")

#   osCall:read
yaRc = os.read(fp,20)

g.f_text("open.read => '%s'" % str(yaRc))
assert (isinstance(yaRc,bytes) is True)

#
#   s:  X.close     h:  https://docs.python.org/3/library/os.html#os.close
#

#   osCall:close
os.close(fp)

#
#   s:  X.rename    h:  https://www.tutorialspoint.com/python/os_rename.htm
#

g.f_menuS1("os:{rename} :fileRename")

i = C_DELAY_TIME
sFileRen = 'f0Renamed.tmp'
g.f_text("FileRen   : '%s'" % sFileRen)
g.f_text("try os.reName(%s) => %s in:[%d]"  % (sFileTmp,sFileRen,i))
g.f_sleep(i)

bEc = False
try:
    os.rename(sFileTmp,sFileRen)    #   rename: TMP => REN
except Exception:
    bEc = True

assert (False is bEc)

#
#   s:  X.remove    h:  https://docs.python.org/3/library/os.html#os.remove
#

g.f_menuS1("os:{remove} :fileRemove")

sDir = os.getcwd(); g.f_text("dirPwd : '%s'" % (sDir))
bEc = False
i = C_DELAY_TIME
g.f_text("try os.reMove(%s) in:[%d]"   % (sFileRen,i))
g.f_sleep(i)

try:
    os.remove(sFileRen)             #   remove REN
except Exception:
    bEc = True

g.f_text("os.reMove(%s) => %r"   % (sFileRen,not bEc))
assert (False is bEc)

#   ---------------------------------------------------------------------------
#   m:  restore
#   ---------------------------------------------------------------------------

bRc = g.f_test_bFileMake(hMajor['m_pZer'],0)
assert (True is bRc)

fp = os.open(sFileTmp, os.O_RDWR | os.O_CREAT)
os.write(fp, b"1234567890")
os.close(fp)
iRc = os.path.getsize(sFileTmp)
assert (iRc == 10)
g.f_text("tmpFile '%s' restored => %d."   % (sFileTmp,iRc))


#   === :footer
os.chdir(sDirHome)
g.f_footer(sTc)

#   end
#   &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
#   g.f__exit()
#   &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
