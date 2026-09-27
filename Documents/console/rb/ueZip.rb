=begin
12345678901234567890123456789012345678901234567890123456789012345678901234567890
   UltraEdit Zipper extension
    Author  :   P.Hassen;
    City    :   Ulm/Nueremberg
    Date    :   June-2018; upd: Aug-2019, upd: Feb-2021
    Version :   UltraEdit Text/Hex Editor (x64)  Version 24.20.0.27
    Remarks :   This Script should be used with the BatchFile "uez.bat"

    DES     :   Zip Content of an Ultra-Edit-Project-File (UEP-File)
                into a UED-ZipFile (UEZ-File) for a later 'unzip'.

    Usage   :   used a) by UltaEdit UserTools
                or   b) by Command Interpreter(cmd.exe) of Windows
                UEZ-Files will be named like
                    UEP-FilePath.prj => UEP-<date>.zip
                Example:
                    UEP: "d:\KNT\prj\UEZ.prj" => "x:\TMP\UEZ-180806.zip"

    Commands:   'zip','unzip','build','parse'
                *   'zip' d:\MY\cmd\r\uez.bat zip %R E:\TMP
                *   'unzip' d:\MY\cmd\r\uez.bat unzip %R E:\TMP
                *   'build' d:\MY\cmd\r\uez.bat buil %R E:\TMP
                *   'parse' uez <uePrjFile> <zipDir>

    globals :   using Environment-Variables of cmd.exe:
                    TMP             :   DOS temp directory => ENV['TMP']
                    v_FWK_exitCode     :   default exit value (==%ERRORLEVEL%)
    topics  :
                +   parsing an UEP-File
                +   creating UEP-Files
                +   using a UEP-Files to restore files
                +   cleaning the working dirs
                +   building an own UEP-File

    !CRQ-220108 :   a) projectDirectory 'c:\' issue produces wrong filePathes
                :   b) dir "\_tmp1" and dir "\__tmp2"

=end

require_relative "LIB.inc"      #   own library -
require 'optparse'              #   option parsing
require 'fileutils'             #   cp,rm,mv files
require 'zip'                   #   zip/unzip files => rubyzip https://github.com/rubyzip/rubyzip # !CRQ-210221
require 'tmpdir'                #   gets windows tmpDir
require 'find'                  #   searches files at Dir

#   global defines
C_DEBUG=false                   # only for debugging
C_VERBOSE=true                  # more local trace
C_TRACE=false                   # control my trace
C_UEZ_TAGS=true                 # UEP header and footer, ignored by ued

#   DIR empty
C_DIR_THIS      =   '.'         # dirname returns '.' always

#   commands
C_CMD_ZIP       =   'zip'
C_CMD_UNZIP     =   'unzip'
C_CMD_BUILD     =   'build'
C_CMD_PARSE     =   'parse'

#   option: overwrite
C_OPT_OVERWRITE_INFO        =   '?'     #   get help
C_OPT_OVERWRITE_ADD         =   'a'     #   addOnly only,when target not exists
C_OPT_OVERWRITE_UPDATE      =   'u'     #   update, if zip is newer than target
C_OPT_OVERWRITE_RESTORE     =   'r'     #   restore,if zipArchives is older
C_OPT_OVERWRITE_FORCE       =   'f'     #   don't care - extract always
C_OPT_OVERWRITE_NEVER       =   'n'     #   don't care - never overwrite

#   option: uep type
C_OPT_UEPTYPE_ISO   =   'iso'
C_OPT_UEPTYPE_UTF   =   'utf'
C_OPT_UEPTYPE_WRD   =   'wrd'

#   File Extension Lists (FEL) -- option
C_FEL_ID__ANY   =   '.'     # all extensions possible
C_FEL_ID__SEP    =  ':'     # fileExtensionList  !REM: '|' not in DOS
C_FEL_ZIP       =   ':txt:rb:py:pm:pl:c:cpp:h:bsh:bat:ps1:psm1' # standard
C_FEL_CLEAN     =   ':log:zip:tmp:rb'           #   CLEAN defaults
C_FEL_BUILD     =   C_FEL_ZIP.to_s + ':log'

#   uep project files
C_FILE_EXTENSION_UEP      =  '.uez.prj'

#  !REM: 'RESTORE' changes the DATE of the target the newest one.
#           It is hard to find a way, to extract by using date stamp
#           stored in the zip file.

#   ***************************************************************************
#   usages - switch ON or OFF
#   ***************************************************************************

C__USE_DUPLICATE=false          # using addionally output-files at the TmpDir
C__USE_TESTMODE=false           # some test code
C__USE_MOVE_TXT_TMP2OBJ=true    # move zipTxt from tmpDir to objectDir

#   uez texfile build numeration
C__USE_UEZ_NUMERATOR = true
if (C__USE_UEZ_NUMERATOR == true)   # How To Write a uep-zipTxt file ?
    C__USE_UEZ_NUMERATOR_GRP = true     # 1) write group-parts
    C__USE_UEZ_NUMERATOR_TXT = false    # 2) write numerations like '00'
end

#   use auto date time naming ?
if (C__USE_TESTMODE == true)
    C__USE_UEZ_NUMERATOR_TXT    = true
    C__USE_UEP_DT_NAME          = false
else
    C__USE_UEP_DT_NAME=true        # standard is TRUE
end

#   ***************************************************************************
#   Usage Text
#   ***************************************************************************

$sUsage = <<myUsage

<<< usage:begin

    $> ruby <script.rb> { <request> || <command> }

    <request>
        --clean     :   clean tmpDir
        --usage     :   usage of this

    <command>
        --cmd <commandId> <mandatory parameters> [ <optional parameters> ]

    <commandId>
        {'help','usage'}
        {'zip','unzip','parse','build'}

    <mandatory parameters>=:<"manP">
        --prj <uePrjFilePath>.prj  : UE-Project-File    # uepFile
        --dir <zipFileDir>  :   name(-Pattern) of UEZ-Files as input- or output-Dir

    <mandatory parameters extended>=:<"manPX">
        --obj <unzipDir>    :   where to unzip the files cmd:{'unzip'}

    <optional parameters>=:<"optP">
        --typ               :   'iso','utf','wrd'       # uepType
        --color             :   show req||cmd in DOS color mode (useless for UedTools)
        --verbose           :   show command infos
        --warning           :   show command warnings
        --ext <FileExtList> :   File extensions to handle example:
                                '.txt:.rb:.pl'      # Text-,Ruby,-Python Files
                                if omitted = FileExtList=:stdFileExtList ("FEL")

    === overview <command>

    zip     :   creates a zipFile like 'uePrjFile'-<date>.zip
    unzip   :   extract zipFile, if uep-file is input, use the newest zipFile
    parse:      parses the UEP File only - output results into --Dir
    build   :   build an ueditProjectFile using inputDir and FileExtList
                build --dir <DirTree> --ext <FileExtensions>='.ext1.ext2...extN'

    ===  details

    <cmd>:={'zip'} <"manP"> [--tag]
        --tag          :   create a zipTxt-file with tag-entries

    <cmd>:={'unzip'} <"manPX"> [--flat] [--overwrite <x>] [<"optP">]
        --flat              :  unzip instead of dirTree in
        --overwrite <mode>  :  if fileExists defines how to overwrite => cmd:{'unzip'}
            <mode>='f':force    : dont care about src or obj - extract all
            <mode>='n':never    : dont care about src or obj - extract never
            <mode>='a':add      : extract only, when target not exists
            <mode>='u':update   : noAdd, extract only if zipSrc NEWER fileObj
            <mode>='r':restore  : noAdd, extract only if zipSrc OLDER fileObj

    <cmd>:={'parse'}
    <cmd>:={'build'} --ext <FEL>

>>> usage:end
myUsage

$sUsage_short = <<myUsageShort
<<< usage:begin
    $>ruby <script.rb> { <request> || <command> }
    $>ruby <script.rb> --usage        * longer help text
>>> usage:end
myUsageShort

#   <<< ************************************************************************

def F_usage(p_bLong=false)
    if (p_bLong)
        puts $sUsage
    else
        puts $sUsage_short
    end
end

#   ***************************************************************************
#   !MOD:   !CLS.CFile
#   ***************************************************************************

class CFile

    C_SEP_DIR_UNIX          =   '/'
    C_SEP_DIR_WINDOWS       =   '\\'
    C_SEP_DRIVE_WINDOWS     =   ':'

    C_DIRTREE_CMD_REMOVE    =   'DT.cmdRmv'
    C_DIRTREE_CMD_SAVE      =   'DT.cmdSav'

    #   File Extensopn
    C_FILE_EXTENSION__ID     =   '.'     # file extension

    #   DateTime Strings
    C_DT_NOW_STR            =   '%y%m%d%H%M'        # for fileTimes
    C_DT_STD_STR            =   '%y%m%d%H%M%S'      # test usage

    #   CLS: class methods with syntax2

    class << self

        def f__sUnixPath(p_sFilePath)
            s = p_sFilePath.gsub(C_SEP_DIR_WINDOWS,C_SEP_DIR_UNIX)
            return s
        end # f~sUnixPath

        def f__bFileExist(p_sFilePath)
            if (!File.exists?(p_sFilePath))
                return false
            end
            if (Dir.exists?(p_sFilePath))
                return false
            end
            return true
        end # f~sFileNotDir_exist

        def f__cp(p_sSrc,p_sObj)
            #   REM:   * copy sSrc-FilePath to sObj-FilePath
            begin
                FileUtils.cp(p_sSrc,p_sObj)
            rescue StandardError => tEc
                $m.f_exc("EXC:<#{p_sSrc}>=><#{p_sObj}>","#{tEc}",__LINE__)
                raise if C_VERBOSE
                return false
            end
            return true
        end # f~copyFile

        def f__mv(p_sSrc,p_sObj)
            #   REM:   * move sSrc-FilePath to sObj-FilePath
            begin
                FileUtils.mv(p_sSrc,p_sObj)
            rescue StandardError => tEc
                $m.f_exc("EXC:<#{p_sSrc}>=><#{p_sObj}>","#{tEc}",__LINE__)
                raise if C_VERBOSE
                return false
            end
            return true
        end # f~moveFile

        def f__rm(p_sFile)
            #   REM:   * copy sSrc-FilePath to sObj-FilePath
            #   https://ruby-doc.org/core-3.0.0/doc/syntax/exceptions_rdoc.html
            begin
                $m.f_trc(nil,__LINE__,__method__,"try fRm:<#{p_sFile}>") if C_VERBOSE
                if (!File.exists?(p_sFile))  # !CRQ-210208:checkExisting
                    s = "?rm with not existing file:'#{p_sFile}'"
                    $m.f_error(s,__FILE__,__LINE__,__method__) if C_DEBUG
                    $m.f_warning(s,__FILE__,__LINE__,__method__) # !CRQ-210221:warningOnly
                    return true
                    # return f-alse # noError
                end
                FileUtils.rm(p_sFile)
            rescue StandardError => tEc
                $m.f_warning(s,__FILE__,__LINE__,__method__) # !CRQ-210302:warningOnly
                raise if C_DEBUG
                return false
            end
            return true
        end # f~removeFile

        def f__isWindowsDrive?(p_sFilePath)
            # INP:  {'c:','c:\','c:\tmp'}
            # RET:  true,'c:'
            if ( not $m.f_isAlpha(p_sFilePath[0]) )
                return false
            end
            if ( not (p_sFilePath[1] == C_SEP_DRIVE_WINDOWS) )
                return false
            end
            return true,p_sFilePath[0..1]
        end

        def f__dateTime_t2s(p_tDt,p_sFmt=C_DT_STD_STR)
            #   INp:    dateTime-obj
            #   RET:    dateTime-str
            sDT =  p_tDt.strftime(C_DT_STD_STR)
            return sDT
        end # self.f~dateTime_t2s

        def f__dateTime_s2t(p_sDt,p_sFmt=C_DT_STD_STR)
            #   INp:    dateTime-str
            #   RET:    dateTime-obj
            tDT =  DateTime.strptime(p_sDt,p_sFmt)
            return tDT
        end # self.f~dateTime_s2t

    end # self classes

    #   CLS:instance methods

    def initialize
        @s__Now = $m.f_sNow(C_DT_NOW_STR)
        @x__Id  = __LINE__
    end

    # read+write = getter(),setter()
    attr_accessor   :s__Now,:x__Id

    private

        def f__sFilePath(p_sDir,p_sFile=nil)
            #   INp:  dirName='D:\My\Cmd\tools', fileName:'peter.txt'
            #   RET:  UNIX-filePath:'D:/My/Cmd/tools/peter.txt'
            sDir = CFile.f__sUnixPath(p_sDir)
            if (p_sFile==nil)
                s = sDir
            else
                sFile   = File.basename(p_sFile)
                s = sDir
                if (sDir[-1] != C_SEP_DIR_UNIX)
                    s << C_SEP_DIR_UNIX
                end
                s << sFile
            end
            return s
        end # self.sFilePath


    public

    def f_sClassName()
        return self.class.name   # show my class name
    end # f~sClassName

    def f_sFilePath(p_sDir,p_sFile=nil)
        return f__sFilePath(p_sDir,p_sFile)
    end # f~sFilePath

    def f_sDirName(p_sDirPath)
        if (p_sDirPath == nil)
            return nil      # !CRQ-190804:check empty
        end
        s=CFile.f__sUnixPath(p_sDirPath)
        sDir = File.dirname(s)  # returns eventually '.'
        if (sDir == C_DIR_THIS)
            return nil
        end
        return sDir
    end # f~sDirName

    def f_sFileName(p_sFilePath)
        s=CFile.f__sUnixPath(p_sFilePath)
        return File.basename(s)
    end # f~sFileName

    def f_bFileMove(p_sSrcDir,p_sObjDir,p_sFile)
        #   move a file from srcDir to objDir
        sSrc=f__sFilePath(p_sSrcDir,p_sFile)
        sObj=f__sFilePath(p_sObjDir,p_sFile)
        #   puts sObj
        bRc = CFile.f__mv(sSrc,sObj)
        return bRc
    end # f~bFileMove

    def f_bFileCopy(p_sFilePathSrc,p_sFilePathObj) # obj:Dir or FilePath
        #   REM:  * Copy a File(Path) to another File(Path) or Directory
        #   INp:    p_sFilePathSrc   : a file(Path)
        #   INp:    p_sFilePathObj   : a dir or file(Path)
        #   RET:  : false || true,ObjUnixFileName
        if (p_sFilePathSrc == p_sFilePathObj)
            return false
        end
        if (!File.exists?(p_sFilePathSrc))
            return false
        end
        $m.f_trc(nil,__LINE__,__method__,"src:<#{p_sFilePathSrc}>")
        $m.f_trc(nil,__LINE__,__method__,"obj:<#{p_sFilePathObj}>")
        #   make UnixFilePathes
        sSrc    = CFile.f__sUnixPath(p_sFilePathSrc)
        sObj    = CFile.f__sUnixPath(p_sFilePathObj)
        #   check unixfilepathes again
        if (sSrc == sObj)
            return false
        end
        #   extract dirname only if really a dir
        if (!Dir.exists?(sObj) &&
            !Dir.exists?(File.dirname(sObj)))
            $m.f_trc(nil,__LINE__,__method__,"?NoDirAt:<#{sObj}>")
            return false
        end
        #   build objPath
        sDir    = File.dirname(sObj)
        sFile   = File.basename(sSrc)
        sObj    = f_sFilePath(sDir,sFile)
        s = "#{__method__}:: src:<#{sSrc}> => obj:<#{sObj}>"
        # now check again
        $m.f_inf "#{s}",C_COLOR_RED
        #   copy real
        bRc = CFile.f__cp(sSrc,sObj)
        if (!bRc || !File.exists?(sObj))
            $m.f_trc(nil,__LINE__,__method__,"?copyFile fails")
            return false
        end
        return true,sObj
    end # self.bFileCopy

    def f_bsFilePath_maker(p_sDir,p_sFile=nil,p_iMode=nil)
        #   DES:    mounts a FilePath into a Dir
        #   INp:    dirName, IN:fileName or filePath;
        #   OUT:    UNIX-filePath
        #   case
=begin
        #   +   mode:=0
        1)  IN:pDir:'c',pFile:'' => return: "c:\"
        2)  IN:pDir:'c',pFile:'e:\tmp\peter.z,  => return 'c:\peter.z'
        3)  IN:pDir:'c:',pFile:'e:\tmp\peter.z' => return 'c:\peter.z'
        4)  IN:pDir:'c:\',pFile:'e:\tmp\peter.z'=> return 'c:\peter.z'
        5)  IN:pDir:'c:\pub',pFile:'e:\tmp\peter.z' => return 'c:\pub\peter.z'
        #   +   mode:=1
        6)  IN:pDir:'c:\pub',pFile:'e:\tmp\peter.z', => return 'e:\tmp\peter.z'
        #   +   mode:=2
        7)  IN:pDir:'c:\pub',pFile:'e:\tmp\peter.z', => return 'c:\peter.z'
=end
        #   +   check input parameter
        if ( not $m.f_isAlpha(p_sDir[0]) )
            $m.f_error("?!=Dir[0]!=Alpha",__FILE__,__LINE__,__method__)
            return false
        end
        #   +   handle Dir
        sDir    = CFile.f__sUnixPath(p_sDir)
        if (sDir[1] != C_SEP_DRIVE_WINDOWS)
            sDir[1] = C_SEP_DRIVE_WINDOWS
        end
        if (sDir[-1] != C_SEP_DIR_UNIX)
            sDir << C_SEP_DIR_UNIX
        end
        if ( not CFile.f__isWindowsDrive?(sDir) )
            $m.f_error("?sDir:<#{sDir}>!=Drive",__FILE__,__LINE__,__method__)
            return false
        end
        #   +   handle File
        if (p_sFile==nil || p_sFile.empty?)
            #   $m.f_trc(nil,__LINE__,__method__,"file==nil")
            return true,sDir
        else
            sFile = CFile.f__sUnixPath(p_sFile)
            if (not CFile.f__isWindowsDrive?(p_sFile))      # IN: 'c:/' 'peter.txt'
                if (sFile[0]==C_SEP_DIR_UNIX)
                    if (sFile.length<=1)
                        $m.f_error("?FnmPth.length<=1",__FILE__,__LINE__,__method__)
                        return false
                    end
                    sFile = sFile[1..-1]
                end
                sRc = sDir + sFile
                $m.f_trc(nil,__LINE__,__method__,"only:<#{sDir}>+<#{sFile}>")
                return true, sDir + sFile # concat directly
            end
            sFph = CFile.f__sUnixPath(p_sFile)
            if (not (sFph[2] == C_SEP_DIR_UNIX ) )  # "c:'/'svn/peter.txt"
                $m.f_error("?sFpt:<#{p_sFile}>!=WinFilePath",__FILE__,__LINE__,__method__)
                return false
            end
        end
        #   +   use iMode
        if (p_iMode==nil || p_iMode==0)
            #   flat copy
            sRc = sDir + File.basename(sFile)  # cuts the dir of pFile
        elsif (p_iMode==1)
            #   use complete dirPath including drive
            #   copy subTree of the srcFilePath - subtract drive
            #   IN: dir='e:/tmp',fPt='c:/svn/peter' => 'e:/tmp/svn/peter'
            sFph    = sFile[3..-1]     #   use Path only
            sRc     = sDir + sFph
        elsif (p_iMode==2)
            #   cut DirDrive, cut BaseName
            sDir    = sDir[0..2]       #   use Drive only 'c:/'
            sFnm    = File.basename(sFile)
            sRc     = sDir + sFnm
        else
            $m.f_error("?<#{p_iMode}>!=0..2",__FILE__,__LINE__,__method__)
            return false
        end
        #   + return
        return true,sRc
    end # f~bsFilePath_maker

    def f_aFileExtensionList(p_sExt=nil)
        #   DES:    convert a FileExtensionList(sFEL)
        #               into a FileExtensionArray(aFEL)
        #           Check files with '.<ExtensionId>'
        #   PAR:    IN: ":zip:txt:rb"   or hOpts[mFEL]     # !CRQ-210206
        #           OUT: true, a["zip","txt"]
        #           USE: $hOpts[mFEL]

        #   +   which Extension List to use?
        $m.f_inf "#{__method__}::p_sExt_default:<#{p_sExt}>"
        if (p_sExt==nil)
            sExt = C_FEL_ID__ANY
        else
            sExt = p_sExt
        end
        $m.f_inf "#{__method__}::FEL==<#{sExt}>"
        #   +   input check
        if ( (! sExt.is_a? String)  )
            $m.f_error("ext is not aString",__FILE__,__LINE__,__method__)
            return false
        end
        #   +   split?!
        if (sExt == C_FEL_ID__ANY)
            aFEL = []
            aFEL.push(C_FEL_ID__ANY)        # !CRQ-210206:use Symbol
            $m.f_inf "#{__method__}::use FEL==<ANY}>"
        else
            #   split by <C_FEL_ID~~SEP>
            aFEL = sExt.split(C_FEL_ID__SEP)        # FEL:={":txt:rb:py"}
            #   +   remove nil values
            aFEL.compact!
            if (aFEL.size==0)
                s = "?aFEL==0 of: <'#{sExt}'>"
                $m.f_error s,__FILE__,__LINE__,__method__
                exit
            end
            $m.f_inf "aExtTmp1:<#{aFEL}>" if C_VERBOSE
            #   +   remove empty string values inside the array
            aFEL = aFEL.reject { |x| x.empty? }
            $m.f_inf "aExtTmp2:<#{aFEL}>" if C_VERBOSE
        end
        #   +   ready
        $m.f_inf("#{__method__}:[#{__LINE__}]:<#{aFEL}>")
        return true,aFEL

    end # f~aFileExtension

    def f_dirTree_sorter(p_aFiles)
        $m.f_trc(nil,__LINE__,__method__,"dirTreeSorter")
        #   =1= save all dirs
        aSrc = p_aFiles.clone
        aDir = []
        aSrc.each_with_index { |xFile,iFile|
            sDir    = File.dirname(xFile)
            if (!(aDir.include? sDir))
               aDir.push(sDir)
            end
        }
        #   =2= sort dirs
        aDir.sort!
        #   =3= depending on dirs sort files
        aObj = []
        aDir.each_with_index { |xDir,iDir|
            $m.f_inf("dir[#{iDir}]::<#{xDir}>") if C_VERBOSE
            aSrc.each_with_index { |xFile,iFile|
                sDir  = File.dirname(xFile)
                if (sDir != xDir)
                    next
                end
                aObj.push(xFile)
                $m.f_inf("file[#{iFile+1}]::<#{xFile}>") if $bVerbose
            }
        }
        return true,aObj
    end # f~dirTree_sorter

    def f_dirTree_manager(p_sDir,p_aFEL,p_sCmd)

        #   REM:  * operate in a dirTree and execute 1 command for each file
        #   INp:    p_sDir   - directory to parse
        #   INp:    p_aFEL   - touch with this fileExt only ["rb","txt"]..
        #   INp:    p_sCmd == {'rmv','sav'}
        #   RET:  * false || true,aFilesBeTouched

        $m.f_trc(nil,__LINE__,__method__,"treeDir:<#{p_sDir}>")
        $m.f_inf("logFile:<#{$sLogFile}>") if C_VERBOSE

        #   check mandatory parameter
        #   *   String
        if ((not p_sDir.is_a? String) ||
            p_sDir==nil || p_sDir.empty? || (not Dir.exists?(p_sDir)) )
            $m.f_exit("Dir==0",__FILE__,__LINE__,__method__)
            return false
        end
        #   *   Array
        if ((not p_aFEL.is_a? Array) ||
            p_aFEL==nil || p_aFEL.length==0)
            $m.f_exit("aFileExt==0",__FILE__,__LINE__,__method__)
            return false
        end

        #   * check special FEL
        bFEL_all=false
        if (p_aFEL[0]==C_FEL_ID__ANY)
            bFEL_all=true
        end
        #  sDir,aFExt
        $m.f_trc(nil,__LINE__,__method__,"show:Dir+Ext")
        $m.f_inf("DIRTREE:<#{p_sDir}>",C_COLOR_CYAN)
        $m.f_inf("aFExt:<#{p_aFEL}>",C_COLOR_CYAN)
        $m.f_inf("bFEL_ALL:<#{bFEL_all}>",C_COLOR_CYAN)

        #  goto objDir, save old
        sPwd=Dir.pwd
        Dir.chdir(p_sDir)

        #   fetch only files in FileId array
        #   search extension '.EXT' is mandatory
        aRc = Array.new

        iFile = 0
        iDone = 0

        Find.find('./') { |xEntry|

            $m.f_trc(nil,__LINE__,__method__,"xEntry:=<#{xEntry}>") if C_VERBOSE
            iFile += 1
            sInfo = "entry[#{iFile}]:<#{xEntry}>"
            $m.f_inf("#{sInfo}",C_COLOR_CYAN,false) if C_VERBOSE

            #   remove a complete Dir?
            if ( (!File.file? xEntry) &&
                 ( File.directory?( xEntry) ) )
                n = File.size(xEntry)
                if (n==0)
                    $m.f_inf "?isDir.empty='<#{xEntry}>':<#{n}>" if C_VERBOSE
                    if (p_sCmd == CFile::C_DIRTREE_CMD_REMOVE)
                        $m.f_inf "rmvDir[#{iFile}]:#{xEntry}" if C_VERBOSE
                        sFile = File.expand_path(xEntry) # absolute filePath
                        $m.f_inf "?xEntry='<#{xEntry}>'" if C_VERBOSE
                        $m.f_inf "?sFile='<#{sFile}>'" if C_VERBOSE
                        if (xEntry.length>2) # './'
                            CFile.f__rm(sFile)
                        end
                    end
                end
                $m.f_inf(":next") if C_VERBOSE
                next  # remove dir OK
            end

            $m.f_inf(":OK") if C_VERBOSE

            sExt = File.extname(xEntry)
            $m.f_inf(":wanted:FileExtension:=<#{sExt}>") if C_VERBOSE

            #   traverse all subdirs
            #   search for extensions and save these
            #   [".txt",".rb",...]
            p_aFEL.each_with_index { |xExt,iExt|

                if (!bFEL_all)
                    lExt =  xExt.length # length of extension
                    if ( xEntry.length <= lExt )    # with '.'
                        next
                    end

                    if (xExt[0] != C_FILE_EXTENSION__ID)
                        next
                    end

                    #   calculate manually FileExtension
                    sExt = xExt
                    $m.f_inf(":#{sExt}==:#{xExt}?") if C_VERBOSE
                    if (sExt != xExt)
                        next
                    end
                end

                #   Exand to absolute for better logging
                sFile = File.expand_path(xEntry) # absolute filePath

                #   File with correct extension found
                #   operate 'command' now - save the filePath

                bCmd  = false
                if (p_sCmd == C_DIRTREE_CMD_REMOVE)
                    if (sFile == $sLogFile)
                        $m.f_inf("untouch current LogFile:<#{$sLogFile}>")
                    else
                        bCmd = CFile.f__rm(xEntry)
                    end
                elsif (p_sCmd == C_DIRTREE_CMD_SAVE)
                    bCmd = true
                end

                if (bCmd)
                    iDone +=1
                    sInfo = p_sCmd +'::'+ sInfo+' => :done('+iDone.to_s+ ')'
                    aRc.push(sFile) # save complete filePath    # save::
                    $m.f_inf("#{sInfo}",C_COLOR_CYAN)
                end

                #   puts "sExt:<#{sExt}>"
            } # p~aFileExtensions.each_with_index

        } # Find.find('./')

        #   goto HOME
        Dir.chdir(sPwd)

        #   return if nothing found
        nFiles = aRc.size
        if (nFiles == 0)
            $m.f_inf "#{__method__}::?NoFiles found at '#{p_sDir}' to handle"
            return false
        end

        #   show results
        $m.f_inf "#{__method__}::aFiles=<#{aRc}>" if C_VERBOSE
        $m.f_inf "#{__method__}::nFiles=<#{aRc.size}>" if C_VERBOSE

        return true,aRc

    end # f~dirTree_manager

end # C~File

#   ***************************************************************************
#   !MOD:   !CLS.CUEDIT
#   ***************************************************************************

class CUedit < CFile

    #   UEdit common
    C_UED_PROJECT_FILE_DEFAULT      =   'TUT_tmp.prj'
    C_UED_PROJECT_FILE_INIT         =   '?UnknownUedPrjFile'
    C_UED_INI_FILE_EXT              =  'txt'    # ==ueZipTxtFile
    C_UED_INI_COMMENT_ID            =   '#'
    C_UED_GROUP_EXTENSION_ID        =   'GRP:'
    C_UED_EXTENSION_ID              =   '!'

    #   file path minsize
    C_TAG_MINSIZE                   = 3

    #   pure UTF
    C_UTF__BEGIN  = uON             =   '+'     #   begin char
    C_UTF__END    = uOFF            =   '-'     #   ending char
    C_UTF__MARK                     =   'U'     #   marks Tags
    C_TAG_UTF_ID_DIR                =   'AFw'       #   "+AFw-"
    C_TAG_UTF_ID_UNDERSCORE         =   'AF8'       #   "+AF8-"
    C_TAG_UTF_ID_2UNDERSCORE        =   'AF8AXw'    #   "+AF8AXw-"
    C_TAG_UTF_ID_2UNDERSCORE_W      =   'AFwAXwBf'  #   "__" : ue27
    C_TAG_UTF_ID_ASTERIX            =   'ACo'       #   '*'
    C_TAG_UTF_ID_DOLLAR             =   'AFwAJABc'  #   '/$'

    #   pure WORD W16
    C_WRD__MARK                     =   'W'     #   marks Tags

    #   ue-txt-zip
    C_UET_TOP_GROUP                 =   '<*topGroup*>'

    #   UEdit UTF-conventions
    C_TAG_UTF_DIRSEP        =  uON + C_TAG_UTF_ID_DIR           + uOFF
    C_TAG_UTF_UNDERSCORE    =  uON + C_TAG_UTF_ID_UNDERSCORE    + uOFF
    C_TAG_UTF_2UNDERSCORE   =  uON + C_TAG_UTF_ID_2UNDERSCORE   + uOFF
    C_TAG_UTF_2UNDERSCORE_W =  uON + C_TAG_UTF_ID_2UNDERSCORE_W + uOFF
    C_TAG_UTF_ASTERIX       =  uON + C_TAG_UTF_ID_ASTERIX       + uOFF      # '*'
    C_TAG_UTF_DOLLAR        =  uON + C_TAG_UTF_ID_DOLLAR        + uOFF      # '$' # !CRQ-210606

    #   extra 2022 CRQ-220108
    C_TAG_UTF_DIRSEP_UNDERSCORE  =  uON + 'AFwAXw'  + uOFF      # \_ "
    C_TAG_UTF_DIRSEP_2UNDERSCORE =  C_TAG_UTF_2UNDERSCORE_W     # \__"

    #   Tags of a ultraEdit projectFile
    C_TAG_ID_ON     =  tON          = '['
    C_TAG_ID_OFF    =  tOFF         = ']'

    #   tag:[Project ID]
    C_UED_ID__PRJ_ID                =   'Project ID'
    C_UED_TAG_PROJECT_ID            =   tON  + C_UED_ID__PRJ_ID + tOFF

    #   [Project Information]
    C_UED_ID__PRJ_INFO              =   'Project Information'
    C_UED_TAG_PROJECT_INFORMATION   =   tON + C_UED_ID__PRJ_INFO + tOFF

    #   Project DirectoryU=D:+AFw-MY+AFw-cmd+AFw-rb
    C_UED_ID__PRJ_DIR               =   'Project Directory'
    C_UED_KEY_PROJECT_DIRECTORY__U  =   C_UED_ID__PRJ_DIR + 'U'
    C_UED_KEY_PROJECT_DIRECTORY__W  =   C_UED_ID__PRJ_DIR + 'W'

    #   "[FilesU - src" not complete tags...
    C_UED_ID__FILES                 =   'Files'
    C_UED_TAG_ID__FILES             =   tON + C_UED_ID__FILES
    C_UED_TAG_ID__FILES_U_ID        =   C_UED_TAG_ID__FILES + 'U'
    C_UED_TAG_ID__FILES_W_ID        =   C_UED_TAG_ID__FILES + 'W'

    #   [GroupU]
    C_UED_ID__GROUP                 =   'Group'
    C_UED_TAG_GROUP                 =   tON + C_UED_ID__GROUP + tOFF
    C_UED_TAG_GROUP_U               =   tON + C_UED_ID__GROUP + 'U' + tOFF
    C_UED_TAG_GROUP_W               =   tON + C_UED_ID__GROUP + 'W' + tOFF
    C_TAG_GRP_SEP                   =   '-'

    #   extra tags
    C_TAG_FILEPATH_SEPARATOR        =   '='       # "0=File1"
    C_TAG_FILEPATH_RELATIVE         =   '..'        # "0=.."

    def initialize(p_sFile=C_UED_PROJECT_FILE_DEFAULT)
        @sUeditProjectFile=C_UED_PROJECT_FILE_INIT
        s=f_sFilePath(p_sFile)
        if (File.exists?(s))
            @sUeditProjectFile=s
        end
    end

    private

    def f__isTagFiles(p_sTag)
        aTagFiles = [
            C_UED_TAG_ID__FILES,            #   "[Files"
            C_UED_TAG_ID__FILES_U_ID,       #   "[FilesU"
            C_UED_TAG_ID__FILES_W_ID        #   "[FilesW"
        ]
        if (aTagFiles.include? p_sTag)
            return true
        else
            return false
        end
    end # f~~isTagFiles

    def f__s_encode_iso2utf(p_sString,p_bIso2Utf=true)  # !CRQ-210213:iso2utf
        sRc = p_sString
        if (p_bIso2Utf)
            #   IN:     d:/KNT/prj/uez
            #   OUT:    D:+AFw-KNT+AFw-prj+AFw-UEZ
            sRc.gsub!('_',  C_TAG_UTF_UNDERSCORE)
            sRc.gsub!('__', C_TAG_UTF_2UNDERSCORE)
            sRc.gsub!('*',  C_TAG_UTF_ASTERIX)
            sRc.gsub!('/$/', C_TAG_UTF_DOLLAR)      # !CRQ-210606
            sRc.gsub!(C_SEP_DIR_UNIX,C_TAG_UTF_DIRSEP)
            sRc.gsub!('/_', C_TAG_UTF_DIRSEP_UNDERSCORE,)
            sRc.gsub!('/__',C_TAG_UTF_DIRSEP_2UNDERSCORE,)
        else
            #   IN  : "dir 2+AF8-D-Z+AFw-Salat+AFw-Kopf-Salat.txt>" # UTF
            #   OUT : "dir 2/D-Z/Salat/Kopf-Salat.txt"              # ISO
            sRc.gsub!(C_TAG_UTF_UNDERSCORE,     '_')
            sRc.gsub!(C_TAG_UTF_2UNDERSCORE,    '__')
            sRc.gsub!(C_TAG_UTF_ASTERIX,'*')                # only allowed for groups
            sRc.gsub!(C_TAG_UTF_DOLLAR,'/$/')               # !CRQ-210606
            sRc.gsub!(C_TAG_UTF_DIRSEP,C_SEP_DIR_UNIX)
            sRc.gsub!(C_TAG_UTF_DIRSEP_UNDERSCORE,'/_')     # !CRQ-220108:dir1
#           sRc.gsub!(C_TAG_UTF_2UNDERSCORE_W,  '__')       # !CRQ-210127 : double meaning
            sRc.gsub!(C_TAG_UTF_DIRSEP_2UNDERSCORE,'/__')   # !CRQ-220108:dir2
        end
        return sRc
    end

    def f__pth_iso2utf(p_sFilePath)
        return f__s_encode_iso2utf(p_sFilePath,true)
    end # f~~iso2utf

    def f__pth_utf2iso(p_sFilePath)
        return f__s_encode_iso2utf(p_sFilePath,false)
    end # f~~utf2iso

    def f__tag_groupedFiles_content(p_sTag)
        #   REM:    Files, which are packed into a Group
        #   *       not parsing TAG:'Group'...
        #   INp:    sTag={"[FilesU]","[FilesU - subDir1 - subDir2]"..}
        #   INp:    "[FilesU - grp+AF8-Essen - Gemuese]"
        #   OUT:    [ "/","subDir1","subDir2"]
        #   RET:    true,Filesfound
        if ((p_sTag==nil)  ||                   # !CRQ-190801:3
            (p_sTag.length< C_TAG_MINSIZE))
            return false
        end
        sTag = f__pth_utf2iso(p_sTag) # "[FilesU - grp_Essen - Gemuese]"
        sTag =  sTag[1..-2]  # "[text]" => "text"
        aTags   = sTag.split(' - ') #  :   "FilesU","grp_Essen","Gemuese"
        aFiles  = []
        aTags.each { |x|
            if (!(f__isTagFiles(x)))
                aFiles.push x       # don't use : {'Files','FilesU'}
            end
        }
        if (aFiles.size==0)
            sGrp = C_UET_TOP_GROUP
        else
            sGrp = aFiles.join('.')
        end
        return true,sTag,sGrp


    end # f~~tag_files_Content

    public

#   ===========================================================================
#   !STP:   ultra edit project file handling
#   ===========================================================================


    def f__bsValidFileExtension(p_aFEL,p_sFilePath)
        sFExt = C_FEL_ID__ANY
        if ( (p_aFEL == nil)    ||
             ( (p_aFEL.length == 1)  &&
            ( (p_aFEL[0] == C_FEL_ID__ANY) || (p_aFEL[0] == C_FEL_ID__SEP) ) ) )
             return true,sFExt
        end
        sFExt = File.extname(p_sFilePath)
        sFExt.downcase!
        sFExt = sFExt[1..-1]  # ".ext" => "ext"
        bRc = false
        p_aFEL.each_with_index do |sExt,iExt|
            if ( sExt == sFExt )
                bRc = true
                break
            end
        end
        return bRc,sFExt
    end

    def f__sFileEntry_kit(p_sHomeDir,p_sFilePath)
        #   IN:       p_sUepFilePath
        #   OUT:      sPosFilePath
        #   $m.f_trc(nil,__LINE__,__method__,"Home:<#{p_sHomeDir}>")
        sTmp    = p_sFilePath.slice(0..1);   # 2 chars left
        sPwd    = Dir.pwd() # save my running dirPath
        if ( sTmp == C_TAG_FILEPATH_RELATIVE )
            Dir.chdir(p_sHomeDir)   # change
            sFile   = File.expand_path(p_sFilePath)
            Dir.chdir(sPwd)
        else
            #   2 Möglichkeiten
            #   a) kompletter Dateipfadname oder
            #   b) nur Dateiname ohne Pfad - also der Basename
            sBase   =   File.basename(p_sFilePath)
            bDir    =   false
            sDir    =   File.dirname(p_sFilePath)
            if (sDir[1] == C_SEP_DRIVE_WINDOWS)
                bDir = true     # !CRQ-210305:checkDirectory
            end
            if ((sBase == sFile) || (!bDir) )
                sFile = p_sHomeDir + C_SEP_DIR_UNIX + p_sFilePath # !CRQ-210302:BaseName||Fullname
            else
                sFile = p_sFilePath # !CRQ-210305:useDirectly
            end
            sFile = sFile.squeeze('/')      # !CRQ-220108.a:substitute all '//' by '/'
        end
        puts "str2win:IN:#{p_sFilePath};OUT:#{sFile};PWD:=#{sPwd}" if C_DEBUG
        return sFile
    end  # f~~sFileEntry_kit


    def f__tagParser(p_aUepLine)

=begin
    +   INp: all UEP-fileLines
    +   OUT: aUepTags, found prjDir
        +   parse uep file lines and fetch only relevant lines
        +   strip chomp lines
        +   save relevant tags and entries
=end
        n = p_aUepLine.length
        $m.f_trc(nil,__LINE__,__method__,"parseUepLines:<#{n}>")

        sUepProjectDirectory   =  nil
        aUepTag         =   Array.new()
        aUepGroup       =   Array.new()
        aUepFile        =   Array.new()

        #   seek tags
        bTag = bTagFiles        = bTagProjectInformation = false

        p_aUepLine.each_with_index do |sLine,iLine|

            #   clean line
            sLine.chomp!        # no NL
            sLine.strip!        # no spaces
            if (sLine.length == 0)
                next
            end

            #   use line if comment
            if  (sLine[0]==C_UED_INI_COMMENT_ID)
                next    # noSave of commented lines
            end

            #   helper index
            i = iLineIdx = iLine + 1

            #   =*= : parse tag

            $m.f_trc(nil,__LINE__,__method__,"'#{sLine}':[#{i}]") if C_DEBUG

            if (sLine[0]==C_TAG_ID_ON)

                bTag    = bTagFiles = bTagProjectInformation = false
                if   (sLine==C_UED_TAG_PROJECT_ID)

                        #   ::tag:[Project ID]
                        $m.f_inf("foundTAG[#{i}]:*HDR*") if C_VERBOSE
                        aUepTag.push({:m_sIdf=>"HDR",:m_sStr=>sLine,:m_iLoc=>i})
                        bTag = true

                elsif (sLine==C_UED_TAG_PROJECT_INFORMATION)

                        #   ::tag:[Project Information]
                        $m.f_inf("foundTAG[#{i}]:*INF*")
                        aUepTag.push({:m_sIdn=>"INF",:m_sStr=>sLine,:m_iLoc=>i})
                        bTag = bTagProjectInformation = true

                elsif (sLine.include?(C_UED_ID__GROUP))

                        #   ::tag:[GroupU]
                        $m.f_inf("foundTAG[#{i}]:*GRP*") if C_VERBOSE
                        aUepTag.push({:m_sIdn=>"GRP",:m_sStr=>sLine,:m_iLoc=>i})
                        bTag = true

                elsif (sLine.include?(C_UED_ID__FILES))

                        #   ::tag:[FilesU - src]
                        $m.f_inf("foundTAG[#{i}]:*FIL*") if C_VERBOSE
                        sTmp    = sLine[1...-1]
                        sTmp.gsub!(/\s+/,"")        # remove all spaces
                        aTag  = sTmp.split('-')     # "FilesU,src"
                        aUepTag.push({:m_sIdn=>"FIL",
                                :m_sStr=>sLine,     # complete content
                                :m_sTag=>aTag[1],
                                :m_iLoc=>iLineIdx})
                        bTag = bTagFiles = true
                        #   this is a group
                        aUepGroup.push(sLine)

                else
                        #   ::tag:[tools]...etc
                        $m.f_inf("foundTAG[#{i}]:*UNK*") if C_VERBOSE
                        aUepTag.push({:m_sIdn=>"UNK",:m_sStr=>sLine,:m_iLoc=>i})
                end

            else

                #   file or project entry

                sLine = f__pth_utf2iso(sLine)  # convert generally
                aHsh = sLine.split('=')    # 2 array
                sKey = aHsh[0]; sVal=aHsh[1]

                if (bTagProjectInformation)

                    #   >>> using sKey, sVal
                    if (sLine.include?(C_UED_ID__PRJ_DIR))
                        sVal = f__s_encode_iso2utf(sVal,false) # !CRQ-210606
                        $m.f_inf("foundTAG[#{i}]:*DIR*:") if C_VERBOSE
                        sUepProjectDirectory = sVal
                        aUepTag.push({:m_sIdn=>"DIR",:m_sStr=>sVal, :m_iLoc=>i})
                    end

                elsif (bTagFiles)
                    sFilePath = sVal    # adjust later
                    aUepFile.push(sFilePath)
                    cCol = C_COLOR_CYAN
                    $m.f_inf("pushFile[#{i}]:#{sFilePath}",cCol) if C_VERBOSE
                    aUepTag.push({:m_sIdn=>"FID",:m_sStr=>sFilePath, :m_iLoc=>i})
                end

            end # if Line

        end  # for

        return aUepTag,aUepGroup,aUepFile,sUepProjectDirectory  # !CRQ-210214

    end   # f~~tagParser


    def f_uep_parse()

        #   INp:    @sUeditProjectFile)
        #   OUT:    true,sPrjDir,aPrjLines,aPrjFiles,aPrjGroups

        #   =*= : check ueProjectFile
        $m.f_trc(nil,__LINE__,__method__,"check file:<#{@sUeditProjectFile}>")
        if (!File.exists?(@sUeditProjectFile))
            raise "?File:<#{@sUeditProjectFile}>"
            return false
        end

        #   =*= : read uedit file lines
        $m.f_trc(nil,__LINE__,__method__,"File.read:<#{@sUeditProjectFile}>")
        aFileLines = File.readlines(@sUeditProjectFile) # read complete file
        aUepTag,aUepGroup,aUepFile,sUepHomeDir = f__tagParser(aFileLines)

        #   =*= : uep-projectDirectory
        $m.f_trc(nil,__LINE__,__method__,"out0:uepProjDir")
        if (sUepHomeDir == nil)
            sDir = Dir.pwd()
            $m.f_inf("=01: PwdDir:'#{sDir}'")
            bRc,sDir = $m.f_sDir( @sUeditProjectFile )
            if (!bRc)
                $m.f_error("?prjDirUnknow",nil,__LINE__,__method__)
                return false
            end
            $m.f_inf("=02: UedDir:'#{sDir}'")
            sUepHomeDir = sDir
        end
        $m.f_inf("=*= UepHomeDir:'#{sUepHomeDir}'")

        #   =*= : fetch FileExtensionList FEL
        bRc,aFEL = $pF.f_aFileExtensionList($hOpts[:mFEL])
        if (!bRc)
            # this means, all entry inside of the UEP should be used
            $m.f_inf("#{__method__}::FEL:=0 => take all UEP entries")
            aFEL=[]
        end
        $m.f_inf("#{__method__}:<#{aFEL}>") # !CRQ-210214:show me

        #   =*= : parse my tags
        $m.f_trc(nil,__LINE__,__method__,"parse:uepTag")
        aLine   =   Array.new()     # all valid lines
        aFile   =   Array.new()     # all files inside an uep
        aUepTag.each_with_index do |hTag,iTag|
            $m.f_inf("*** hTag[#{iTag}]:'#{hTag}'") if C_VERBOSE
            bTag = true
            case (hTag[:m_sIdn])
                when "DIR"
                    if (hTag[:m_sStr] == nil)
                        hTag[:m_sStr] = sUepHomeDir     # adjust
                    end
                    s =  "#{C_UED_INI_COMMENT_ID} #{C_UED_EXTENSION_ID}"
                    s << "PRJ := #{hTag[:m_sStr]}"
                    aLine.push(s)
                when "FIL"
                    s =  "#{C_UED_INI_COMMENT_ID} #{C_UED_EXTENSION_ID}"
                    s << "GRP := #{hTag[:m_sStr]}"
                    aLine.push(s)
                when "FID"
                    sFile       =   "#{hTag[:m_sStr]}"     # FilePath or File?
                    $m.f_trc(nil,__LINE__,__method__,"aUepTag.FID:<#{sFile}>)") if C_VERBOSE
                    s = sFilePath   = f__sFileEntry_kit(sUepHomeDir,sFile) #!CRQ-210302:kit
                    bFExt,sFExt     = f__bsValidFileExtension(aFEL,sFilePath)
                    if (bFExt)
                        aFile.push(s)
                        aLine.push(s)
                    else
                        s = "?F:FExt:<#{s}><#{sFExt}>"
                        $m.f_trc(nil,__LINE__,__method__,s) if C_VERBOSE
                    end
                else
                    bTag = false
            end # case hTag
        end # aUepTag.each_with_index..

        #   =*= : store lines
        $m.f_trc(nil,__LINE__,__method__,"store parsing tag results")
        aRcLine = aLine

        #   =*= : 01: file-entry = all files found in an UEP
        aFileEntry = aFile
        $m.f_inf("aFileEntry := < #{aFileEntry.length} >")

        #   =*= : 02: fetch different files = remove doubles and sort
        aFileFound = aFileEntry
        aFileFound.uniq!      # no doubles
        aFileFound.sort!      # sort
        $m.f_inf("aFileFound := < #{aFileFound.length} >")

        #   =*= : 03: only existing files
        aFileExist = []
        aFileFound.each_with_index do |sFile,iFile|
            if (File.exists?(sFile))
                aFileExist.push(sFile) # !CRQ-210219:onlyFilesExisting
            else
                $m.f_trc(nil,__LINE__,__method__,"???:fileExist[#{iFile}]:'#{sFile}'") if C_DEBUG
            end
        end # foreach
        $m.f_inf("aFileExist := < #{aFileExist.length} >")

        #   =*= : show line,group,files
        if (C_VERBOSE)
            $m.f_trc(nil,__LINE__,__method__,"out:objLine")
            aRcLine.each_with_index do |sLine,iLine|
                $m.f_inf("=*= Lne[#{iLine}]:'#{sLine}'")
            end # foreach
            $m.f_trc(nil,__LINE__,__method__,"out1:uepGroup(FIL)")
            aUepGroup.each_with_index do |sGrp,iGrp|
                $m.f_inf("=*= Grp[#{iGrp}]:'#{sGrp}'")
            end # foreach
            $m.f_trc(nil,__LINE__,__method__,"out2:uepFileId")
            aFileFound.each_with_index do |sFid,iFid|
                $m.f_inf("=*= Fle[#{iFid}]:'#{sFid}'")
            end # foreach
            aFileExist.each_with_index do |sFid,iFid|
                $m.f_inf("=*= Fid[#{iFid}]:'#{sFid}'")
            end # foreach
        end

        #   =*= : return
        $m.f_trc(nil,__LINE__,__method__,"ready!:1")
        return true,sUepHomeDir,aRcLine,aFileExist,aUepGroup  # !CRQ-210216

    end # f~uep_parse


    def f_uep_build(p_aFiles,p_sUepFile)

        #   REM:    building a ultra-edit-project file (uepFile)
        #   INp:    p_aFiles    - how many files to put intu uep
        #           p_sUepFile  - name of UEP
        #   RET:    false||true,iStoredDirs,iStoredFiles

        s = "build:<#{p_sUepFile}>;Typ:=<#{$hOpts[:mUepType]}>"
        $m.f_trc(nil,__LINE__,__method__,s)

        #   build-dependent hash
        hTag = Hash.new
        hTag['Files']               =   C_TAG_FILES
        hTag['Group']               =   C_TAG_GROUP
        hTag['ProjectDirectory']    =   'Project Directory'
        hTag['Tagfile']             =   'Project Tagfile'
        hTag['Wordfile']            =   'Project Wordfile'
        hTag['TpFile']              =   'Project TpFile'
        hTag['Filter']              =   'Filter'

        #   UTF|WRD|ISO=default
        bUtf = false
        if ($hOpts[:mUepType])
            hTmp = hTag.clone
            hTag.each_key do |x|
                case $hOpts[:mUepType]
                when C_OPT_UEPTYPE_UTF
                    bUtf    = true
                    hTmp[x] += C_UTF__MARK
                when C_OPT_UEPTYPE_WRD
                    hTmp[x] += C_WRD__MARK
                else
                    # nothing
                end
            end
            hTag = hTmp
        end
        $m.f_inf("#{__method__}::hTags:=<#{hTag}>")

        #    inputOk?
        if (p_aFiles.size == 0)
            $m.f_trc(nil,__LINE__,__method__,"?aFiles==0")
            return false
        end

        #   projectDir, projectFiles
        sPrjDir = CFile.f__sUnixPath($hOpts[:mDir])
        $m.f_inf("#{__method__}::DIR:<#{sPrjDir}>")
        $m.f_inf("#{__method__}::aFiles:<#{p_aFiles}>") if C_VERBOSE
        fp = File.new(p_sUepFile,"w+")

        #   get Dirs, handle Files
        $m.f_trc(nil,__LINE__,__method__,"handle aFiles")
        aDir = []
        aSrc = []
        aTop = []
        iFileFound=0
        iFileExist=0
        p_aFiles.each_with_index { |xFile,iFile|
            if (xFile[0] == C_UED_INI_COMMENT_ID)  # not possible
                next
            end
            iFileFound += 1
            if (!File.exists?(xFile))
                next
            end
            sDir = File.dirname(xFile)
            if (!(aDir.include? sDir))
               aDir.push(sDir)
            end
            iFileExist += 1
            if (xFile.include? sPrjDir)     # select file name only
                n       = sDir.length       # komplette dir
                sFile   = xFile[n+1..-1]
                if (sDir == sPrjDir)
                    aTop.push(xFile)    # save into top
                else
                    aSrc.push(xFile)    # save into stdArray
                end
            end
            sInfo = sprintf("%2.2d=%s",iFile+1,sFile)  # => UEZ~NUMERATOR?
            $m.f_inf("#{__method__}::get:<#{sInfo}>")
        } # each aFiles

        #   check
        if (iFileExist == 0)
            $m.f_error("?found no existing Files",__FILE__,__LINE__,__method__)
            return false
        end

        #   only info as TESTING -- headerline
        $m.f_trc(nil,__LINE__,__method__,"building:header")
        if (C_UEZ_TAGS)
            s = "#{__FILE__};#{__method__};#{__LINE__};at:#{$sNow}"
            s = "# --- created automatically by::<#{s}>"
            fp.puts s
        end

        #
        #   =01:   build the header projectID
        #
        fp.puts "[#{C_TAG_PRJ_ID}]"
        fp.puts "Signature=UE Proj: v.1"
        fp.puts "Unicode=2"

        #
        #   =02:    build project Information
        #
        fp.puts "[#{C_TAG_PRJ_INFO}]"
        fp.puts "Use Relative Directory=1"
        fp.puts "Relative to Project File=1"
        if (bUtf)
            sDir = f__pth_iso2utf(sPrjDir)
        else
            sDir = sPrjDir
        end
        fp.puts "#{hTag['ProjectDirectory']}=#{sPrjDir}"

        #
        #   =02b:   build sub Dir infos
        #
        fp.puts "Include Sub Directories=1"
        fp.puts "#{hTag['Tagfile']}"
        fp.puts "#{hTag['Wordfile']}"
        fp.puts "#{hTag['TpFile']}"
        fp.puts "#{hTag['Filter']}"
        fp.puts "Create Tagfile=0"

        #
        #   =03:    <top> files (not in any groups)
        #
        $m.f_trc(nil,__LINE__,__method__,"write top files")
        fp.puts "[#{hTag['Files']}]"
        iTopFiles   = 0
        iTopGroups  = 0
        aTop.each_with_index { |xFile,iFile|
            sFile   = File.basename(xFile)
            sEntry  = sprintf("%2.2d=%s",iFile,sFile)
            $m.f_inf("#{__method__}::addTop:<#{sEntry}>")
            fp.puts sEntry
            iTopFiles += 1
        }
        if (iTopFiles > 0)
            iTopGroups = 1
        end

        #
        #   =04:    <grp> writing and save    : [GroupU]
        #
        $m.f_trc(nil,__LINE__,__method__,"write groups")

        fp.puts "[#{hTag['Group']}]"

        hGrp = Hash.new  # create a group hash
        aDir.each_with_index { |xDir,iDir|
            if (xDir == sPrjDir)
                next
            end
            n       =   sPrjDir.length
            sGrp    =   xDir[n+1..-1]           # relative path
            sGrp.gsub!(' ','')                  #   remove blanks
            sGrp.gsub!(C_TAG_GRP_SEP,'_')       #   avoid 'uep-grp-Separator'
            if (bUtf)
                sGrp.gsub!('_',C_TAG_UTF_UNDERSCORE)
            end
            sGrp.gsub!(C_SEP_DIR_UNIX,C_TAG_GRP_SEP)    # Dir builds Grp
            hGrp[xDir]  = sGrp
            sEntry = sprintf("%2.2d=%s",iDir,sGrp)
            $m.f_inf("#{__method__}::addGrp:<#{sEntry}>")
            fp.puts sEntry
        } # each aDir

        #
        #   =05:    writing the <sub> body
        #               *   [FilesU - <Grp1>] <FilesOfGrp1>
        #               *   [FilesU - <Grp2>] <FilesOfGrp2>...
        #
        $m.f_trc(nil,__LINE__,__method__,"write files")
        sDirOld = nil
        iIdx = 0
        iSubFiles    = 0
        iSubGroups   = 0
        aFile = Array.new()
        aSrc.each_with_index { |xFile,iFile|
            sFile   = File.basename(xFile)
            sDir    = File.dirname(xFile)
            n       = sPrjDir.length        # for relative naming
            if (sDir != sDirOld)
                sDirOld = sDir
                sGrp =  hGrp[sDir]
                sEntry = sprintf("[%s - %s]",hTag['Files'],sGrp)
                fp.puts sEntry
                iSubGroups += 1
                iIdx = 0        # number inside a group, starting with '0'
                #   $m.f_bug("DIR",__FILE__,__LINE__) # TEST
            end
            sFile = xFile[n+1..-1]
            if (bUtf)
                sFile.gsub!('_',C_TAG_UTF_UNDERSCORE)
                sFile.gsub!(C_SEP_DIR_UNIX,C_TAG_UTF_DIRSEP)
            end
            sEntry = sprintf("%s",sFile)
            if (C__USE_UEZ_NUMERATOR_GRP)        # numerator inside each groups
                sEntry = sprintf("%2.2d=%s",iIdx,sEntry)
            end
            iIdx += 1
            iSubFiles += 1
            sTxt = f__pth_utf2iso(sEntry)
            sInfo = sprintf("[%2.2d:%3.3d]:%s",iSubGroups,iSubFiles,sTxt)
            $m.f_inf("#{__method__}::addSub:<#{sInfo}>")
            fp.puts sEntry
            aFile.push sEntry
        } # each files

        #   finish build
        $m.f_trc(nil,__LINE__,__method__,"building:footer")
        if (C_UEZ_TAGS)
            s = "found:#{iFileFound}"
            aFile.uniq!; iFileUniq=aFile.length
            if (iFileUniq != iFileFound)
                s += "; uniq:#{iFileUniq}"
            end
            s = "# --- I found :: < #{s} >"
            fp.puts s
        end

        #   close UED project file
        fp.close

        $m.f_inf "WROTE ueOutputFile:'#{p_sUepFile}'"

        #   check file
        n = File.size(p_sUepFile)
        $m.f_inf :"+\tFileSize:<'#{n}'>"
        if (n == 0)
            $m.f_error("?FileSize==0",__FILE__,__LINE__,__method__)
            return false
        end

        #   results
        iStoredGroups   = iTopGroups + iSubGroups
        iStoredFiles    = iTopFiles  + iSubFiles
        $m.f_inf "+ \tGroups: top:'#{iTopGroups}' sub:'#{iSubGroups}"
        $m.f_inf "+ \tFILES:  top:'#{iTopFiles}' sub:'#{iSubFiles}'"

        return true,iStoredGroups,iStoredFiles

    end # f~uep_build

#   ===========================================================================
#   !STP:   ue-zip-helper text file handling
#   ===========================================================================

    def f_writeFile(p_aFileLines,p_sFileTxt)
        #   REM:    writes the zipTextFile, not the zipFile itself !
        #           The FileLines have comment lines and seperated groups.
        #   INp:    p_aFileLines, OUT:p_sFileTxt
        #   RET:    false||true,iFileFound,iFileExist
        $m.f_trc(nil,__LINE__,__method__,"try write to:<#{p_sFileTxt}>")
        #    inputOk?
        if (p_aFileLines.size == 0)
            $m.f_trc(nil,__LINE__,__method__,"?aFiles==0")
            return false
        end
        $m.f_inf("aFileLines:<#{p_aFileLines}>") if C_VERBOSE
        fp = File.new(p_sFileTxt,"w+")
        s = "#{__FILE__};#{__method__};#{__LINE__};at:#{$sNow}"
        s = "# --- created automatically by::[#{s}]"
        fp.puts s
        iFileEntry = 0
        aFileFound = Array.new()
        aFileExist = Array.new()
        p_aFileLines.each_with_index { |xFile,iFile|
            sEntry = sprintf("%s",xFile)
            if (C__USE_UEZ_NUMERATOR_TXT)
                sEntry = sprintf("%2.2d=%s",iFile,sEntry)
            end
            fp.puts sEntry
            if (xFile[0] == C_UED_INI_COMMENT_ID)
                next    # this was only a comment-line
            end
            iFileEntry += 1
            aFileFound.push xFile
            if (File.exists?(xFile))
                aFileExist.push xFile
            end
        } # each files
        #   strip now
        aFileFound.uniq!; iFileFound=aFileFound.length
        aFileExist.uniq!; iFileExist=aFileExist.length
        s = "#{iFileEntry}"
        if ((iFileFound>0) &&(iFileFound != iFileEntry))
            s += ";found=#{iFileFound}"
        end
        if ((iFileExist!=0) && (iFileExist != iFileFound))
            s += ";found=#{iFileExist}"
        end
        fp.puts "# --- I found ::[ #{s} ] files;"
        fp.close
        $m.f_inf "WROTE ueOutputFile:'#{p_sFileTxt}'" if C_VERBOSE
        if (iFileFound == 0)
            $m.f_trc(nil,__LINE__,__method__,"?iFile==0")
            return false
        end

        return true,iFileFound,iFileExist

    end # f~writeFile

    def f_readFile(p_sFileTxt)
        #   DES:
        #           Parses the ZipTextFile - ignore '#' lines
        #           Each line 1 file, saves them into array aFound
        #           Check if file exists, saves them into aExist
        #   INp:    p_sFileTxt
        #   RET:    false||true,p_aFilesFound,p_aFilesExist
        if (File.exists?(p_sFileTxt) == false)
            $m.f_exit("?argError:<#{p_sFileTxt}>",__FILE__,__LINE__,__method__)
            return false
        end
        $m.f_trc(nil,__LINE__,__method__,"read from:<#{p_sFileTxt}>")
        aFileLines = File.readlines(p_sFileTxt) # read complete file
        puts "aFileLines <#{aFileLines}>" if C_DEBUG

        #   parse zipTxt file
        aFileFound = Array.new
        aFileLines.each_with_index { |sLine,iLine|
            sLine.lstrip!
            sLine.chomp!
            if (sLine[0]==C_UED_INI_COMMENT_ID)
                next
            end
#           $m.f_trc(nil,__LINE__,__method__,"try:<#{sLine}>[#{iLine}]")
            if (C__USE_UEZ_NUMERATOR)
                #   we have added a file lines like "FileA" => "01=FileA"
                #   no we have to remove this string "01=" for a file existing check
                r = /\d*=/
                x = sLine.match(r)      # is no string
                x = x.to_s              # convert RegEx => string
                l = x.length
                if (l > 0)
                    $m.f_inf("cutNumerator:'#{sLine}':'#{x}':#{l}")  if C_VERBOSE
                    sLine = sLine[l..-1]
                end
            end
            sFile = sLine       # now without: '01=' numeration
            aFileFound.push sFile
            $m.f_trc(nil,__LINE__,nil,"File.found:<#{sFile}> at:<#{iLine}>") if C_DEBUG
        } # each with Index

        #   remove doubles and sort
        aFileFound.uniq!
        aFileFound.sort!

        #   prepare exsting files
        aFileExist = Array.new
        aFileFound.each_with_index { |sFid,iFid|
            if (File.exists?(sFid))
                $m.f_trc(nil,__LINE__,nil,"?F:<#{sFid}>:[#{iFid}]")  if C_DEBUG
                aFileExist.push sFid
            end
        }

        # results
        n = aFileFound.size
        m = aFileExist.size
        if (n==0 || m==0)
            $m.f_trc(nil,__LINE__,__method__,"?iFile==0")
            return false
        end

        $m.f_inf "READ ueInputFiles:'#{n}'/'#{m}'"
        return true, aFileFound, aFileExist

    end # f~readFile

end # class CUe~

#   ***************************************************************************
#   !MOD:   !CLS.ZIP
#   ***************************************************************************

class CZip < CFile

    C_FILE_ZIP_EXT  = 'zip'

    private

    def f__getZip_filePath(p_sFilePath)

        #   INp: p_sFilePath
        #   USE: hOpts[:Flat], hOpts[:Obj]
        #   RET: zipFilePath using INp and hOpts[:Obj]

        $m.f_trc(nil,__LINE__,__method__,"fPth:<#{p_sFilePath}",C_VERBOSE)
        $m.f_inf("hOpt1.flat  = #{$hOpts[:mFlat]}")
        $m.f_inf("hOpt2.obj   = #{$hOpts[:mObj]}")

        #   ?objDir == FALSE => mount where saved before
        if ($hOpts[:mObj] == nil)
            return p_sFilePath      # standard tree mounting
        end

        #   use objDir - flat or tree mounted ?
        if ($hOpts[:mFlat]!=nil && $hOpts[:mFlat]==true)
            #   mount at objDir without pathes in input filePath
            $m.f_inf("mount.flat",C_COLOR_CYAN,true,C_VERBOSE)
           bRc, sRc = $pF.f_bsFilePath_maker($hOpts[:mObj],p_sFilePath)
        else
            # mount at objDir drive - use last part of input filePath
            $m.f_inf("mount.objTree",C_COLOR_CYAN,true,C_VERBOSE)
            bRc, sRc = $pF.f_bsFilePath_maker($hOpts[:mObj],p_sFilePath,1)
        end

        if (bRc == false)
            $m.f_exit("?cant make",__FILE__,__LINE__,__method__)
            return false
        end

        return sRc

    end # f~getZip_filePath

    public

    def f_addByFile(p_aSrcZipTextFiles,p_sObjZipFilePath)
        #   REM:    use files of input zipTxtFile and create an objZipFile
        #           INp: SrcZipTextFiles, ueZipFilePath
        #           OUT: uePrj.zip
        #           RET: true,iZippedFiles
        #   add a file(pattern) into zip archive, with is saved at obj
        if (p_aSrcZipTextFiles.size == 0)
            raise $m.f_sprint("?Array:<#{p_aSrcZipTextFiles}>",C_COLOR_RED)
            return false
        end
        $m.f_trc(nil,__LINE__,__method__,"src:<#{p_aSrcZipTextFiles}>") if C_VERBOSE
        $m.f_trc(nil,__LINE__,__method__,"obj:<#{p_sObjZipFilePath}>")  if C_VERBOSE
        sObjDir=f_sDirName(p_sObjZipFilePath)
        if (sObjDir == nil)
            $m.f_error("?add emptyObjDir",__FILE__,__LINE__,__method__)
            return false
        end
        sObjZip=f_sFileName(p_sObjZipFilePath)
        $m.f_trc(nil,__LINE__,__method__,"*A*::objDir1:<#{sObjDir}>") if C_VERBOSE
        $m.f_trc(nil,__LINE__,__method__,"*B*::objZip2:<#{sObjZip}>")

        #  get filePathes for src+obj, delete before usage
#       s=f_sFilePath(sSrcDir,sObjZip); CFile.f__rm(s)
        s=f_sFilePath(sObjDir,sObjZip); CFile.f__rm(s)

#       Dir.chdir(sSrcDir)

        # parse file - push only valid files
        $m.f_trc(nil,__LINE__,__method__,"parseFileAndPush:start")

        iRc=0
        aAdd = []   # avoid xZip~add dblEnty error - save added files
        p_aSrcZipTextFiles.each_with_index { |xFile,iFile|
            Dir.chdir(sObjDir)  # important!
            $m.f_trc(nil,__LINE__,__method__,"zip...OPEN") if C_VERBOSE
            Zip::File.open(sObjZip, Zip::File::CREATE) { |xZip|
                sFile = f_sFilePath(xFile)
                $m.f_inf "try add[#{iFile+1}]:'#{sFile}'...",C_COLOR_CYAN,false
                if (aAdd.include?(sFile))
                    $m.f_inf ":?DOUBLE",C_COLOR_RED     #!CRQ-190805:avoid doubles
                elsif (File.exists?(sFile))
                    xZip.add(sFile,sFile)       # add(logName,phyName)
                    $m.f_inf ":added;"
                    aAdd += [sFile]             # save in add array
                    iRc+=1
                else
                    $m.f_inf ":?"
                end
            } # Zip.open

        } # aSrcZipText

        $m.f_trc(nil,__LINE__,__method__,"parseFileAndPush:ready")
        if (iRc<=0)
            return false
        end
        return true,iRc

    end # f~addByFile

    def f_isZipFileName?(p_sFileName)
        # returns true if "*.zip"
        if (p_sFileName == nil)
            return false
        end
        sExt = File.extname(p_sFileName)
        sExt.downcase!
        sExt = sExt[1..-1]  # ".ext" => "ext"
        $m.f_trc(nil,__LINE__,__method__,"sExt:=<#{sExt}>")
        if (sExt == C_FILE_ZIP_EXT)
            return true
        end
        return false
    end # f~isZipFileName

    def f_mkZipFileName(p_sFileName)
        return p_sFileName + '.' + C_FILE_ZIP_EXT
    end # f~mkZipFileName

    def f_find(p_sZipFileId)
        #   REM: find a similiar file to fileId
        #   IN:     "x:/uez.zip"
        #   RET:    true,sFilePath
        $m.f_thm("CZip.find",true,__LINE__)
        $m.f_trc(nil,__LINE__,__method__,"sFid:<#{p_sZipFileId}>")
        sDir    =   File.dirname(p_sZipFileId)
        if (not(Dir.exists?(sDir)))
            $m.f_trc(nil,__LINE__,__method__,"?DirNotExist<#{sDir}>")
            return false
        end
        #   goto sample file dir
        sPwd = Dir.pwd    # save source path
        Dir.chdir(sDir)
        #   calc FileId for glob
        sFileBase = File.basename(p_sZipFileId,".*") # without extension
        sFileId =   sFileBase.to_s + '-*'   # add '-*' search pattern
        sFileId =   f_mkZipFileName(sFileId)
        $m.f_inf("glob.sFidId:<#{sFileId}>") # "UEZ-*.zip"
        aDir = Dir.glob(sFileId)
        #   extract Date:
        #       xFile="UEZ-1805261701.zip"
        #       iDate=1805261701
        iLen = sFileBase.length # len=3
        iDateMax=-1; iDateIdx=0; sFile='?'
        $m.f_trc(nil,__LINE__,__method__,"...extract Files:")
        $m.f_inf("aDir:<#{aDir}>")
        aDir.each_with_index { |xFile,i|
            iDate = xFile[iLen+1..-5].to_i # 1805261701
            $m.f_inf("try #{xFile} [#{i}] ?",C_COLOR_CYAN,true)
            if ((i==0)||(iDateMax<iDate))
                iDateMax=iDate
                iDateIdx=i
                sFile=xFile
            end
        }
        if (not(File.exists?(sFile)))
            $m.f_trc(nil,__LINE__,__method__,"?FileNotExists<#{sFile}>")
            return false
        end
        $m.f_inf "FOUND Date:#{iDateMax}[#{iDateIdx}]:FILE:<#{sFile}>"
        #   get a file of a zip content
        #   goto dir BACK
        Dir.chdir(sPwd)
        #   get File Path and return
        $m.f_trc(nil,__LINE__,__method__,"sDir:<#{sDir}>")
        $m.f_trc(nil,__LINE__,__method__,"sFile:<#{sFile}>")
        sFilePath = f_sFilePath(sDir,sFile)
        $m.f_trc(nil,__LINE__,__method__,"sFilePath:<#{sFilePath}>")
        return true,sFilePath
    end # f~find

    def f_parseZip(p_sZipFile,p_bProductive=false,p_bOverwrite=false)

        #   INp:    p_sZipFile "x:/uez-YYMMDDHHMMS.zip"
        #   INp:    p_bProductive=false => parse only
        #   INp:    p_bOverwrite=true => overwrite files
        #   USE:    hOpts:[mOverwrite],hOpts[mFExtLst]
        #   RET:
        #       function-status true|false
        #       aZipFile    :   found files in the Zip stored in an array
        #       aNowFile    :   found files in Zip, which already exist
        #       iExtracted  :   extracted files

        $m.f_thm("parseZip",true,__LINE__)
        if (!File.exists?(p_sZipFile))
            raise $m.f_sprint("?File/DIR:<#{p_sZipFile}>",C_COLOR_RED)
            return false
        end

        $m.f_trc(nil,__LINE__,__method__,"prd:<#{p_bProductive}>|ovw:<#{p_bOverwrite}>")

        aZipFile=Array.new()
        aNowFile=Array.new()    # how many files already in dirTree
        iExtracted  = 0

        #   ExtList usage?
        #    use FileExtensionList
        aFEL = Array.new
        bRc,aFEL = $pF.f_aFileExtensionList($hOpts[:mFEL])
        if (!bRc)
            # this means, all entry inside of the UEP should be used
            $m.f_inf("#{__method__}::FEL:=0 => take all ZIP entries")
        end

        #   Parameter
        $m.f_inf "hOpts.obj:<#{$hOpts[:mObj]}>"
        $m.f_inf "hOpts.flt:<#{$hOpts[:mFlat]}>"
        $m.f_inf "hOpts.fel:<#{aFEL}>"

        $m.f_trc(nil,__LINE__,__method__,"openZipFile:<#{p_sZipFile}>")
        Zip::File.open(p_sZipFile) { |xZip|

            #   xZip:="X:/TEMP/UEZ-1805230930.zip"
            $m.f_trc(nil,__LINE__,__method__,"xZip:<#{xZip}>")

            xZip.each_with_index { |xFile,iFile|

                i = iFile +1

                sFilePath   = xFile.name
                $m.f_trc(nil,__LINE__,__method__,"sFPth[#{i}]='#{sFilePath}'")

                #   don't handle empty FEL - CRQ-220808
                sExt = File.extname(sFilePath)
                if (sExt.length == 0)
                    $m.f_puts "Ext<#{sFilePath}>.len == 0" if $bVerbose
                    next
                end

                #   check FEL with FEL.len!=0
                sExt = sExt[1..-1] # !CRQ-220808 FEXT is notEmpty
                if (!($hOpts[:mFEL].include? sExt))
                    $m.f_puts ":?Ext=<#{sExt}> not in FEL" if $bVerbose
                    next
                end
                $m.f_inf("ok:EXT:='#{sExt}'",C_COLOR_CYAN)

                #   Time of Zip is
                tTime_zip   = xFile.time
                if (iFile==0)
                    $m.f_inf("timeOfZipFile:<#{tTime_zip}>",C_COLOR_CYAN)
                end

                #   get FileName dependent onOptions
                $m.f_trc(nil,__LINE__,__method__,"getZipPth")
                sFilePath   = f__getZip_filePath(sFilePath)

                #   Parameter
                bExtract = false

                #   save file
                $m.f_trc(nil,__LINE__,__method__,"save.sFPth2:='#{sFilePath}'")
                aZipFile.push sFilePath
                bFileExists = CFile.f__bFileExist(sFilePath)
                if (bFileExists)
                    aNowFile.push sFilePath #   save existing files
                    $m.f_inf("fileExist:'#{sFilePath}'",C_COLOR_CYAN)
                end

                #   check overwrite => no

                if (p_bProductive)

                    #  =*= 01: makeDir
                    sDir = File.dirname(sFilePath)
                    if (!Dir.exists?(sDir))
                        $m.f_trc(nil,__LINE__,__method__,"mkDir:<#{sDir}>")
                        FileUtils.mkdir_p(sDir)
                    end

                    $m.f_trc(nil,__LINE__,__method__,
                        "sFile:=<#{sFilePath}>::[#{i}]",C_VERBOSE)

                    #  =*= 02: handle overwrite
                    if ($hOpts[:mOverwrite] == C_OPT_OVERWRITE_FORCE)
                        bExtract = true
                        $m.f_puts ":YES.frc" if $bVerbose

                    elsif (!bFileExists)

                        bExtract = true
                        $m.f_puts ":YES.add" if $bVerbose

                    elsif ( p_bOverwrite &&
                            !($hOpts[:mOverwrite] == C_OPT_OVERWRITE_ADD))

                        tTime_src   = File.mtime(sFilePath)  # modified time
                        print "? <#{tTime_zip}> <=> <#{tTime_src}> " if $bVerbose

                        if (tTime_zip < tTime_src)
                            print "=:older'<':?restore" if $bVerbose
                            if ($hOpts[:mOverwrite] == C_OPT_OVERWRITE_RESTORE)
                                bExtract=true
                                puts ":YES" if $bVerbose
                            else
                                puts ":NO" if $bVerbose
                            end
                        elsif (tTime_zip > tTime_src)
                            print "=:newer'>':?update" if $bVerbose # update
                            if ($hOpts[:mOverwrite] == C_OPT_OVERWRITE_UPDATE)
                                bExtract=true
                                puts ":YES" if $bVerbose
                            else
                                puts ":NO" if $bVerbose
                            end
                        else
                            puts "\n" if $bVerbose
                        end

                    end # if bFileExists && overwrite

                end # if p~bProductive)

                if (bExtract)
                    # 1) remove source before   => but then we create a file
                    if (bFileExists)
                        CFile.f__rm(sFilePath)  # needed by extract
                    end
                    #   split it --- TEST
                    if (C__USE_TESTMODE && (iExtracted==0))
                        bRc,sDir,sNam,sExt = $m.f_bsFilePath_split(sFilePath)
                        sFilePathTmp   = $sDirTmp.to_s + '/' + sNam.to_s + sExt.to_s
                        $m.f_trc(nil,__LINE__,__method__,"pth:<#{sFilePathTmp}>")
                    end
                    # 2) extract now
                    xZip.extract(xFile, sFilePath)  # new timestamp now
                    iExtracted += 1
                    $m.f_inf("extracted File[#{iFile+1}] : <#{sFilePath}>") if C_VERBOSE
                end

            } # xZip~each_with_index

        } # Zip::File.open(p_sZipFile)

        $m.f_inf "parseZip::unzipped: <#{iExtracted}> files"

        if (aZipFile.size<=0)
            return false
        end

        return true,aZipFile,aNowFile,iExtracted

    end # f~parseZip

end # class CZip

#   ***************************************************************************
#   !MOD:  cmd:=uedParse or zip
#   ***************************************************************************

def F_uedParse(p_sUeFilePrj_src,p_sFileListOut_obj)
    #   REM :   parse UEP-file
    #   IN  :   p_sUeFilePrj_src : uedit projectFile
    #   IN  :   verbose=>copy prj file to TMP
    #   OUT :   p_sFileListOut_obj : zipTxtFile
    $m.f_thm("ueParse:hdr",true,__LINE__)
    $m.f_puts("\t\t input \t := <#{p_sUeFilePrj_src}>")
    $m.f_puts("\t\t output \t := <#{p_sFileListOut_obj}>") if C_VERBOSE
    $m.f_trc(nil,__LINE__,__method__,"arg1:<#{p_sUeFilePrj_src}>")
    $m.f_trc(nil,__LINE__,__method__,"arg2:<#{p_sFileListOut_obj}>")

    #   copy to tmpDir
    if (C__USE_DUPLICATE)
        #   copy 'uePrjFile.prj' to "ENV[TMP]/uePrjFile.txt"
        sFile = File.basename(p_sUeFilePrj_src)
        sFile << CFile::C_FILE_EXTENSION__ID
        sFile << CUedit::C_UED_INI_FILE_EXT
        sObj = $sDirTmp + CFile::C_SEP_DIR_UNIX + "#{sFile}"
        sObj = CFile.f__sUnixPath(sObj)
        $pF.f_bFileCopy(p_sUeFilePrj_src,sObj) # in srcFilePath,objFilePath
        #   $m.f_puts "UEP-File copied to:<#{sObj}>"
    end

    #   parse UEP-file
    $m.f_trc(nil,__LINE__,__method__,"parse UEP file")
    p = CUedit.new(p_sUeFilePrj_src)
    bRc,sPrjDir,aPrjLines,aPrjFiles,aPrjGroups=p.f_uep_parse()
    if (!bRc)
        $m.f_error("?parsing UEP fails",__FILE__,__LINE__,__method__)
        return false
    end

    #   trace
    $m.f_trc(nil,__LINE__,__method__,"DIR:<#{sPrjDir}>")
    $m.f_inf("#{__method__}::UEP-Files:<#{aPrjFiles}")      if C_VERBOSE
    $m.f_inf("#{__method__}::UEP-Groups:<#{aPrjGroups}")    if C_VERBOSE

    #   shall we use tags or files only?
    aUepZipTextEntry = []
    if ($hOpts[:mTag])   # !CRQ-210219: uepTxt => Lines|Files
        $m.f_trc(nil,__LINE__,__method__,"uepFile=>Tags")
        aUepZipTextEntry= aPrjLines
    else
        $m.f_trc(nil,__LINE__,__method__,"uepFile=>Files")
        aUepZipTextEntry = aPrjFiles
    end

    #   write finally the ZipTxtFile to the outputDir
    $m.f_thm("#{__method__}::writeFile",true,__LINE__)
    sFileOut=p.f_sFilePath(p_sFileListOut_obj)          # get name
    bRc,iRc,iRc2=p.f_writeFile(aUepZipTextEntry,sFileOut)   # create zipTxt file
    if (!bRc)
        return false
    end
    $m.f_inf("#{__method__}::writtenFile:<#{sFileOut}")

    #   show results
    $m.f_thm("uedParse:show",true,__LINE__)
    $m.f_trc(nil,__LINE__,__method__,"iRc2:<#{iRc2}>")
    if (bRc)
        n = File.size(sFileOut)
        $m.f_puts("!!!:parsing result saved into:<#{sFileOut}>:size=#{n}") if C_VERBOSE
    end

    $m.f_trc(nil,__LINE__,__method__,"EOF.uedParse")
    return true
end # F~uedParse

#   ***************************************************************************
#   !MOD:  cmd:=zip
#   ***************************************************************************

def F_zipParse_txt(p_sZipTxtFile)
    #   REM:    parse zipTxtFile, not the zipFile itself
    #   INp:    sZipTxtFile : 'uez.zip.txt'
    #   RET:    false||true,aFoundFilesInInpuFile
    $m.f_trc(nil,__LINE__,__method__,"parse zipTxtFile:<#{p_sZipTxtFile}>")
    p = CUedit.new()
    bRc,aFound,aExist = p.f_readFile(p_sZipTxtFile)
    if (not bRc)
        return false
    end
    n = aFound.size; m = aExist.size
    $m.f_inf "RESULT:<#{bRc}>;FILES.found:<#{n}>;FILES.exist:<#{m}>"
    return bRc,aFound
end # F~zipParse_txt

def F_zipMake_txt2zip(p_sFileList_src,p_sZipFile_obj)
    #   IN:         zipFile.txt - info
    #   OUT:real    zipFile.zip - real
    #   RET:        false || true,iFiles,iSize
    $m.f_thm("zipMake_txt2zip",true,__LINE__)
    p = CZip.new
    #   parse zipTxtFile
    $m.f_trc(nil,__LINE__,__method__,"parse zipTxtFile")
    bRc,aRc = F_zipParse_txt(p_sFileList_src)
    if (!bRc)
        return false
    end
    sZipFile=p_sZipFile_obj
    $m.f_trc(nil,__LINE__,__method__,"toCreate:<#{sZipFile}>")
    $m.f_thm("zipAdd",true,__LINE__)
    bRc,iFiles=p.f_addByFile(aRc,sZipFile)
    $m.f_thm("zipRES",true,__LINE__)
    if (!bRc)
        $m.f_error("addByFile to:<#{sZipFile}>",__FILE__,__LINE__,__method__)
        return false
    end

    #   move txtFile to outputDir
    if (C__USE_MOVE_TXT_TMP2OBJ)
        $m.f_trc(nil,__LINE__,__method__,"move:<#{p_sFileList_src}>=>{sZipFile}")
        sObj = File.dirname(sZipFile)
        sSrc = File.dirname(p_sFileList_src)
        if (sSrc == sObj)
            $m.f_trc(nil,__LINE__,__method__,"noMove needed")
        else
            sFnm = File.basename(p_sFileList_src)
            bRc  = p.f_bFileMove(sSrc,sObj,sFnm)
            if (!bRc)
                $m.f_exit("Mov:'#{sFnm}'",__FILE__,__LINE__,__method__)
                return false
            end
            $m.f_trc(nil,__LINE__,__method__,"move OK")
        end
    end # if move zipTxtFile

    #   show results
    iSize = File.size(sZipFile)
    return true,iFiles,iSize
end # F~zipMake_txt2zip

#   ***************************************************************************
#   !MOD:  cmd:=unzip
#   ***************************************************************************

def F_zipMake_zip2txt(p_sZipFile,p_sTxtFile=nil)

    #   REM:    validate and create a zipTxtFile --- see above
    #   INp:    "x:\uez-<date>.zip"
    #   RET:    false || true, "x:\TEMP\uez-<date>.txt" - zipListFile

    # pointer to zipClass
    p = CZip.new

    #   define Zip-Text-File name
    $m.f_thm("zipMake_zip2txt",true,__LINE__)
    $m.f_trc(nil,__LINE__,__method__,"zip:<#{p_sZipFile}>,txt:<#{p_sTxtFile}>")
    if (p_sTxtFile == nil)
        sFileBase   = File.basename(p_sZipFile,".*") # without extension
        sFileName   = sFileBase.to_s +
                        CFile::C_FILE_EXTENSION__ID +
                        CUedit::C_UED_INI_FILE_EXT
        sTxtFile    = p.f_sFilePath($sDirTmp,sFileName)
        $m.f_trc(nil,__LINE__,__method__,"sTxtFile:=<#{sTxtFile}>")
    else
        sTxtFile = p_sTxtFile
    end


    $m.f_trc(nil,__LINE__,__method__,"...parseZip")
    bRc,aZip,aNow=p.f_parseZip(p_sZipFile)
    if (!bRc)
        $m.f_trc(nil,__LINE__,__method__,"?NOT parseZip:<#{p_sZipFile}>")
        return false
    end

    #   results
    nZip = aZip.size
    $m.f_trc(nil,__LINE__,__method__,"aZipFile.size:#{nZip}")
    $m.f_inf "aZip.n:=<#{aZip.size}>"
    $m.f_inf "aNow.n:=<#{aNow.size}>"

    #   create the textFile by using the txtFile name
    #   create a ZipText-File
    $m.f_trc(nil,__LINE__,__method__,"create txtFile:=<#{sTxtFile}>")
    p = CUedit.new()
    $m.f_inf "classname:<#{p.f_sClassName}>"
    $m.f_trc(nil,__LINE__,__method__,"write file")
    bRc,iRcFilesFound,iRcFilesExisting  = p.f_writeFile(aZip,sTxtFile)
    nSize = File.size(sTxtFile)
    if (!bRc || nSize<=0 ) # iRcFilesExisting==0 : noError
        $m.f_trc(nil,__LINE__,__method__,"?bRc:<#{bRc}>;?nSize:<#{nSize}>")
        return false
    end

    s = "!OK:wrote FILE:<#{sTxtFile}> with SIZE:<#{nSize}> and ENTRIES:<#{nZip}>"
    $m.f_puts s

    return true,sTxtFile

end # F~zipMake_zip2txt

def F_zipGet(p_sZipFileId,p_sZipDir)

    #   REM: find zipfile using fileId and dirname

    #   IN: p_sZipFileId(fid)
    #   IN: p_sZipDir - if needed
    #       in  fid="x:\UEZ-1805231708.zip" * exact
    #       or  fid="x:\UEZ.zip"
    #       or  fid="UEZ" dir="x:\
    #       or  fid="d:\KNT\UEZ.prj"  dir="x:\
    #   ROUT:    newest zipFile

    $m.f_trc(nil,__LINE__,__method__,"arg1:<#{p_sZipFileId}>")

    #   if Dir is input, it must be exist!
    if (p_sZipDir != nil && (!Dir.exists?(p_sZipDir)))
        raise $m.f_sprint("?DIR:<#{p_sZipDir}>",C_COLOR_RED)
        return false
    end

    p = CZip.new
    $m.f_inf "classname:<#{p.f_sClassName}>"

    bZipFileExt =   p.f_isZipFileName?(p_sZipFileId)
    bFileExists =   File.exists?(p_sZipFileId)
    bCmd = false

    #   a) valid filePath as input : "x:\UEZ-1805231708.zip"
    if (bZipFileExt && bFileExists)
        $m.f_trc(nil,__LINE__,__method__,"sFid.A:=file")
        return true,p_sZipFileId # zip file is zipFileId

    #   b) filePath as input but to search: : "x:\UEZ.zip"
    elsif (p_sZipDir == nil)
        bDir = false
        sDir = File.dirname(p_sZipFileId)
        $m.f_trc(nil,__LINE__,__method__,"dir:=<#{sDir}>")
        if (!Dir.exists?(sDir))
            raise $m.f_sprint("?DIR:<#{sDir}>",C_COLOR_RED)
            return false
        end
        bFile = false
        sFile = File.basename(p_sZipFileId,".*")
        if (sFile.length<=0)
            raise $m.f_sprint("?FileLength==0",C_COLOR_RED)
            return false
        end
        $m.f_trc(nil,__LINE__,__method__,"sDir:<#{sDir}>,sFile:<#{sFile}>")
        sFid = CFile.f_sFilePath(sDir,sFile)
        $m.f_trc(nil,__LINE__,__method__,"sFid.B:=<#{sFid}>")
        bCmd = true

    #   c) IN: fid="d:\KNT\UEZ.prj"
    #   d:\MY\cfg\IDM\ue\prj\%v_ID%.prj
    elsif (!bZipFileExt && bFileExists)
        sObj    = File.basename($hOpts[:mUepFile],".*")
        sObj    = p.f_mkZipFileName(sObj)
        sFid    = p.f_sFilePath(p_sZipDir,sObj)
        bCmd    = true
        $m.f_trc(nil,__LINE__,__method__,"sFid.C:=<#{sFid}>")

    #   d) IN: fid:"UEZ" dir:x:\
    else
        sFileName   = p.f_mkZipFileName(p_sZipFileId)
        sFid        = CFile.f_sFilePath(p_sZipDir,sFileName)
        bCmd        = true
        $m.f_trc(nil,__LINE__,__method__,"sFid.D:=<#{sFid}>")
    end

    #   cmd was ok ?
    if (!bCmd)
        $m.f_error("?NOT valid combinations",__FILE__,__LINE__,__method__)
        return false
    end

    #   find newest zip file with FileId
    bRc,sFilePath=p.f_find(sFid)
    if (!bRc)
        $m.f_puts "?zipGet:not found:<#{p_sZipFileId}>"
        return false
    end

    $m.f_trc(nil,__LINE__,__method__,"found:=<#{sFilePath}>")
    return true,sFilePath

end # F~zipGet

def F_zipExtract(p_sZipFile)
    #   DES:    extract files of a valid zipFile
    #   INp:    zipFile:{'d:/tmp/uez.zip'}
    #   RET:    false || true,iExtractedFiles
    p = CZip.new    # pointer to zipClass
    $m.f_trc(nil,__LINE__,__method__,"...extracting")
    bRc=false
    bOvw=false
    if ($hOpts[:mOverwrite] == nil)
        $m.f_puts "?missing option '--overwrite' combined with extraction"
    else
        bOvw=true
    end
    bRc,aZip,aNow,iGet=p.f_parseZip(p_sZipFile,true,bOvw) # prductve,overwrite
    if (!bRc)
        $m.f_trc(nil,__LINE__,__method__,"?NOT extracted:<#{p_sZipFile}>")
        return false
    end
    return true,iGet
end # F~zipExtract

#   ***************************************************************************
#   !MOD:  cmd:=build
#   ***************************************************************************

def F_build()
    #   DES: create an own uedit project file using a top dir

    $m.f_trc(nil,__LINE__,__method__,"begin")
    $m.f_inf "FEL:<#{$hOpts[:mFEL]}>"

    #   the tree dir must exist
    if (not Dir.exists? $hOpts[:mDir])
        $m.f_error("?DirExist:<#{$hOpts[:mDir]}>",__FILE__,__LINE__,__method__)
        exit(-__LINE__)
    end

    if (not $hOpts[:mFEL])
        $m.f_error("?ExtList missing",__FILE__,__LINE__,__method__)
        exit(-__LINE__)
    end

    bRc,aFEL = $pF.f_aFileExtensionList($hOpts[:mFEL])
    if (!bRc)
        $m.f_error("?I need fileExtensions",__FILE__,__LINE__,__method__)
        exit(-__LINE__)
    end
    $m.f_trc(nil,__LINE__,__method__,"aFEL:<#{aFEL}")

    #   save all files at topDir
    bRc,aRc = $pF.f_dirTree_manager($hOpts[:mDir],aFEL,CFile::C_DIRTREE_CMD_SAVE)
    if (!bRc)
        $m.f_error("?fails",__FILE__,__LINE__,__method__)
        exit(-__LINE__)
    end

    #   dirTree sorter
    $m.f_trc(nil,__LINE__,__method__,"sort dirTreeFiles")
    bRc,aRc = $pF.f_dirTree_sorter(aRc)

    $m.f_inf "aRc:<#{aRc}>" if C_VERBOSE
    $m.f_inf "dirTreeManagerFiles found := <#{aRc.size}>"

    #   show all files
    aRc.each_with_index { |xFile,iFile|
       $m.f_inf "File[#{iFile}]:'#{xFile}'" if C_VERBOSE
    }

    #
    #   *** make output file
    #

    #   01: define uep file name
    $m.f_trc(nil,__LINE__,__method__,"make outputFile")
    sFile   = File.basename($hOpts[:mUepFile],".*")
    if (C__USE_UEP_DT_NAME)
        sFile   = sFile.to_s + '-' + $sNow.to_s
    end
    sFile   = sFile.to_s + C_FILE_EXTENSION_UEP
    $m.f_inf "uepFile := '#{sFile}'"

    #   02: set output dir
=begin
    if ($hOpts[:mObj] != nil)
        sDirObj = $hOpts[:mObj]
    else
        sDirObj = $pF.f_sDirName($hOpts[:mUepFile])
        if ((sDirObj != nil) && (Dir.exists? sDirObj))
            $m.f_inf "uepDir by uepDir"
        else
            sDirObj = $sDirTmp
            $m.f_inf "uepDir by tmpDir"
        end
    end
    if (!(Dir.exists? sDirObj))
        $m.f_error("?outputDir of build",__FILE__,__LINE__,__method__)
        exit(-__LINE__)
    end
=end
    if ($hOpts[:mObj] == nil)
        $m.f_inf "opt=mObj == nil ?noOutput Dir used - take Default" if C_VERBOSE
    end

    #   03: doIt
    sFile   = $pF.f_sFilePath(sDirObj,sFile)
    puts "uepFile calculated := '#{sFile}'"

    #   get pointer
    p = CUedit.new()

    #   *** write this file to objDir
    bRc,iGroups,iFiles = p.f_uep_build(aRc,sFile)
    if (!bRc)
        $m.f_error("?writeFiles",__FILE__,__LINE__,__method__)
        exit(-__LINE__)
    end

    #   ready
    $m.f_puts "!OK:written uep-FILE:<#{sFile}> "\
            "with: <#{iGroups}> dirs and <#{iFiles}> files."

end # F~build

#   ***************************************************************************
#   !MOD:  environment + test
#   ***************************************************************************

#   === color?
def F_set_globals()
    #   DES:    set globals {sNow,bVerbose,bColor}
    #   +   EXIT code
    iExitCode = $m.f_exitCode(ENV['v_FWK_exitCode'].to_i)
    #   +   Time
    $sNow=$m.f_sNow('%y%m%d%H%M%S')
    #   +   set class pointer to File Opbect
    $pF = CFile.new
    #   *   show settings
    if (C_VERBOSE)
        puts "env.ExitCode:<#{iExitCode}>"
        puts "env.Now:<#{$sNow}>"
    end
end # F~set_globals

def F_set_tmpDir()
    #   DES:    set tmp dir using globals or library function
    #   ENV['TMP']=nil
    if (ENV['TMP'] == nil)
        sDir = Dir.tmpdir(); i=1
    else
        sDir = ENV['TMP']; i=2
    end
    $sDirTmp = CFile.f__sUnixPath(sDir)
    $m.f_inf "tmpDir(#{i}):<#{$sDirTmp}>" if C_VERBOSE
end # F~set_tmpDir

def F_test()
    i = $pF.x__Id
    s = $pF.s__Now
    $m.f_puts "Now:#{s} at:[#{i}]"
    fOut = lambda { |i,b,s| $m.f_puts "fPath[#{i}]:#{b}:'#{s}'" }
    i = 1
    b,x = $pF.f_bsFilePath_maker('d:\\KNT\\prj\\UEZ\\','\\grp\\otto\\peter.txt');    fOut.call(i,b,x); i+=1
    b,x = $pF.f_bsFilePath_maker('');    fOut.call(i,b,x); i+=1   #   false:'' [2]
    b,x = $pF.f_bsFilePath_maker('9');   fOut.call(i,b,x); i+=1   #   false:'' [3]
    b,x = $pF.f_bsFilePath_maker('c');   fOut.call(i,b,x); i+=1
    b,x = $pF.f_bsFilePath_maker('c:');   fOut.call(i,b,x); i+=1
    b,x = $pF.f_bsFilePath_maker('c:\\');   fOut.call(i,b,x); i+=1
    b,x = $pF.f_bsFilePath_maker('9','d:\tmp');    fOut.call(i,b,x); i+=1 # [7]: false+Exc
    b,x = $pF.f_bsFilePath_maker('c','');    fOut.call(i,b,x); i+=1
    b,x = $pF.f_bsFilePath_maker('c:','');   fOut.call(i,b,x); i+=1
    b,x = $pF.f_bsFilePath_maker('c:\\',''); fOut.call(i,b,x); i+=1
    b,x = $pF.f_bsFilePath_maker('c:\\','d:\tmp'); fOut.call(i,b,x); i+=1                 # c:/tmp [11]
    b,x = $pF.f_bsFilePath_maker('c:\\','d:\tmp\peter.txt'); fOut.call(i,b,x);i+=1        # c:/peter.txt [12]
    b,x = $pF.f_bsFilePath_maker('c:\pub','d:\tmp\peter.txt');fOut.call(i,b,x);i+=1       # c:/pub/peter.txt
    b,x = $pF.f_bsFilePath_maker('c:\pub','peter.txt');fOut.call(i,b,x); i+=1;            # c:/pub/peter.txt
    b,x = $pF.f_bsFilePath_maker('c:\pub','peter.txt',0);fOut.call(i,b,x); i+=1;          # c:/pub/peter.txt
    b,x = $pF.f_bsFilePath_maker('c:\pub','d:\tmp\peter.txt',1);fOut.call(i,b,x); i+=1;   # c:/pub/tmp/peter.txt [16]
    b,x = $pF.f_bsFilePath_maker('c:\pub','d:\tmp\peter.txt',2);fOut.call(i,b,x); i+=1;   # c:/peter.txt
end
#   ***************************************************************************
#   !MOD:  arguments
#   ***************************************************************************

def F_parseArgs()
    hOpts  = Hash.new(); aArgs  = Array.new()
    #   help info?
    aArgs  = ARGV.clone           # save before using OptionParser
    bHlp=false
    if (ARGV.empty?)
        ARGV << '-h' if ARGV.empty?
    end
    #   parsing
    pOptionParser = OptionParser.new do |x|
        x.banner = "usage:DOS>ruby #{$sFileScript_NoExt} [hOpts]"
        x.on('-h', '--help', 'displays this') do |y|
            hOpts[:mHelp]  = true;
            puts x # show this
            bHlp=true
        end
        x.on('-v','--version', 'show program and ruby version') do |y|
            hOpts[:mVersion] = y;
        end
        x.on('--usage', 'usage: explicit help') do |y|
            hOpts[:mUsage] = y;
        end
        x.on('--clean', 'clean tmp dir') do |y|
            hOpts[:mClean]  = y;
        end
        x.on('--test', 'testmode') do |y|
            hOpts[:mTest]  = y;
        end
        x.on('--cmd <cmd>', 'run cmd<{zip,unzip,build,uedParse}>') do |y|
            hOpts[:mCmd]  = y;
        end
        x.on('--verbose', 'verbose') do |y|
            hOpts[:mVerbose] = y;
        end
        x.on('-w','--warning', 'warnings') do |y|
            hOpts[:mWarning] = y;
        end
        x.on('-f','--prj <sUepFile>', 'uePrjFile||ueZipFile') do |y|
            hOpts[:mUepFile]  = y;
        end
        x.on('-t','--typ <aUepType>', "a={'iso':Default,'utf','wrd'}") do |y|
            hOpts[:mUepType]  = y;
        end
        x.on('-p','--parse', 'uePrjFile parsing only') do |y|
            hOpts[:mParse]  = y;
        end
        x.on('-g','--tag', 'uePrjFile tag parsing') do |y|
            hOpts[:mTag]  = y;
        end
        x.on('--dir <zipDir>', 'zip uepFiles into srcDir:=zipDir') do |y|
            hOpts[:mDir]  = y;
        end
        x.on('--obj <objDir>', 'unzip into objDir=:unzipDir') do |y|
            hOpts[:mObj]  = y;
        end
        x.on('--flat', 'copy flat (no tree) into mount Dir') do |y|
            hOpts[:mFlat]  = y; # ? filePath1 and filePath2 with eq fileName
        end
        x.on('-o','--overwrite <mode>', "unzip overwrite mode:=<'?','r','u','f'>") do |y|
            hOpts[:mOverwrite]  = y;
        end
        x.on('--parse', 'parse UEP-File + create iniZipFile') do |y|
            hOpts[:mParse]  = y;
        end
        x.on('-x','--ext <aFileExtensionList>', "a={'.txt,'.rb'}=:DEFAULT") do |y|
            hOpts[:mFEL]  = y;
        end
        x.on('--color', 'dosColors:=ON') do |y|
            hOpts[:mColor]  = y;
        end
    end # OptionParser.new do
    begin pOptionParser.parse!
        rescue OptionParser::InvalidOption => e   # invalid option
        $m.f_exc("Parser found Illegal Option : <#{e}> .",__LINE__)
        return false
    end
    #   return possibilities
    if (hOpts==nil || hOpts.length == 0)
        return false
    elsif (bHlp)
        return false,hOpts
    end
    return true, hOpts, aArgs
end # ~parseArgs
#   ***************************************************************************
#   !MOD: parse mandatory+optional args
#   ***************************************************************************

#   validate:   argOk, but functionality also ok?
#   verify:     functionality OK, but wrong product?

#
#   === args:   classGlobals
#

def F_validate_and_store_globalArgs()
    #   DES:    use the arguments and store into library
    #   +   Verbose
    bVerbose=C_VERBOSE # !CRQ-210123: use standard
    if ($hOpts[:mVerbose])
        $m.f_trc(nil,__LINE__,__method__,"hOpts:=Verbose>")
        bVerbose=true
    end
    $bVerbose=bVerbose
    #   +   Warning
    bWarning=bVerbose   #   !CRQ-210219:notFalse
    if ($hOpts[:mWarning])
        $m.f_trc(nil,__LINE__,__method__,"hOpts:=Warning}>")
        bWarning=true
    end
    #   +   Color
    bColor=false
    if ($hOpts[:mColor])
        $m.f_trc(nil,__LINE__,__method__,"hOpts:=Color}>")
        bColor=true
    end
    #   *   save to lib-option-settings
    hOptx = Hash.new
    hOptx [:mVerbose]    = bVerbose
    hOptx [:mWarning]    = bWarning
    hOptx [:mColor]      = bColor
    $m.f_optionSet(hOptx)
    if (C_VERBOSE)
        puts "env.Opts:<#{hOptx}>"
    end
end # F~validate_and_store_globalArgs
#
#   === args:   mandatory
#

def F_verify_mandatory_args()
    #   RET: *  false: missing or wrong command args
    #        *  true: all cmd Args={cmd,dir,file} OK

    $m.f_trc(nil,__LINE__,__method__,"BEGIN")

    #   arg:---cmd?
    if  (!$hOpts[:mCmd])
        $m.f_trc(nil,__LINE__,__method__,"check parameter 'cmd'")
        $m.f_error("?ARG: missing:<'cmd'>.",__FILE__,__LINE__,__method__)
        return false
    end

    #   arg:--cmd=help
    if ($hOpts[:mCmd] == 'help')
        $m.f_inf("?arg '--cmd==help'",C_COLOR_CYAN)
        return false
    end
    if ($hOpts[:mCmd] == 'usage')
        $m.f_inf("?arg '--cmd==usage'",C_COLOR_CYAN)
        return false
    end

    #   arg:---uep?
    if ($hOpts[:mUepFile] == nil)
        $m.f_inf("?arg '--uep==NIL'",C_COLOR_CYAN)
        return false
    end

    #   cmds else
    if ($hOpts[:mCmd] != C_CMD_BUILD)
        if ($hOpts[:mUepFile])
            $m.f_trc(nil,__LINE__,__method__,"check parameter 'uep'")
            sFile = CFile.f__sUnixPath($hOpts[:mUepFile])
            if (CFile.f__bFileExist(sFile))
                $m.f_trc(nil,__LINE__,__method__,"use UEP:=<#{sFile}>")
            else
                $m.f_error("UEP:<'#{sFile}'> not exists.",__FILE__,__LINE__,__method__)
                return false
            end
        else
            $m.f_error("?ARG: missing mandtory arg:--uep",__FILE__,__LINE__,__method__)
            return false
        end
    end

    #   arg:--dir?
    $m.f_trc(nil,__LINE__,__method__,"check:--dir")
    if ($hOpts[:mDir])
        sDir = CFile.f__sUnixPath($hOpts[:mDir])
        $m.f_inf("arg.DIR1:#{$hOpts[:mDir]}",C_COLOR_CYAN)
        $m.f_inf("arg.DIR2:#{sDir}",C_COLOR_CYAN)
        if (not Dir.exists?(sDir))
            $m.f_error("?ARG: wrong sSrcDir:<#{sDir}>",__FILE__,__LINE__,__method__)
            return false
        end
        $m.f_trc(nil,__LINE__,__method__,"use dir:=<#{sDir}>")
    else
        if ($hOpts[:mCmd] == C_CMD_BUILD)   # need 'DIR' - not auto tempDir
            $m.f_error("?ARG: arg --dir missing",__FILE__,__LINE__,__method__)
            return false
        else
            $m.f_inf("?arg '--dir' missing, I take tmpDir")
        end
        sDir = $hOpts[:mDir] = $sDirTmp
        $m.f_trc(nil,__LINE__,__method__,"use tmpDir:=<#{sDir}>")
        #   noReturn
    end

    #   unzip:
    $m.f_trc(nil,__LINE__,__method__,"check:--cmdUnzip.Ovwerite&&Flat")
    if ($hOpts[:mCmd] == C_CMD_UNZIP)
        $m.f_trc(nil,__LINE__,__method__,"check:cmd=--unzip")
        #   objDir (unzipDir)
=begin
        if ($hOpts[:mObj] == nil)
            $hOpts[:mObj] = $sDirTmp
            $m.f_inf("?arg '--obj' missing, I take tmpDir")
        end
        $m.f_trc(nil,__LINE__,__method__,"check:--obj")
        sDir = $hOpts[:mObj]
        if (not Dir.exists?(sDir))
            $m.f_error("?ARG: wrong sObjDir:<'dir'>",__FILE__,__LINE__,__method__)
            return false
        end
=end
        if ($hOpts[:mObj] == nil)
            $m.f_inf("?--obj(Dir) is nil")
        end

        #   kills som values
        if ($hOpts[:mOverwrite] == nil)
            $hOpts[:mOverwrite] = C_OPT_OVERWRITE_NEVER
            $m.f_inf("?opt:'--overwrite' missing: use:NEVER")
        end
        if ($hOpts[:mFlat] != nil)
            $m.f_inf("?opt:'--flat' probably changed")
        end
    end

    $m.f_trc(nil,__LINE__,__method__,"END")
    return true
end

#
#   === args:   optional
#

def F_verify_and_use_optional_args()

    #   REM:    * check:mOverwrite
    #   REM:    * check:mFEL
    #   REM     * check objDir
    #   RET:    * false || true=verify ok+ saved options

    $m.f_trc(nil,__LINE__,__method__,"BEGIN...")

    if ($hOpts[:mObj])
        #   when we enter an objDir, it must exists
        sDirObj = $hOpts[:mObj]
        if (not Dir.exists? sDirObj)
            return false        # !CRQ-190804:check existing objDir
        end
    end

    if ($hOpts[:mOverwrite])
        #   Remark - without overwrite, the target-file will not be overwritten
        #   a warning will be replied.
        sMode = $hOpts[:mOverwrite]
        $m.f_trc(nil,__LINE__,__method__,"Overwrite.mode:=<#{sMode}>")
        aOpts = [
            C_OPT_OVERWRITE_INFO    ,
            C_OPT_OVERWRITE_ADD     ,
            C_OPT_OVERWRITE_UPDATE  ,
            C_OPT_OVERWRITE_RESTORE ,
            C_OPT_OVERWRITE_FORCE   ,
            C_OPT_OVERWRITE_NEVER
        ]
        if (!aOpts.include?(sMode))
            $m.f_error("?allowed Opts:<#{aOpts}>",__FILE__,__LINE__,__method__)
            return false
        end
        if (sMode == C_OPT_OVERWRITE_INFO)
            $m.f_puts("help option 'overwrite' modes:<#{sMode}> if file exists")
            c=C_OPT_OVERWRITE_INFO    ; puts "#{c}:\t help";
            c=C_OPT_OVERWRITE_ADD     ; puts "#{c}:\t add only";
            c=C_OPT_OVERWRITE_UPDATE  ; puts "#{c}:\t add, update  : if zip newer obj";
            c=C_OPT_OVERWRITE_RESTORE ; puts "#{c}:\t add, restore : if zip older obj";
            c=C_OPT_OVERWRITE_FORCE   ; puts "#{c}:\t extract always complete zip";
            c=C_OPT_OVERWRITE_NEVER   ; puts "#{c}:\t extract never - default";
            return false
        end
    else
        $m.f_inf("?arg=Overwrite not found")
    end

    #   Extension?
    if ($hOpts[:mFEL])
        sOpt = $hOpts[:mFEL]
        $m.f_trc(nil,__LINE__,__method__,"FEL:=<#{sOpt}>")
        aOpts = [
            C_FEL_ZIP    ,
            C_FEL_BUILD     ,
            C_FEL_ID__ANY
        ]
        if (!aOpts.include?(sOpt))
            #   !CRQ-210206:do a litte extension-check
            bOpt = false
            if ((sOpt.length == 1) && (sOpt == C_FEL_ID__ANY))
                bOpt = true
            elsif ( sOpt[0] == C_FEL_ID__SEP )
                bOpt = true
            else
                $m.f_error("?bOpt:sOpt:='#{sOpt}'",__FILE__,__LINE__,__method__)
                return false
            end
        end
    else
        case ($hOpts[:mCmd])
            when C_CMD_ZIP
                $hOpts[:mFEL] = C_FEL_ID__ANY   # !CRQ-190729: bashPrj
            when C_CMD_UNZIP
                $hOpts[:mFEL] = C_FEL_ZIP
            when C_CMD_BUILD
                $hOpts[:mFEL] = C_FEL_BUILD
            else
                $hOpts[:mFEL] = C_FEL_ID__ANY
        end
        $m.f_inf("?arg '--ext' is missing: take:<#{$hOpts[:mFEL]}>")
    end

    #   check uepType?
    if ($hOpts[:mUepType])
        sType = $hOpts[:mUepType]
        aType = [
            C_OPT_UEPTYPE_ISO    ,
            C_OPT_UEPTYPE_UTF    ,
            C_OPT_UEPTYPE_WRD
        ]
        if (!aType.include?(sType))
            $m.f_error("?Type :<#{sType}> NOT in: <#{aType}>",__FILE__,__LINE__,__method__)
            return false
        end
    else
        $hOpts[:mUepType] = C_OPT_UEPTYPE_ISO
        $m.f_inf("?arg '--typ' is missing: take:<#{$hOpts[:mUepType]}>")
    end

    return true

end # F~verify_and_use_optional_cmdArgs
#   ***************************************************************************
#   !MOD: command runner
#   ***************************************************************************

C_FILE_EXTENSION_OUT = 'zip.txt'
C_FILE_EXTENSION_ZIP = 'zip'

def F_doCommand

    case $hOpts[:mCmd]

    when C_CMD_ZIP

        $m.f_trc(nil,__LINE__,__method__,"*** zip")

        sFileVersion    = File.basename($hOpts[:mUepFile],".*") + '-' + $sNow.to_s
        $m.f_trc(nil,__LINE__,__method__,"sFileVersion:<#{sFileVersion}>")

        #   name:fileOut
        sFile       = sFileVersion.to_s + '.' + C_FILE_EXTENSION_OUT.to_s
        sFileOut    = $pF.f_sFilePath($sDirTmp,sFile)
        $m.f_trc(nil,__LINE__,__method__,"outFile:<#{sFileOut}>")

        #   parse project file and print a fileList at Tmp
        bRc = F_uedParse($hOpts[:mUepFile],sFileOut)     # in:ue.prj, out:fileList.out
        if (!bRc)
            $m.f_error("uedParsing",__FILE__,__LINE__,__method__)
            return false
        end
        $m.f_inf("bRc.uedParse.tmp:<#{bRc}>") if C_DEBUG

        #   name:fileZip
        if ($hOpts[:mDir]==nil)
            $m.f_exit("mDir==nil",__FILE__,__LINE__,__method__)
            return false
        end

        sDir        = $hOpts[:mDir]
        sFile       = sFileVersion.to_s + '.' + C_FILE_EXTENSION_ZIP.to_s
        sFileZip    = $pF.f_sFilePath(sDir,sFile)
        $m.f_trc(nil,__LINE__,__method__,"zipFile:<#{sFileZip}>")

        #   parse project-text file
        bRc,iRc,nRc = F_zipMake_txt2zip(sFileOut,sFileZip)    # in:fileList.out, out:file.zip
        if (!bRc)
            $m.f_error("?error zipMake",__FILE__,__LINE__,__method__)
            return false
        end
        $m.f_puts "!OK:zipped  files<#{iRc}> into File:<#{sFileZip}> with size:<#{nRc}>"

        #   copy new output zip file to Tmp
        if (C__USE_DUPLICATE)
            $m.f_trc(nil,__LINE__,__method__,"duplicate:<#{sFileZip}>")
            sFileZipTmp = File.basename(sFileZip)
            sFileZipTmp = $pF.f_sFilePath($sDirTmp,sFileZipTmp)
            $m.f_trc(nil,__LINE__,__method__,"sFileZipTmp:=<#{sFileZipTmp}>")
            bRc,tRc = $pF.f_bFileCopy(sFileZip,sFileZipTmp)   # to TmpDir
            if (bRc)
                s = "copy FILE:<#{sFileZip}> to:<#{sFileZipTmp}>:bRc=#{bRc}"
                $m.f_trc(nil,__LINE__,__method__,"#{s}")
            end
        end

    when C_CMD_PARSE

        $m.f_trc(nil,__LINE__,__method__,"*** parsing")

        #   ued Parse only
        #   puts the results into --dir (not into %TMP/)
        $m.f_trc(nil,__LINE__,__method__,"cmd:=parse")
        sFile       = File.basename($hOpts[:mUepFile],".*") + '-' + $sNow.to_s
        sFile       = sFile.to_s + '.' + C_FILE_EXTENSION_OUT.to_s
        sFileOut    = $pF.f_sFilePath($hOpts[:mDir],sFile)
        bRc = F_uedParse($hOpts[:mUepFile],sFileOut)     # in:ue.prj, out:fileList.out
        $m.f_inf("bRc.uedParse.cmd:<#{bRc}>")

    when C_CMD_UNZIP

        $m.f_trc(nil,__LINE__,__method__,"*** unzip")

        #   !usage: $>  ruby <SCRIPT>   --cmd <CMD> --uep <UEP> [--dir zipDirDir]
        #                   [--overwrite <par> [--obj <objDir> [--flat ]]]

        $m.f_trc(__FILE__,__LINE__,__method__,"unzip:[1]:zipGet>")

        #   check output Dir
        $m.f_trc(nil,__LINE__,__method__,"...Dir")
        if ($hOpts[:mObj] == nil)
            $m.f_warning("ObjDir missing -warning",__FILE__,__LINE__,__method__)
            #   return false
        end

        #   select valid zipFile
        bRc,sZipFile = F_zipGet($hOpts[:mUepFile],$hOpts[:mDir])
        if (!bRc)
            $m.f_error("I can't zip",__FILE__,__LINE__,__method__)
            return false
        end

        #   make a zipTxtFile using a real zipFile
        $m.f_trc(nil,__LINE__,__method__,"...zip2txt")
        bRc,sTxtFile = F_zipMake_zip2txt(sZipFile)
        if (!bRc)
            $m.f_error("main:I can't do zip2Txt",__FILE__,__LINE__,__method__)
            return false
        end

        #   extract zip
        $m.f_trc(nil,__LINE__,__method__,"..extract")
        bRc,iRc = F_zipExtract(sZipFile)
        if (!bRc)
            $m.f_warning("?I can't extact",__FILE__,__LINE__,__method__)
            return false
        end

        #   save cmd and finish
        $m.f_trc(nil,__LINE__,__method__,"...ready")
        sCmd=$hOpts[:mCmd]
        sDir=$hOpts[:mObj]
        $m.f_puts "!OK:extracted (#{sCmd}) => <#{iRc}> files to DIR=<#{sDir}>"

    when C_CMD_BUILD

        $m.f_trc(nil,__LINE__,__method__,"*** build")
        $m.f_inf("Build:FEL:=<#{$hOpts[:mFEL]}>")
        F_build()

    else
        $m.f_error("main:unknown command",__FILE__,__LINE__,__method__)
        return false

    end # case

    return true

end # F~doCommand

#   ***************************************************************************
#   !MOD: main
#   ***************************************************************************

#   DATA

#   set environment
F_set_globals()
F_set_tmpDir()

#   get input args and show
bRc,$hOpts,aArgs = F_parseArgs()
if (!bRc)
    F_usage()
    if (($hOpts != nil) && ($hOpts[:mHelp] != nil) && ($hOpts[:mHelp] == true))
        return  # HELP
    end
    $m.f_exit("bRc==false",__FILE__,__LINE__)
end

#   show global Options?
if (C_VERBOSE)
    $m.f_puts "[#{__LINE__}]::hOpts1:<#{$hOpts}>"
end

#   set color+verbose+warning before header
F_validate_and_store_globalArgs()

#   header
$n = rand(100...1000) # andom 101...999
$m.f_hdr("ueZip Header:<#{$n}>",__FILE__) # !CRQ-200702:using random

#   show opts if Verbose - !CRQ-200702:inside logfile
$m.f_inf "main.hOpts:<#{$hOpts}>"

#   parse standalone arguments
if  ($hOpts[:mVersion])
    $m.f_puts "Ruby Version:<" + RUBY_VERSION.to_s + ">"

elsif ($hOpts[:mTest])
    F_test()

elsif ($hOpts[:mUsage])
    F_usage(true); $m.f_end()   # $m.f_exit("DIR==nil",__FILE__,__LINE__)

elsif ($hOpts[:mClean])

    # goto a Dir - clean there
    if ($hOpts[:mDir] == nil)
        $m.f_exit("DIR==nil",__FILE__,__LINE__)
    end

    bRc,aFEL = $pF.f_aFileExtensionList(C_FEL_CLEAN)
    if (!bRc)
        $m.f_exit("?aFileExtList",__FILE__,__LINE__)
    end
    $m.f_inf "clean.aExt:<#{aExt}>" if C_VERBOSE

    bRc,aRc = $pF.f_dirTree_manager($hOpts[:mDir],aFEL,CFile::C_DIRTREE_CMD_REMOVE)
    if (!bRc)
        $m.f_warning("?DTM has nothing found",__FILE__,__LINE__,__method__)
    end
    $m.f_puts "clean.bRc:<#{bRc}>" if C_VERBOSE

#   parse argument combinations
else
    bRc = F_verify_mandatory_args()
    if (bRc)
        bRc = F_verify_and_use_optional_args()
        #   show global Options?
        if (C_VERBOSE)
            $m.f_puts "[#{__LINE__}]::hOpts2:<#{$hOpts}>"
        end
    end
    if (!bRc)
        F_usage(); $m.f_optionGet() if C_VERBOSE; exit(-__LINE__)
    end
    bRc = F_doCommand()
    if (!bRc)
        $m.f_exit("bRc==false",__FILE__,__LINE__)
    end
    $m.f_puts "!OK:Program finish..."
end

#   set enviroment(DOS) exit-code -- see ErrorLevel
$m.f_end()
