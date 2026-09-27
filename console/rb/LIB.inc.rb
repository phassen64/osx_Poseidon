#
#   Ruby Library 2017
#   Autor: P.Hassen
#

#   encoding    :   UTF8-noBOM
#   !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

#   ----------------------------------------------------------------------------
#   get posix
#   ----------------------------------------------------------------------------

g_bOsPosix = false
s = RUBY_PLATFORM.to_s
if ( s == 'x64-mingw-ucrt')
elsif ( s == 'x86_64-linux-gnu' )
    g_bOsPosix = true
end

#   ----------------------------------------------------------------------------
#   posix.modules
#   ----------------------------------------------------------------------------

if ( g_bOsPosix )
else
    require 'colorize'  #   !CRQ-240425:notInUnix
    require 'awesome'   #   !CRQ-240425:notInUnix
end


#   ----------------------------------------------------------------------------
#   else
#   ----------------------------------------------------------------------------

require 'csv'
require 'date'
require 'optparse'      # parse arg options

#   ----------------------------------------------------------------------------
#   posix.constants
#   ----------------------------------------------------------------------------

if ( g_bOsPosix )
    C_DIR_SEPARATOR =   '/'
    C_STR_COLORED   =   false
#   C_DIR_TMP       =   ENV['User'] + C_DIR_SEPARATOR + 'Temp'
    C_DIR_TMP       =   '/var/tmp'
else
    C_DIR_SEPARATOR =   '\\'
    C_STR_COLORED   =   true
    C_DIR_TMP       =   ENV['UserProfile'] + ENV['v_USR_scratch_relPath']
end # !CRQ-241226:ScratchByFwk

#   else
C_LIB_VERBOSE       = false    # internal library trace

#   ----------------------------------------------------------------------------
#   Environment
#   ----------------------------------------------------------------------------

C_EXIT_CODE         = 100       # standard exit code for tutorial

$bVerbose=false; $bColor=false
if  ENV['v_mode_bVbs'] == 'true'
    $bVerbose=true
end
if  ENV['v_mode_bClr'] == 'true'
#   system('color 0F')  # set black/white  => better inside DOS
    $bColor=true
end


#   $bColor=true    # !CRQ-220706:try
#   powershell can set:$env:v_COLOR=$true

$iExitCode = C_EXIT_CODE
if  ENV['v_FWK_exitCode'] != nil
    $iExitCode=ENV['v_FWK_exitCode'].to_i
end

if (C_LIB_VERBOSE)
    puts "g.Posix:=<#{$g_bPosix}>"
    puts "g.Verbose:=<#{$bVerbose}>"
    puts "g.Color:=<#{$bColor}>"
    puts "g.ExitCode:=<#{$iExitCode}>"
end

#   ----------------------------------------------------------------------------
#   logging
#   ----------------------------------------------------------------------------

C_LOG_FILENAME          = "logTutor"     # baseName

#   colors
C_COLOR_DEFINE          = true
if  ( C_COLOR_DEFINE )
    C_COLOR_BLACK       = 0
    C_COLOR_RED         = 1
    C_COLOR_GREEN       = 2
    C_COLOR_YELLOW      = 3
    C_COLOR_BLUE        = 4
    C_COLOR_MAGENTA     = 5
    C_COLOR_CYAN        = 6
    C_COLOR_WHITE       = 7     # grey
#   !CRQ-210302: Escape-Sequenzen
#   https://ss64.com/nt/syntax-ansi.html
#   https://en.wikipedia.org/wiki/ANSI_escape_code
    C_ESC__DEFAULT                      =   "0"
    C_ESC__COLOR_BLACK__FG              =   "\e[30m"
    C_ESC__COLOR_BLACK__BG              =   "\e[40m"
    C_ESC__COLOR_BLACK__BRHT_FG         =   "\e[90m"
    C_ESC__COLOR_BLACK__BRHT_BG         =   "\e[100m"
    C_ESC__COLOR_WHITE__FG              =   "\e[97m"
    C_ESC__COLOR_WHITE__BG              =   "\e[107m"
    C_ESC__COLOR_GRAY__FG               =   "\e[37m"    # Gray?
    C_ESC__COLOR_GRAY__BG               =   "\e[47m"
    C_ESC__COLOR_RED__FG                =   "\e[31m"
    C_ESC__COLOR_RED__BG                =   "\e[41m"
    C_ESC__COLOR_RED__BRHT__FG          =   "\e[91m"
    C_ESC__COLOR_RED__BRHT__BG          =   "\e[101m"
    C_ESC__COLOR_GREEN__FG              =   "\e[32m"
    C_ESC__COLOR_GREEN__BG              =   "\e[42m"
    C_ESC__COLOR_GREEN__BRHT__FG        =   "\e[92m"
    C_ESC__COLOR_GREEN__BRHT__BG        =   "\e[102m"
    C_ESC__COLOR_YELLOW__FG             =   "\e[33m"
    C_ESC__COLOR_YELLOW__BG             =   "\e[43m"
    C_ESC__COLOR_YELLOW__BRHT__FG       =   "\e[93m"
    C_ESC__COLOR_YELLOW__BRHT__BG       =   "\e[103m"
    C_ESC__COLOR_BLUE__FG               =   "\e[34m"
    C_ESC__COLOR_BLUE__BG               =   "\e[44m"
    C_ESC__COLOR_BLUE__BRHT__FG         =   "\e[94m"
    C_ESC__COLOR_BLUE__BRHT__BG         =   "\e[104m"
    C_ESC__COLOR_MAGENTA__FG            =   "\e[35m"
    C_ESC__COLOR_MAGENTA__BG            =   "\e[45m"
    C_ESC__COLOR_MAGENTA__BRHT__FG      =   "\e[95m"
    C_ESC__COLOR_MAGENTA__BRHT__BG      =   "\e[105m"
    C_ESC__COLOR_CYAN__FG               =   "\e[36m"
    C_ESC__COLOR_CYAN__BG               =   "\e[46m"
    C_ESC__COLOR_CYAN__BRHT__FG         =   "\e[96m"
    C_ESC__COLOR_CYAN__BRHT__BG         =   "\e[106m"
    C_ESC__BOLD                         =   "\e[1m"
    C_ESC__UNDERLINE                    =   "\e[4m"
    C_ESC__NOUNDERLINE                  =   "\e[24m"
    C_ESC__REVERSE_TEXT                 =   "\e[7m"
    C_ESC__POSITIVE_TEXT                =   "\e[27m"
    C_ANSI__COLOR_BLACK                 =   0
    C_ANSI__COLOR_BLUE                  =   1
    C_ANSI__COLOR_GREEN                 =   2
    C_ANSI__COLOR_CYAN                  =   3
    C_ANSI__COLOR_RED                   =   4
    C_ANSI__COLOR_MAGENTA               =   5
    C_ANSI__COLOR_GRAY                  =   7
    C_ANSI__COLOR_BLACK__BRHT           =   8
    C_ANSI__COLOR_BLUE__BRHT            =   9
    C_ANSI__COLOR_GREEN__BRHT           =   0x0a
    C_ANSI__COLOR_CYAN__BRHT            =   0x0b
    C_ANSI__COLOR_RED__BRHT             =   0x0c
    C_ANSI__COLOR_MAGENTA__BRHT         =   0x0d
    C_ANSI__COLOR_YELLOW__BRHT          =   0x0e
    C_ANSI__COLOR_WHITE                 =   0x0f
end

#   ===========================================================================
#   !MOD:class redefines
#   ===========================================================================

#   https://stackoverflow.com/questions/1108767/terminal-color-in-ruby/1108778
#   EscapeChar = '\e'

class String

    if (C_STR_COLORED)
        hString = {
            # foreground colors
            :m_black          => C_ESC__COLOR_BLACK__FG,
            :m_red            => C_ESC__COLOR_RED__FG,
            :m_green          => C_ESC__COLOR_GREEN__BRHT__FG,
            :m_yellow         => C_ESC__COLOR_YELLOW__BRHT__FG,
            :m_blue           => C_ESC__COLOR_BLUE__BRHT__FG,
            :m_magenta        => C_ESC__COLOR_MAGENTA__BRHT__FG,
            :m_cyan           => C_ESC__COLOR_CYAN__FG,
            :m_gray           => C_ESC__COLOR_GRAY__FG,
            :m_white          => C_ESC__COLOR_WHITE__FG,
            # background colors
            :m_black_bg       => C_ESC__COLOR_BLACK__BG,
            :m_red_bg         => C_ESC__COLOR_RED__BG,
            :m_green_bg       => C_ESC__COLOR_GREEN__BG,
            :m_yellow_bg      => C_ESC__COLOR_YELLOW__BG,
            :m_blue_bg        => C_ESC__COLOR_BLUE__BG,
            :m_magenta_bg     => C_ESC__COLOR_MAGENTA__BG,
            :m_cyan_bg        => C_ESC__COLOR_CYAN__BG,
            :m_white_bg       => C_ESC__COLOR_WHITE__BG,
        } # hash
        hString.each do |sKey, sVal|
            define_method(sKey) do
                sVal + self + "\e[0m"
            end
        end
    end # string colored

end # class String

#   ===========================================================================
#   POSIX functions
#   ===========================================================================

#   check all chars inside of the input string

class CPosix < String

    def f_isPrint(s)    # all print chars incl. SPACE
        if (s==nil)
            return false
        end
        r = /[[:print:]]{#{s.length}}/
        x = s.match(r)
        if ((x==nil) || (x==false))
            return false
        end
        return true
    end

    def f_isGraph(s)     # all print chars without SPACE
        if (s==nil)
            return false
        end
        r = /[[:graph:]]{#{s.length}}/
        x = s.match(r)
        if ((x==nil) || (x==false))
            return false
        end
        return true
    end

    def f_isAlpha(s)
        if (s==nil)
            return false
        end
        r = /[[:alpha:]]{#{s.length}}/
        x = s.match(r)
        if ((x==nil) || (x==false))
            return false
        end
        return true
    end

    def f_isNumeric(s)
        if (s==nil)
            return false
        end
        r = /[[:digit:]]{#{s.length}}/
        x = s.match(r)
        if ((x==nil) || (x==false))
            return false
        end
        return true
    end

    def f_isAlnum(s)
        if (s==nil)
            return false
        end
        r = /[[:alnum:]]{#{s.length}}/
        x = s.match(r)
        if ((x==nil) || (x==false))
            return false
        end
        return true
    end

    def f_isHexnum(s)       # Hex ' 0...1A...F'
        if (s==nil)
            return false
        end
        r = /[[:xdigit:]]{#{s.length}}/
        x = s.match(r)
        if ((x==nil) || (x==false))
            return false
        end
        return true
    end

    def f_isLower(s)       # 'a'...'z'
        if (s==nil)
            return false
        end
        r = /[[:lower:]]{#{s.length}}/
        x = s.match(r)
        if ((x==nil) || (x==false))
            return false
        end
        return true
    end

    def f_isUpper(s)       # 'A'...'Z'
        if (s==nil)
            return false
        end
        r = /[[:upper:]]{#{s.length}}/
        x = s.match(r)
        if ((x==nil) || (x==false))
            return false
        end
        return true
    end

    def f_isBlank(s)       # ' ' '\t'
        if (s==nil)
            return false
        end
        r = /[[:blank:]]{#{s.length}}/
        x = s.match(r)
        if ((x==nil) || (x==false))
            return false
        end
        return true
    end

    def f_isCntrl(s)       # '\n' '\t'
        if (s==nil)
            return false
        end
        r = /[[:cntrl:]]{#{s.length}}/
        x = s.match(r)
        if ((x==nil) || (x==false))
            return false
        end
        return true
    end

    def f_isPunct(s)       # ".;,"
        if (s==nil)
            return false
        end
        r = /[[:punct:]]{#{s.length}}/
        x = s.match(r)
        if ((x==nil) || (x==false))
            return false
        end
        return true
    end

end # CPosix

#   ===========================================================================
#   !MOD:class CTutor
#   ===========================================================================

class  CTutor < CPosix

    C_DT_TUTOR_STR    = "%y%m%d%H%M%S" # "%Y-%m-%d;%H:%M:%S:%L"
    C_LOG_DATETIME_SEP  = '.'  # !CRQ-190923 :from '_' => '.'
    @@iThmCtr       = 0
    $bLogFile       = false
    $sLogFile       = nil

    @@bColor        =   $bColor
    @@bVerbose      =   $bVerbose
    @@iExitCode     =   $iExitCode
    @@bWarning      =   false

private

    def f__color( s, p_iColor )
        #   DES:    replies input string colored or not
        #   INp:    string, iColorValue
        if (C_STR_COLORED && @@bColor && (p_iColor!=nil))
            case p_iColor
            when C_COLOR_YELLOW
                s=s.m_yellow
            when C_COLOR_CYAN
                s=s.m_cyan
            when C_COLOR_MAGENTA
                s=s.m_magenta
            when C_COLOR_RED
                s=s.m_red
            when C_COLOR_BLUE
                s=s.m_blue
            when C_COLOR_GREEN
                s=s.m_green
            when C_COLOR_WHITE
                s=s.m_white
            else
                # nothing
            end
        end
        return s
    end # f~~color

    def f__color_value(p_xIdx)
        cNormal   = "\e[#{p_xIdx}m#{p_xIdx}\e[0m;"
        # cNormal   = "\e[#{p_xIdx}m       #{p_xIdx}\e[0m"
        cBold     = "\e[#{p_xIdx}m\e[1m  #{p_xIdx}\e[0m"
        return "#{cNormal}"
        #       return "#{cNormal} #{cBold};  "
    end #f~~color_value

    def f__sTab(p_cChar,n=3,p_bSht=false)
        if (p_bSht) then
            return (p_cChar + ' ' * n)
        else
            return (p_cChar * n + ' ')
        end
    end # f~sTab

    def f__sprint( p_sString, p_iColor=nil )
        s = p_sString
        if ( C_STR_COLORED )
            return f__color(s,p_iColor)
        else
            return s
        end
    end # f~~sprint

    def f__puts( p_sText, p_iColor=nil )
        s = p_sText
        if ( C_STR_COLORED )
            s = f__color(s,p_iColor)
        end
        puts s
    end # f~~puts

    def f__print( p_sString,  p_bLf, p_iColor=nil)
        s = f__sprint(p_sString,p_iColor)
        if (p_bLf)
            s = s.to_s + "\n"
        end
        print s
    end # f~~print

    def f__writeF( p_sText, p_sMode, p_sFile )
        if ( (p_sFile==nil)||(p_sMode==nil)||(p_sText==nil) \
             || (p_sFile.length==0)||(p_sMode.length==0)||(p_sText.length==0) )
            return false
        end
        begin
            sLoc    = sprintf("File<%s>:Mode:<%s>:Text:<%s>",p_sFile,p_sMode,p_sText)
            $Fp     = File.open(p_sFile,p_sMode)
            $Fp.write(p_sText)
            $Fp.close
            rescue Errno::ENOENT => e   #Module Errno, Metod:ENOENT
                sEc  = sprintf("?ERR(NOE):%s:!",sLoc)
                f__print(sEc,true,C_COLOR_RED)
                return false
            rescue StandardError => e
                sEc  = sprintf("?ERR(STD):%s:!",sLoc)
                f__print(sEc,true,C_COLOR_RED)
                return false
        end
        return true
    end # f~~writeF

    def f__putf( p_sText, p_bNL = true, p_sMode="a+" )
        if ( (p_sText== nil) || (p_sText.empty?) )
            return false
        end
        s = p_sText
        if (p_bNL == true)
            s = s.to_s + "\n"
        end
        if ( ($sLogFile == nil) || ($sLogFile.empty?) || (!File.exists?($sLogFile.to_s)) )
            return false
        end
        return f__writeF(s,p_sMode,$sLogFile)
    end # f~~putf

    def f__arg()
        if ((ARGV.empty? == false)  \
                and (ARGV.length>0) \
                and (ARGV[0].length == 12) )   # YYMMDDhhmmss
            #   Es soll m?glich sein,
            #   ein LogFile mit Datum vorzugeben,
            #   ohne dass dieses von der RubyLib generiert wird.
            #   Das LogFile wird benannt durch:
            #       "<scriptName>.<externalDateTimeStr>.log" !CRQ-190923:DtSep
            #
            #   check valid 12 digits
            #   Bsp: IN: ruby <script> "123456789012" => date is: "123456789012"
            sRegExpr    = '[0-9]{12}'     # 12 numbers
            a           = ARGV[0].scan(/#{sRegExpr}/)   # result array !
            if (a.length == 0)       # a.length==1
                return false
            end
            s = a.to_s  # convert <"[123456789012]"> into sub-string
            if (s==nil)
                return false
            end
            l = s.length
            f__inf("<#{s}>.length = #{l}")
            if (s.length < 4)       # 12+2+2
                return false
            end
            s = s[2..-3]
            f__inf("sNow1:<#{s}>")
            # cut '['
            if (s.length != 12)       # 12
                return false
            end
            f__inf("sNow2:#{s}")
            return true,s
        end
    end # f~~arg

    def f__trc( p_sFile, p_iLine, p_sMethod, p_sText="!", p_bVerbose=C_LIB_VERBOSE)
        (p_sFile==nil)  ?   sFile='?F' : sFile=File.basename(p_sFile)
        (p_iLine<0)     ?   sLine='?L' : sLine="#{p_iLine}"
        (p_sMethod==nil)?   sMeth='?M' : sMeth=p_sMethod
        (p_sText==nil)?     sText=''   : sText=p_sText
        s       = f__sTab('<') + "trc:#{sFile};#{sLine};#{sMeth};#{sText}"
        if (p_bVerbose)
            f__print(s,true,C_COLOR_MAGENTA)
        end
        return s
    end # f~~trc

    def f__inf(p_sText,p_bVerbose=C_LIB_VERBOSE)
        s=p_sText
        if (p_bVerbose)
            f__print(s,true,C_COLOR_YELLOW)
        end
    end # f~~inf

    def f__sLocation( p_sText,p_sFile=nil,p_iLine=nil,p_sMethod=nil )
        s   = p_sText
        if (p_sFile != nil || p_iLine != nil || p_sMethod !=nil)
            s = s.to_s + ":["
            if (p_sFile != nil)
                sFile=File.basename(p_sFile)
                s = s.to_s + "#{sFile.to_s}"
            end
            if (p_iLine != nil)
                s = s.to_s + ";#{p_iLine.to_s}"
            end
            if (p_sMethod != nil)
                s = s.to_s + ";#{p_sMethod.to_s}"
            end
           s = s.to_s + "]"
        end
        return s
    end # f~~sLocation

    def f__errorHandler( p_iEc, p_sText, p_sFile=nil,p_iLine=nil,p_sMethod=nil )
        #   DES:    shows error-warnings-exits
        #   INp:    Error or Warning or Exit
        #   INp:    File,Line,Method
        bExit=false
        if (p_iEc == 0)
            cId='?'
            sId='WRN'
            iColor=C_COLOR_YELLOW
            bPrint=@@bWarning
        elsif (p_iEc == -1)
            cId='!'
            sId='ERR'
            iColor=C_COLOR_RED
            bPrint=true
        elsif (p_iEc == -2)
            cId='!'
            sId='EXT'
            iColor=C_COLOR_CYAN
            bPrint=true
            bExit=true
        elsif (p_iEc == -3)
            cId='!'
            sId='BUG'
            iColor=C_COLOR_RED
            bPrint=true
            bExit=true
        end
        s = f__sTab(cId) + "#{sId}:'#{p_sText}'"
        s = f__sLocation(s,p_sFile,p_iLine,p_sMethod)
        if (bPrint)
            f__puts(s,iColor)
        end
        f__putf(s)
        if (bExit)
            exit(-p_iLine)
        end
    end # f~~errorHandler

public

    def f_colorTest()
        8.times do|x|   # 0...7
          sLine =    f__color_value(x + 1)     # 1.Spalte
          sLine +=   f__color_value(x + 30)    # 2.Spalte
          sLine +=   f__color_value(x + 90)    # 3.Spalte
          sLine +=   f__color_value(x + 40)    # 4.Spalte
          sLine +=   f__color_value(x + 100)   # 5.Spalte
          f_puts(sLine)
        end
    end

    def f_sHello()
        puts "Hello by CTutor"
    end

    def f_dtNow()
        return Time.now
    end # f~dtNow

    def f_sNow(p_sFmt=C_DT_TUTOR_STR)
        return f_dtNow().strftime(p_sFmt)
    end # f~sNow

    def f_sOs()
        return RbConfig::CONFIG['host_os']  # show os-Modules
    end # f~sOs

    def f_showVersion()
        sFileTime = File.mtime(__FILE__)
        s = f__sTab('&') + "SCRIPT=::<"          + sFileTime.to_s + ">"
        f__print(s,true,C_COLOR_BLUE)
        s = f__sTab('&') + "RUBY_VERSION=::<"    + RUBY_VERSION.to_s + ">"
        sOs=f_sOs()
        s = s + ";OS=::<#{sOs}>"
        f__print(s,true,C_COLOR_BLUE)
    end # f~version

    def f_sDir( p_sFilePath )
        sDir=File.dirname(p_sFilePath)
        #   puts "Dir:#{sDir}"
        if (!Dir.exists?(sDir))
            return false,sDir
        end
        return true,sDir
    end # f~sDir

    def f_sFileBase_withoutExt( p_sFile )
        sRc = File.basename(p_sFile,".*")  # name excl extension
        return(sRc)
    end # f~sFileBase_withoutExt

    def f_sFilePath( p_sDir, p_sFileBase, p_bExt=true )
        sFile = p_sFileBase
        if (p_bExt==false)
            sFile = f_sFileBase_withoutExt(sFile)
        end
        sPath = p_sDir.to_s + C_DIR_SEPARATOR + sFile.to_s
        #   sPath = sPath.to_s.gsub('\\','/')
        return sPath
    end # ~sFilePath

    def f_bsFilePath_split( p_sFilePath )
        # IN: x:\TEMP\test.rb
        sDir        =   File.dirname(p_sFilePath).to_s.gsub('\\','/')   # x:/TEMP
        sBase       =   File.basename(p_sFilePath,".*")     #   "test"
        sExt        =   File.extname(p_sFilePath)           #   ".rb"
        return true,sDir,sBase,sExt
    end # ~bsFilePath_split

    def f_sTextFile( p_sFile, p_sFileAdd=nil, p_sExt='txt' )
        s   = f_sFileBase_withoutExt(p_sFile)
        s   = s + p_sFileAdd.to_s
        sRc = s.to_s + '.' + p_sExt.to_s
        return(sRc)
    end # f~sTextFile

    def f_sLogFile( p_sDir = nil, p_sFile = nil, p_sDateTime = nil )
        f__trc(__FILE__,__LINE__,__method__,nil)
        if (p_sDateTime==nil)
            sDt       = nil
        else
            sDt       = C_LOG_DATETIME_SEP.to_s + p_sDateTime.to_s     # !CRQ-190923
        end
        if (p_sFile==nil)
            sFile       = __FILE__
        else
            sFile       = p_sFile
        end
        if (p_sDir==nil)
            if (C_DIR_TMP == nil)
                return #!CRQ-180104:check
            end
            sDir    = C_DIR_TMP
        else
            sDir    = p_sDir
        end
        s           = f_sTextFile(sFile, sDt, 'log')
        s           = f_sFilePath(sDir,s)
        f__trc(__FILE__,__LINE__,__method__,"END")
        return s
    end # f~sLogFile

    def f_logging(p_sFile=__FILE__,p_sId=nil)
        f__trc(__FILE__,__LINE__,__method__)
        if ((p_sId != nil) and (p_sId.length>0))
            f__trc(__FILE__,__LINE__,__method__,"File:<#{p_sFile}> ; Id:<#{p_sId}")
        end
        if (C_DIR_TMP == nil)
            return false    #!CRQ-180104:check
        end
        $sLogFile = f_sLogFile(nil,p_sFile,p_sMethod=p_sId)
        f__trc(__FILE__,__LINE__,__method__,"LogFile used: <#{$sLogFile}>")
        sNow    = f_sNow()
        s       = f__sTab('#') + "FILE:<#{p_sFile}> NOW:<#{sNow}>"
        bFileExists = File.file?($sLogFile)
        if (bFileExists == true)
            f__trc(__FILE__,__LINE__,__method__,"fileAppend")
            s   = s + " DO:'append'"
            bRc = f__writeF( s + "\n", "a+", $sLogFile )
        else
            f__trc(__FILE__,__LINE__,__method__,"fileCreate")
            s   = s + " DO:'create'"
            bRc = f__writeF( s + "\n", "w+", $sLogFile )
        end
        #   TRUE:append/create
        if (!bRc)
            return false
        end
        $bLogFile = true
        return true
    end # f~logging

    def f_putf(p_sText,p_bNL=true)
        s = p_sText
        return f__putf( s, p_bNL )
    end # f~putf

    # universal function
    def f_put(p_sText,p_bTextNL = false, p_bFileNL = false, p_bColor = false)
        s = p_sText
        iColor=C_COLOR_WHITE
        if (p_bColor)
            iColor = C_COLOR_YELLOW
        end
        f__print(s,p_bTextNL,C_COLOR_YELLOW)
        f__putf(p_sText,p_bFileNL)
    end # f~put

    def f_puts(p_sText,m_bColored=false)
        if (p_sText==nil)
            puts '?puts'
            return
        end
        s = p_sText
        if (m_bColored)
            f__print(s,true,C_COLOR_CYAN)
        else
            puts s
        end
        f_putf(p_sText)  # with NL
    end # f~puts

    def f_putA(pA,p_bNL=false)  # !CRQ-210214:showArray with NL
        s = "MyLib.F_putA"
        if ( pA.count >= 1 )
            s = nil
            v = pA
            n = pA.count
            v.each_index { |i|
                t = "A[#{i}]=#{v[i]}"
                if (p_bNL)
                    s = s.to_s + f__sTab('-') + t.to_s + "\n"
                else
                    s = s.to_s + t.to_s
                    if (i>0&&i<n)
                        s = s.to_s + ";"
                    end
                end
            } # eachIndex
            #   only for files
            #   puts ARGF.readlines
        end
        f_inf(s)
    end # f~putA

    def f_putH(p_Hsh,p_cSep="\n")
        if (p_Hsh==nil)
            return false
        end
        i=0; n=p_Hsh.size
        r=/[[:print:]]/; (p_cSep=~r) ? s='':s=p_cSep  # no Sep if printable
        p_Hsh.each { |k,v|
            if (i>0&&i<n)
                s=s.to_s + p_cSep
            end
            s =  s.to_s + "H[#{i}]:#{k}=>#{v}"
            i+=1
        }
        f_inf(s)
    end # f~putH

    def f_print(p_sText)
        print p_sText
        f_putf(p_sText,false)   # with noNL
    end # f~print

    def f_sprint(p_sText,p_iColor)      # external function
        s=f__sprint(p_sText,p_iColor) # returns colored or not
        return s
    end # f~sprint

    #   the normal trace function
    def f_trace( p_sFile, p_sLine, p_sMethod, p_sText=nil, p_bVerbose=nil)
        #   IN: f_trc( p_sFile, p_sLine, p_sMethod, p_sText) => use $bVb
        #   IN: f_trc( p_sFile, p_sLine, p_sMethod, p_sText,false) => no output
        #   IN: f_trc( p_sFile, p_sLine, p_sMethod, p_sText,true)  => output
        if (p_bVerbose==nil)
            bVerbose = @@bVerbose
        else
            bVerbose = p_bVerbose
        end
        #   puts "vb:#{bVerbose}"
        if (bVerbose==false)
            return
        end
        s = f__trc( p_sFile, p_sLine, p_sMethod, p_sText, false )
        f__putf(s) # file only
        if (bVerbose)
            #   puts s !CRQ-180606
            f__print(s,true,C_COLOR_MAGENTA) #   don't use 'f~~trc' for output
        end
    end #f~trc

    alias f_trc f_trace

    def f_info(p_sText,p_iColor=C_COLOR_YELLOW,p_bLf=true,p_bVerbose=nil)
        if (p_bVerbose==nil)
            bVerbose = @@bVerbose    # use global definition
        else
            bVerbose = p_bVerbose   # use local one
        end
        if (bVerbose==false)
            return
        end
        #   convert into a string
        if (!(p_sText.is_a? (String)))
           p_sText=p_sText.to_s
           #    exit
        end
        s=''
        if ( !p_sText.include?('?:') && (p_sText.size>2))
            s = f__sTab('<')    # no '<' for small text or if "?:"
        end
        s = s + p_sText
        f__print(s,p_bLf,p_iColor)
        f__putf(s,p_bLf) # take LF
    end # f~inf

    alias f_inf f_info

    def f_warning( p_sText, p_sFile=nil,p_iLine=nil,p_sMethod=nil )
        f__errorHandler(0,p_sText,p_sFile,p_iLine,p_sMethod)
    end # f~warning

    def f_error( p_sText, p_sFile=nil,p_iLine=nil,p_sMethod=nil )
        f__errorHandler(-1,p_sText,p_sFile,p_iLine,p_sMethod)
    end # f~error

    def f_exit( p_sText, p_sFile=nil,p_iLine=nil,p_sMethod=nil )
        f__errorHandler(-2, p_sText,p_sFile,p_iLine,p_sMethod)
    end # f~exit

    def f_bug( p_sText, p_sFile=nil,p_iLine=nil,p_sMethod=nil )
        f__errorHandler(-3,p_sText,p_sFile,p_iLine,p_sMethod)
    end # f~bug

    def f_cls()
        system('cls')
    end # f~cls

    def f_hdr(p_sHeader,p_sFile=__FILE__,p_bColor=false)
        if (p_bColor==true)
            @@bColor = true
        end
        # second arguments is logFile dateTime like "YYMMDDHHmmss"
        sLogFileDate=nil
        bLogFileDate,sLogFileDate=f__arg()
        if (bLogFileDate) then
            s = "fHdr::logFileDate:<#{sLogFileDate}>,sFile:<#{p_sFile}>"
            f__inf(s)
        else
            sLogFileDate = f_sNow() #  <2018-05-26;17:19:11:548"
        end
        bRc = f_logging(p_sFile,sLogFileDate)
        @sProgName  = p_sHeader
        #   exit(11)
        s   = f__sTab('>') + "BEGIN of PROGRAM   : [ " + @sProgName.to_s + " ]"
        f__print(s,true,C_COLOR_GREEN)
        f__putf(s)
        $dtDateTime = f_dtNow() #save it
        f_showRubyVersion();
    end # f~hdr

    def f_end(p_iExitCode=@@iExitCode)
        if ($bLogFile) then
            s = f__sTab('-') + "LogFile:<#{$sLogFile}>"
            f__print(s,true,C_COLOR_BLUE)
        end
        dt  = f_dtNow()
        x   = dt-$dtDateTime
        s   = f__sTab('<') + "END of PROGRAM     : [ " + @sProgName.to_s + " ] "
        s   = sprintf("%s; now!:<%s>; usedTime:<%02.2d> seconds.",s,f_sNow(),x)
        # if (@@bVerbose == true) * doItalways
            f__print(s,true,C_COLOR_GREEN)
        # end
        f__putf(s)
        exit(p_iExitCode)
    end # f~end

    def f_doc(p_sThm,p_sHdr,p_sTxt)
        iTab = 3
        s = f__sTab('<') + p_sThm.to_s
        sThm = s
        f__print(sThm,false,C_COLOR_GREEN)
        f__print(' ',true)
        puts  p_sTxt
        f__putf(sThm.to_s + p_sHdr.to_s + p_sTxt.to_s)
    end # f~thm

    def f_thm(p_sTxt,p_bSub=false,p_iLine=-1,p_bVerbose=nil)
        bVerbose=true
#       if (p_bVerbose==nil)
#           bVerbose=@@bVerbose
#       else
#           bVerbose=p_bVerbose
#       end
        iTab = 3
        if (p_bSub) then
            @@iThmCtr += 1
            s = f__sTab('+',iTab,true)
            s = s + "[" + @@iThmCtr.to_s + "] : "
        else
            s = f__sTab('<') + "Topic : "
            @@iThmCtr=0
        end
        s = s + p_sTxt
        if (p_bSub && (p_iLine>0)) then
            s = s + ' #{' + p_iLine.to_s + '}'
        end
        if (bVerbose)
            f__print(s,true,C_COLOR_GREEN)
        end
        f__putf(s)
    end # f~thm

    def f_exc(p_sTxt,p_sEc,p_iLine=-1)
        s   = f__sTab('?') + p_sTxt.to_s + "<at:#{p_iLine}>:\"" + p_sEc.to_s + "\""
        f__print(s,true,C_COLOR_RED)
    end

    def f_showRubyVersion()
        s  = f__sTab(' ')     + sprintf("file:<%s>;acc:<%s>\n",__FILE__,File.mtime(__FILE__))
        s  = s + f__sTab(' ') + sprintf("ruby:version:<%s>",RUBY_VERSION.to_s)
        s  = s + f__sTab(' ') + sprintf("\tos:<%s>",f_sOs)
        s  = s + f__sTab(' ') + sprintf("\tnow:<%s>",f_sNow())
        if (@@bVerbose == true)
            f__print(s,true,C_COLOR_BLUE)
        end
        f__putf(s)
    end #f~showRubyVersion

    def f_showRubyConstants()
        s = f__sTab('>') + "RUBY_CONSTANTS\n"
        s = s + "\tRUBY_COPYRIGHT    =:: <" + RUBY_COPYRIGHT.to_s + ">\n"
        s = s + "\tRUBY_DESCRIPTION  =:: <" + RUBY_DESCRIPTION.to_s + ">\n"
        s = s + "\tRUBY_ENGINE       =:: <" + RUBY_ENGINE.to_s + ">\n"
        s = s + "\tRUBY_PATCHLEVEL   =:: <" + RUBY_PATCHLEVEL.to_s + ">\n"
        s = s + "\tRUBY_PLATFORM     =:: <" + RUBY_PLATFORM.to_s + ">\n"
        s = s + "\tRUBY_RELEASE_DATE =:: <" + RUBY_RELEASE_DATE.to_s + ">\n"
        s = s + "\tRUBY_REVISION     =:: <" + RUBY_REVISION.to_s + ">\n"
        s = s + "\tRUBY_VERSION      =:: <" + RUBY_VERSION.to_s + ">\n"
        s = s + f__sTab('<') + "end."
        f__print(s,true,C_COLOR_MAGENTA)
        f__putf(s)
    end #f~showRubyConstants

    def f_showPreProcessorVariables(p_sFile,p_sLine,p_sMeth,p_sId)
        s = f__sTab('>') + "RUBY_PreProcVariables\n"
        s = s + "\t__FILE__     =:: <"      + p_sFile.to_s + ">\n"
        s = s + "\t__LINE__     =:: <"      + p_sLine.to_s + ">\n"
        s = s + "\t__method__   =:: <"      + p_sMeth.to_s + ">\n"
        s = s + "\t__id__       =:: <"      + p_sId.to_s + ">\n"
        s = s + f__sTab('<') + "end."
        f__print(s,true,C_COLOR_MAGENTA)
        f__putf(s)
    end # f~showPreProcessorVariables

    #   === environment

    def f_exitCode(p_iExitCode=nil)
        #   DES:    set internal ExitCode
        #   Inp:    <p_iExitCode> or <>
        #   <p_iExitCode> => set(ExitCode) or <(nil)>=>get(ExitCode)
        if ((p_iExitCode!=nil) && (p_iExitCode.is_a? Integer))
            @@iExitCode=p_iExitCode
        end
        return @@iExitCode
    end # f~exitCode

    def f_colorSet(p_bColor=nil)
        if (!C_STR_COLORED)
            return false
        end
        if (p_bColor == nil)
            return @@bColor
        end
        @@bColor = true
    end # f~~colorSet

    def f_optionSet(p_hOpts)
        if (p_hOpts[:mVerbose]!=nil)
            @@bVerbose  = p_hOpts[:mVerbose]
        end
        if (p_hOpts[:mWarning]!=nil)
            @@bWarning  = p_hOpts[:mWarning]
        end
        if (p_hOpts[:mColor]!=nil)
            @@bColor    = p_hOpts[:mColor]
        end
    end

    def f_optionGet(p_bShow=false)
        s = "Options<Vb:#{@@bVerbose},Cl:#{@@bColor},Wn:#{@@bWarning}>"
        if (p_bShow)
            f__print(s,true,C_COLOR_GREEN)
        else
            puts s
        end
    end

    def f_os_bIsUnix(p_bShow=false)  #!CRQ-190821
        bUnix=false
        bWindows=false
        bOs=false
        s=RUBY_PLATFORM
        case s.to_s
        when "x86_64-linux-gnu"
            bUnix=true
        when "x64-mingw32"
            bWindows=true
        else
            bOs=true
        end
        if (p_bShow)
            f__print("platform:='#{s}'",true,C_COLOR_GREEN)
        end
        return bUnix
    end

end # CTutor

#   ===========================================================================
#   !MOD:use
#   ===========================================================================

module MTutor
    $bLogFile = false
    $m  = CTutor.new()
end
include MTutor