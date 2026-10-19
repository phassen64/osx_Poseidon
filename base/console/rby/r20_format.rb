=begin
    Data Formats
    +   Zip
    +   JSon
    +   XML
    +   ProtoBuffer
=end
#!$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

#   header
require_relative "TUT.inc"
$m.f_hdr("Data Formats",__FILE__)
bBug=true

#   $m.f_showRubyConstants
bOsUnix=$m.f_os_bIsUnix(true)
if (bBug)
    if (bOsUnix) then
        puts "--- OS:=<UNIX>"
    else
        puts "--- OS:=<not UNIX>"
    end
end

#   regulaer expressions
sRexScp=File.basename(__FILE__)
sRexFid=sRexScp.slice(0..2) + '_*.rb'
sRexSrc=sRexScp.slice(0) + '??_*.rb'
if (bBug)
    puts "<<< sScp:<#{sRexScp}>"
    puts "<<< sFid:<#{sRexFid}>"
    puts "<<< sSrc:<#{sRexSrc}>"
    #   return 1
end

#   save current dir
sHomeDir=Dir.pwd

#   set zipdir
if (bOsUnix)
    sZipDir= ENV['HOME']
else
    sZipDir= ENV['TMP']
end

#   === !THM:   Zip
require 'zip'
$m.f_thm("Zip")
$m.f_thm("Zip",true,__LINE__)

#   define a zip class
require 'fileutils'
class CFileNames
    def f_sDir(p_sDir)
        # substitue DOS to UNIX dirname
        if (p_sDir==nil)
            $m.f_exit("?Dir==0",__FILE__,__LINE__,__method__)
        end
        return p_sDir.to_s.gsub('\\','/')
    end
    def f_sFilePath(p_sDir,p_sFile=nil)
        # IN:dirName, OUT:UNIX-filePath
        if (p_sDir==nil)
            $m.f_exit("?Dir==0",__FILE__,__LINE__,__method__)
        end
        if (p_sFile==nil)
            sFilePath=p_sDir
            return sFilePath.to_s.gsub('\\','/')
        else
            return f_sDir(p_sDir) + '/' + p_sFile.to_s
        end
    end
end

class CZip < CFileNames

    def f_mov(p_sSrcDir,p_sObjDir,p_sFile)
        #   move a file
        if ( p_sSrcDir==nil || p_sObjDir==nil)
            $m.f_exit("?srcDir||?objDir==0",__FILE__,__LINE__,__method__)
        end
        sSrc=f_sFilePath(p_sSrcDir,p_sFile)
        sObj=f_sFilePath(p_sObjDir,p_sFile)
        #   puts sObj
        FileUtils.mv(sSrc,sObj) # move to objDir
    end
    def f_del(p_sDir,p_sFile)
        #   delete a file
        if ( p_sDir==nil || p_sFile==nil)
            $m.f_exit("?Dir||File==0",__FILE__,__LINE__,__method__)
        end
        sPwd=Dir.pwd
        Dir.chdir(p_sDir)
        File.delete(p_sFile) if File.exist?(p_sFile)
        Dir.chdir(sPwd)
    end
    def f_add(p_sSrcDir,p_sSrcFilePattern,p_sObjDir,p_sObjZip)
        #   add a file(pattern) into zip archive, with is saved at obj
        if ( p_sSrcDir==nil )
            $m.f_exit("?srcDir",__FILE__,__LINE__,__method__)
        elsif ( p_sSrcFilePattern==nil  )
            $m.f_exit("?pattern",__FILE__,__LINE__,__method__)
        elsif ( p_sObjDir==nil )
            $m.f_exit("?objDir",__FILE__,__LINE__,__method__)
        end
        f_del(p_sSrcDir,p_sObjZip)
        f_del(p_sObjDir,p_sObjZip)
        Dir.chdir(p_sSrcDir)
        aDir = Dir.glob(p_sSrcFilePattern)
        #   puts aDir
        Zip::File.open(p_sObjZip, Zip::File::CREATE) { |xZip|
            aDir.each { |xFile|
                xZip.add(xFile,xFile)     # add(logName,phyName)
            }
        }
        f_mov(p_sSrcDir,p_sObjDir,p_sObjZip)
    end
    def f_get(p_sFileEntry,p_sDir,p_sZip)
        if ( p_sDir==nil || p_sZip==nil )
            $m.f_exit("?Dir||?Zip",__FILE__,__LINE__,__method__)
        elsif ( p_sFileEntry==nil  )
            $m.f_exit("?fileEntry",__FILE__,__LINE__,__method__)
        end
        sPwd=Dir.pwd
        aDir = Dir.glob(p_sFileEntry)
        Dir.chdir(p_sDir)
        Zip::File.open(p_sZip) { |xZip|
            aDir.each { |xFile|
                xZip.each_with_index { |xEntry,i|
                    puts "try #{xEntry} == #{xFile}?"
                    if (xEntry.to_s.include? xFile)
                        puts "found #{xFile} at pos:#{i}"
                        return i,xFile
                        break
                    end
                }
            }
        #   get a file of a zip content
        }
        Dir.chdir(sPwd)
    end
end

Dir.chdir(sHomeDir)
sNow=$m.f_sNow('%y%m%d%H%M')

#   create zipfile
sZipFile='tutor-' + sNow.to_s + '.zip'
p=CZip.new
$m.f_puts "<<< * zip.CREATED:<#{sZipFile}> zipDir:='#{sZipDir}'"

#   add into zip file
p.f_add('.',sRexSrc,sZipDir,sZipFile)
$m.f_puts "<<< * zip.ADD of:=#{sZipFile}"

#   get data from zip file
iPos,sFile=p.f_get(sRexFid,sZipDir,sZipFile)
$m.f_puts "<<< * zip.GET of:<#{sFile}> at POS:<#{iPos}>"

#
#   === !THM:   JSon    https://www.json.org/
#

$m.f_thm("JSon")
require 'json'              #   jSon parsing

Dir.chdir(sHomeDir)
aFile = %w[ colors.json ]   #   define string-array

#   parse
$m.f_thm("JSON.parse",true,__LINE__)
aFile.each_with_index { |x,i|
    $m.f_puts "x[#{i}]:<#{x}>"
    xRc = File.read(x)      # read file completely, without to open
    pJSon = JSON.parse(xRc)   # JSon=>a[h1,h2,...]
    $m.f_puts "jRc:=<#{pJSon}>"
    aColor = pJSon["colors"]
    aColor.each_with_index {|y,j|
        $m.f_puts "aColor[#{j}]:=<#{y}>"
        $m.f_putH(y,"\n")
    }
}

#
#   === !THM:   XML
#

$m.f_thm("XML")
# require 'nokogiri'        #   XML parsing library 2018
require 'rexml'
require 'rexml/streamlistener'
require 'rexml/document'
include REXML

sFile = 'book.xml'
aFile = %w[ book.xml ]      #   define string-array
puts "aFile:<#{aFile}>"

class CListener
  include REXML::StreamListener
  def tag_start(*args)
#   puts "tag_start: #{args.map {|x| x.inspect}.join(', ')}"
    puts "tag_start: #{args.map {|x| x.inspect}.join(',')}"
  end
end

#   01
$m.f_thm("with classes",true)
pList   = CListener.new
pFile   = File.open(sFile)
Document.parse_stream(pFile, pList)

#   02
$m.f_thm("parse",true,__LINE__)
pFile   =   File.new('book.xml')
pXml    =   Document.new(pFile)
pDoc    =   pXml.root
#   puts "Root element :[#{pTxt}];"
pDoc.elements.each_with_index { |x,i|
    puts "x[#{i}]:...\n#{x};"
}
puts "\n"

sKey="pXML.root.name"
$m.f_thm(sKey,true,__LINE__)
p =   pDoc.name
$m.f_puts "#{sKey}:<'" << p << "'>"

$m.f_thm("BOOK.category",true,__LINE__)
pFile       = File.new("book.xml")
pDoc        = Document.new(pFile)
pDoc.elements.each("bookstore/book") { |x|
    puts x.attributes["category"]
}

$m.f_thm("XPath::BOOK.author",true,__LINE__)
a = XPath.match( pDoc, "//author" )
puts a

$m.f_thm("XPath::BOOK.title",true,__LINE__)
a = XPath.match( pDoc, "//title" )
puts a

$m.f_thm("XPath::BOOK.year",true,__LINE__)
a = XPath.match( pDoc, "//year" )
a = a.uniq
b=[]
puts a  # not removed doubles
a.each_with_index { |x,i|
    puts "xYear[#{i}]='#{x}'"
    b.push x
}
b.uniq!
x=a.class ; $m.f_inf "y.class:= #{x}:!",C_COLOR_CYAN     # String

$m.f_thm("HEALTH",true,__LINE__)
pFile       = File.new("health.xml")
pDoc        = Document.new(pFile)
pDoc.elements.each("inventory/section") { |x|
    puts x.attributes["name"]
}

$m.f_thm("XPath::HEALTH.name",true,__LINE__)
aName = XPath.match( pDoc, "//name" )
puts aName

=begin
http://www.germane-software.com/software/rexml/docs/tutorial.html
=end

#
#   === !THM:   ProtoBuffer
#
# binary file format
$m.f_thm("ProtoBuffer")
#   require 'ruby_protocol_buffers'     # !CRQ-220707
$m.f_thm("ProtoBuffer",true,__LINE__)

$m.f_end()
