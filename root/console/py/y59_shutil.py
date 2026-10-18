#   ***************************************************************************
#   My Python Tutorial  ::  shutil only
#   ***************************************************************************
#   -$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   MOD:    shutil

#   === :header

import shutil   # shell utilities
import os
import LIB_inc as m;    g = m.CLib();   sTc = 'TcOs'
g.f_header(sTc)

#   === :content
'''
    content:
        m:  helper
        m:  prepare
        m:  shutil
            s:  X.copy
            s:  X.copyFile
            s:  X.move
            s:  X.copyTree
            s:  X.rmTree
            s:  X.get_archive_format
            s:  X.make_archive
            s:  X.unpack_archive
'''

#   b:  body

#   ===========================================================================
#   m:  helper
#   ===========================================================================

#   import random : already

#   home,scratch,top
def F_dirTop_prepare() -> dict:
    hRc = dict()
    b,h     =   g.f_bhFilePath_member(__file__)
    assert (True is b)
    sBdy    =   h['m_sBdy']
    hRc['m_sHom']   =   g.f_sPwd()
    hRc['m_sScr']   =   g.f_sLogDirectory()       # !SCRATCH
    hRc['m_sTop']   =   g.f_sJoinFilePath(hRc['m_sScr'],sBdy[0:3])
    bRc,_sRc = g.f_mkDir(hRc['m_sTop'])
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

g.f_menu("prepare")

s = g.f_version()
bOsPosix = g.f_bOsPosix()
g.f_text("version   :   '%s'" % s)
g.f_text("posix     :   '%r'" % bOsPosix)

#   prepare.dir : TOP
hTopDir   =   F_dirTop_prepare()
g.f_text("dHome     : '%s'" % hTopDir['m_sHom'] )
g.f_text("dScratch  : '%s'" % hTopDir['m_sScr'] )
g.f_text("dirTop    : '%s'" % hTopDir['m_sTop'])
dPwd = os.getcwd()
g.f_text("dPwd      : '%s'"   % dPwd)


#   prepare.fnm : MAJOR
tFnm    =   ("fShr.tmp", "fShr.txt", "fShr.bin")
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
sDirTop =   hTopDir['m_sTop']
tDirTop =   ("zArsenal", "bBorussia", "cFalcons")
iSize   =   100
bRnd    =   True
hFileMinor =   g.f_test_hFileMake(sDirTop, tDirTop, 100, bRnd)

#   show minor
bVerbose = g.f__modeVerbose_get()
if bVerbose :
    i = 0
    for xKey in hFileMinor.keys():
        L = hFileMinor[xKey]
        for xFile in L :
            i += 1
            g.f_info("H [%s][%d] : %s" % (xKey,i,xFile))
    g.f_trace("end.show.minor")

#   fetch names
pFileTmp = hMajor["m_pZer"]
pFileTxt = hMajor["m_pTxt"]
pFileBin = hMajor["m_pBin"]
pFileDoc = hMajor['m_pDoc']
sFileTmp = os.path.basename(pFileTmp)
sFileTxt = os.path.basename(pFileTxt)
sFileBin = os.path.basename(pFileBin)
sFileDoc = os.path.basename(pFileDoc)
g.f_text("topDir    : '%s'" %  hTopDir['m_sTop'])
g.f_text("FileTmp   : '%s'" % sFileTmp)
g.f_text("FileTxt   : '%s'" % sFileTxt)
g.f_text("FileBin   : '%s'" % sFileBin)
g.f_text("FileDoc   : '%s'" % sFileDoc)

#   ===========================================================================
#   m:  shutil
#   ===========================================================================

g.f_menu("Shell Utilities")

#
#   s:  X.copy
#

#   h:  https://docs.python.org/3/library/shutil.html
#   r:  copy file onto file or into directory

g.f_menuS1("shutil:{copy}")

#   save size
iSrc = os.path.getsize(pFileDoc)
assert (iSrc > 0)

#
#   u:  X.copy(file,file)
#

g.f_menuS2("X.{copy} : file->file")

#   parameter
g.f_text("pSrc : '%s'"   % pFileDoc)
g.f_text("pObj : '%s'"   % pFileTmp)

#   shCall:copy(file,file)
sRc  = shutil.copy(pFileDoc,pFileTmp)

#   show and check
g.f_text("copy(pSrc,pObj) -> <%s> " % sRc)
assert (sRc == pFileTmp)

#   get Size
iObj = os.path.getsize(pFileTmp)
g.f_text("fileSize(obj) =: <%d>"   % iObj)
assert (iObj == iSrc)

#
#   u:  X.copy(file,dir)
#

g.f_menuS2("X:{copy} : file->dir")

dObj = g.f_sJoinFilePath(sDirTop,'zArsenal')
g.f_text("pSrc : '%s'"   % pFileDoc)
g.f_text("dObj : '%s'"   % dObj)

#   shCall:copy(file,dir)
sRc  = shutil.copy(pFileDoc,dObj)

#   prepare return check
sFnm = g.f_sFileName(pFileDoc)
pObj = g.f_sJoinFilePath(dObj,sFnm)

#   show and check
g.f_text("copy(pSrc,dObj) -> <%s> " % sRc)
assert (sRc == pObj)


#
#   s:  X.copyFile
#

#   h:  https://docs.python.org/3/library/shutil.html#shutil.copyfile

g.f_menuS1("shutil:{copyFile}")

#   parameter
g.f_text("pSrc : '%s'"   % pFileDoc)
g.f_text("pObj : '%s'"   % pFileTmp)

#   shCall:copyfile(file,file)
sRc  = shutil.copyfile(pFileDoc,pFileTmp)

#   show and check
g.f_text("copy(pSrc,pObj) -> <%s> " % sRc)
assert (sRc == pFileTmp)


#
#   s:  X.move
#

#   h:  https://docs.python.org/3/library/shutil.html#shutil.move
#   r:  Recursively move a file or directory (src)
#       to another location and return the destination.

g.f_menuS1("shutil:{move}")

#   fetch.src
pSrc = pFileBin
dObj = g.f_sJoinFilePath(sDirTop,'zArsenal')

#   prepare.obj
sBdy = g.f_sFileNameBody(pSrc)
sExt = g.f_sFileNameExtension(pSrc)
sBdy = sBdy + '_moved'
sFnm = sBdy + sExt
pObj = g.f_sJoinFilePath(dObj,sFnm)

#   parameter
g.f_text("pSrc : '%s'"   % pSrc)
g.f_text("pObj : '%s'"   % pObj)
iSrc = os.path.getsize(pSrc)
g.f_text("fileSize(pSrc : <%d>" % iSrc)

#   shCall:move(file,file)
if not bOsPosix:
    sRc = shutil.move(pSrc,pObj)        # overwrite ifNot exist
    g.f_text("rc =: <%s>"  % sRc)
    bSrc = g.f_bFileExists(pSrc)
    assert (False == bSrc)
    bObj = g.f_bFileExists(pObj)
    assert (True == bObj)
    iObj = os.path.getsize(pObj)
    g.f_text("fileSize(pObj): <%d>" % iObj)
    assert (iObj == iSrc)

#
#   s:  X.copyTree
#

#   https://docs.python.org/3/library/shutil.html#shutil.copytree
#   r:  can't overwrite

g.f_menuS1("shutil:{copyTree}")

#   paramter
dSrc = g.f_sJoinFilePath(sDirTop,'cFalcons')
dObj = g.f_sJoinFilePath(sDirTop,'dIceTigers')
g.f_text("dSrc : '%s'"   % dSrc)
g.f_text("dObj : '%s'"   % dObj)

#   prepare dObject - remove if exists
bRc,sRc = g.f_rmDir(dObj)

#   shCall:copyTree(dir,dir)
bEc = False
try:
    sRc = shutil.copytree(dSrc, dObj)       # dObj may not exists
except Exception:
    bEc = True
assert (False is bEc)

#   check
g.f_text("sRc =: %s" % sRc)
assert (dObj is sRc)


#
#   s:  X.rmTree
#

#   h:  https://docs.python.org/3/library/shutil.html#shutil.rmtree

g.f_menuS1("shutil:{rmTree}")

#   prepare
pDir = g.f_sJoinFilePath(sDirTop,'zArsenal')
bDir = g.f_bIsDir(pDir)
g.f_text("sDir : '%s'"   % pDir)
g.f_text("bDir : '%s'"   % bDir)
assert (True is bDir)

#   shCall:rmTree
bEc = False
try:
    xRc = shutil.rmtree(pDir)
except Exception:
    bEc = True
assert (False is bEc)

#   check
g.f_text("xRc =: %r" % xRc)
assert (None is xRc)
bDir = g.f_bIsDir(pDir)
g.f_text("bDir : '%s'"   % bDir)
assert (False is bDir)


#
#   s:  X.get_archive_format
#

#   h:  https://www.geeksforgeeks.org/python-shutil-get_archive_formats-method/


g.f_menuS1("shutil:{getArchiveFormats}")

#   shCall:getArchiveFormats
ltRc = shutil.get_archive_formats()

#   show all
i = 0
for x in ltRc :
    g.f_text("t[%d] : '%s'" % (i,x))
    i += 1


#
#   s:  X.make_archive
#

#   h:  https://docs.python.org/3/library/shutil.html#shutil.make_archive

g.f_menuS1("shutil:{make_archive}")

#   my location
dPwd =  g.f_sPwd()
g.f_text("dPwd : '%s'"   % dPwd)

#   prepare.src
dSrc =  g.f_sJoinFilePath(sDirTop,'cFalcons')
g.f_text("dSrc : '%s'"   % dSrc)

#   prepare.obj
sNam = 'BirdInTown'
dObj =  sDirTop
pObj =  g.f_sJoinFilePath(dObj,sNam)
g.f_text("pObj : '%s'"   % pObj)

#   fetch format
aFmt = ('tar','zip')
i = g.f_iRandom(); i %= 2; iFmt = i
sFmt = aFmt[i]
fObj = sNam + '.' + sFmt
g.f_text("sFmt : '%s'"   % sFmt)
g.f_text("fObj : '%s'"   % fObj)

#   shCall:make_archive
bEc = False
try:
    sRc = shutil.make_archive(pObj,sFmt,dSrc)
except Exception:
    bEc = True
assert (False is bEc)

#   goto dPwd
#   os.chdir(dPwd)

#   check
pObj =  g.f_sJoinFilePath(dObj,fObj)
g.f_text("pObj : '%s'"   % pObj)
bFile = g.f_bIsFile(pObj)
g.f_text("bFile : '%s'"   % bFile)
iObj = os.path.getsize(pObj)
g.f_text("fileSize(pObj): <%d>" % iObj)
assert (iObj > 0)

#   show
g.f_text("sRc =: %s" % sRc)
assert (pObj == sRc)


#
#   s:  X.unpack_archive
#

#   h:  https://www.geeksforgeeks.org/python-shutil-unpack_archive-method/

g.f_menuS1("shutil:{unpack_archive}")

#   prepare
pSrc = pObj
dObj = g.f_sJoinFilePath(sDirTop,'bBorussia')
g.f_text("pSrc : '%s'"   % pSrc)
g.f_text("dObj : '%s'"   % dObj)

#   shCall:unpackArchive
bEc = False
try:
    sRc = shutil.unpack_archive(pSrc,dObj)
except Exception:
    bEc = True
assert (False is bEc)

#   show rc
g.f_text("sRc : '%s'"   % sRc)
assert (None is sRc)

#   === :footer
g.f_footer(sTc)
g.f__exit()

#   end
