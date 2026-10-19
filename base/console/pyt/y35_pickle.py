#   coding:UTF-8
#   ***************************************************************************
#   My Python Tutorial  ::  pickle & shelve
#   ***************************************************************************
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   Dieses Script erstellt LogFile m.H. der Module 'pickle' und 'shelve'.
#   Unterschiede:
#   Pickle: Sichert saemtliche Python-DatenTypen direkt.
#           Das Pickle-File muss mit open/close geoeffnet/geschlossen werden.
#   Shelve: Sichert saemtliche Python-DatenTypen in einem String-Dictionary-
#           Das Shelve-File wird autoamtisch geoeffnet bzw. geschlossen.
#   mod:    pickle, shelve

#   === :header
#   import sys
import pickle
import shelve
import LIB_inc as m;    g = m.CLib();   sTc = 'tcPickle'
g.f_header(sTc)

#   === :content
''' content
        m:  pickle
        m:  shelve
'''

#   build script-name 2 tmpfile
bRc,hRc     =   g.f_bhFilePath_member(__file__)
sNam        =   hRc['m_sNam']
sBdy        =   hRc['m_sBdy']
sDirScratch        =   g.f__sOsDirTmp()        # fetch scratchDir


#
#   m:  pickle
#
g.f_menu("pickle")

sNam        =   sBdy + "_pkl.tmp"
sPth        =   g.f_sJoinFilePath(sDirScratch,sNam)
sFile       =   sPth
g.f_text("pFile : %s" % sFile)

C_FILE_SIZE_MAX = 500

#   --- check size before re-dump
iSz = g.f_iFileSize(sFile)
if (iSz > C_FILE_SIZE_MAX):
    s = "rmFile:%s" % (sFile)
    bRc = g.f_bFileDelete(sFile)
    g.f_text("%s : %s" % (s,bRc))

#   --- re-dump data
g.f_text("pickLe.Load(%s)...?" % (sFile))
try:
    fpLoad = open(sFile, "rb")
    l = pickle.load(fpLoad)
    fpLoad.close()
    g.f_text("l.old=%s" % (l))
except Exception as iExc:
    l = list()
    sExc = str(iExc)
    g.f_text("fp==NONE exc=:%s" % (sExc))

#   dump data
g.f_text("dump file(%s)..." % (sFile))
tm  = g.f_sTime()
l.append(tm)
g.f_text("l.new=%s" % (l))

#   write into pickle
fpWrite = open(sFile, "wb")
g.f_text("type(fp) : %s" % type(fpWrite))
g.f_text("pickLe.Dunp(%s)...?" % (sFile))
pickle.dump(l,fpWrite)
fpWrite.close()

#   check fileSize
iSz = g.f_iFileSize(sFile)
g.f_text("fileSize(file=%s) => <%d>" % (sFile,iSz))

#
#   m:  shelve
#

#   shelve kann Daten sichern in Form eines String-Dictionaries
#   Vorteil ggu pickle - open,close ist in der Aktion m. shelve enthalten

g.f_menu("shelve")

#   !CRQ-241209:notwith vpython
bIsVpy = g.f_bPythonVpy()
g.f_text("bIsVpy : %r" % bIsVpy)
if (bIsVpy) :
    g.f_warning('NotShelveIfVpy'); g.f__exit(0)     # !CRQ-241209:NotInVPy


#   build filename
sNam        =   sBdy + "_shf.tmp"
sPth        =   g.f_sJoinFilePath(sDirScratch,sNam)
sFile       =   sPth

sFile       =   sPth
g.f_text("pFile : %s" % sFile)

# create a shelf(=Regal)
g.f_text("shelve.open(%s)" % (sFile))
fpShv  = shelve.open(sFile)
g.f_text("type(Shelf) => {%s}" % (type(fpShv)))
g.f_text("len(Shelf)  => {%s}" % (len(fpShv)))

# show old value if exists
# convert shelf into dictionary and show old saved values
if (len(fpShv) > 0):
    h = dict(fpShv)
    s = g.f_sHash(h)
    g.f_text("show old converted Shelf=>dict \n(%s)" % (s))

# add(=shelve=Archivieren) data
g.f_text("shelve add...")
fpShv["street"]  = "KuenhoferStr"
fpShv["city"]    = "Nuernberg"
fpShv["time"]    = g.f_sTime()     # update

g.f_text("shelve.close(%s)" % (sFile))
fpShv.close()

#   === :footer
g.f_footer(sTc)
