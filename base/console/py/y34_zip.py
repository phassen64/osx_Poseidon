#   ***************************************************************************
#   My Python Tutorial  ::  zip
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$
#   mod:   zipfile
#   url:   https://pymotw.com/2/zipfile/

#   === :header
import os
import sys
import LIB_inc as m;    g = m.CLib();   sTc = 'tcZip'
g.f_header(sTc)

#
#   wrapper
#

def F_zipFiles(p_lFiles,p_sFile='tmp.zip'):
    iRc = g.f_zipPack(p_lFiles,p_sFile=p_sFile,p_bVerbose=True)
    return iRc

def F_zipInfo(p_sFile='tmp.zip'):
    iRc = g.f_zipInfo(p_sFile)
    return iRc

def F_zipExtract(p_sDir2Unzip,p_sFile='tmp.zip'):
    iRc = g.f_zipExtract(p_sDir2Unzip,p_sFile)
    return iRc

#   body
g.f_menu("Init")

#   m:  os
bOsPosix = g.f_bOsPosix()

#   m:  scriptname
sScp = os.path.basename(sys.argv[0])
sBdy = g.f_sFileNameBody(sScp)
g.f_text("sBdyScp => %s" % (sBdy))

#   m:  fetch localDir
sDirPwd = os.getcwd()
g.f_text("dHome  => %s" % (sDirPwd))

#   m:  fetch scratchDir == tmp  !SCRATCH
sDirTmp = g.f__sOsDirTmp()
g.f_text("dTMP  => %s" % (sDirTmp))

#   m:  goto tmpDir
os.chdir(sDirTmp)
sPwd = os.getcwd()
g.f_text("dirCurrent => %s" % (sPwd))

#   m:  make dir names
g.f_menu("make dirnames")
cSep = g.f_cFilePathSep()
#   topName
sNamTop =  sBdy[0:3]        #   'y12_tmp.py' => 'y12'
sDirTop  = sDirTmp + cSep + sNamTop
sDirSrc  = sDirTop + cSep + 'src'
sDirObj  = sDirTop + cSep + 'obj'
sDirTmp  = sDirTop + cSep + 'tmp'

g.f_text("sDirTop=%s" % (sDirTop))
g.f_text("sDirSrc=%s" % (sDirSrc))
g.f_text("sDirObj=%s" % (sDirObj))
g.f_text("sDirTmp=%s" % (sDirTmp))

#   m:  rmdir tree
g.f_menu("rmDirTree")
g.f_text("rmDir=<%s>..." % (sDirTop))
g.f_sleep(1)
bRc,sRc = g.f_rmDir(sDirTop)
g.f_text("rmdir.zip => %s:%s..." % (bRc,sRc))
g.f_sleep(1)

#   m:  create dirs itself
g.f_menu("createDirs")
g.f_text("mkDir=<%s>..." % (sDirTop))
bRc,sRc = g.f_mkDir(sDirTop)
g.f_text("mkdir.zip => %s:%s" % (bRc,sRc))
assert (True == bRc)
if bRc :
    bRc,sRc = g.f_mkDir(sDirSrc)
    g.f_text("mkdir.src => %s:%s" % (bRc,sRc))
    bRc,sRc = g.f_mkDir(sDirObj)
    g.f_text("mkdir.obj => %s:%s" % (bRc,sRc))
    bRc,sRc = g.f_mkDir(sDirTmp)
    g.f_text("mkdir.obj => %s:%s" % (bRc,sRc))

#   m:  goto srcDir
os.chdir(sDirSrc)
sPwdSrc = os.getcwd()
g.f_text("dirCurrent => %s" % (sPwdSrc))

#   m:  create 3 files in the srcDir
g.f_menu("create3Files")
sFile1 = sBdy + '_1.txt'
sFile2 = sBdy + '_2.txt'
sFile3 = sBdy + '_3.txt'
bRc,sRc = g.f_bFileCreate(sFile1)
g.f_text("createFile1 <%s> =: %r" % (sFile1,bRc) )
bRc,sRc = g.f_bFileCreate(sFile2)
g.f_text("createFile2 <%s> =: %r" % (sFile2,bRc) )
bRc,sRc = g.f_bFileCreate(sFile3)
g.f_text("createFile2 <%s> =: %r" % (sFile3,bRc) )

#   m:  write the 3 new files
g.f_menu("write3Files")
iRc = g.f_iFileWrite(sFile1,'ABCDEFGHIJ'); assert (iRc > 0)
iRc = g.f_iFileWrite(sFile2,'12345678'); assert (iRc > 0)
iRc = g.f_iFileWrite(sFile3,'PeterMickeyRooney'); assert (iRc > 0)

#   m:  save names into a List
lFile = []
lFile += [sFile1]
lFile += [sFile2]
lFile += [sFile3]
g.f_text("created FileList   => %s" % (lFile))

#   m:  list dir
lFiles2Zip = os.listdir('.')
g.f_text("lDirTree=%s" % (lFiles2Zip))

#   m:  zip
sNam    =   sBdy + '.zip'
sDir    =   sDirTmp
pZip    =   g.f_sJoinFilePath(sDir,sNam)
g.f_text("zipDir : '%s'" % pZip)
iRc = F_zipFiles(lFiles2Zip,pZip)
assert (iRc > 0)
g.f_text("zipped files = <%d>" % (iRc))

#   m:  move zipFile to objDir
g.f_menu("move zipFile to objDir")
bRc,sRc = g.f_bFileMove(pZip,sDirObj)
g.f_text("moved f(%s,%s) => %r|%s" %
        (pZip,sDirObj,bRc,sRc))

#   m:  read new zipfile - info
g.f_menu("read new zipfile")
os.chdir(sDirObj)
g.f_text("readZipDir := %s" % (os.getcwd()))

#   m:  info
pZip    =   g.f_sJoinFilePath(sDirObj,sNam)
F_zipInfo(pZip)

#   m:  read new zipfile - info
g.f_menu("zip extract")
iRc = F_zipExtract(sDirTmp,pZip)
assert (iRc > 0)
g.f_text("extracted files=%d" % (iRc))

#   m:  goto homeDir
g.f_menu("gotoHome")
os.chdir(sDirPwd)
sRc = os.getcwd()
g.f_text("dirLast => %s" % (sRc))

#   === :footer
g.f_footer(sTc)
