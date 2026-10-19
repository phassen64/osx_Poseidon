=begin
    THM:class
    +   definiton
    +   use constructor
    +   inheritance '<'
        : a class derives from another
    +   reflexion
        : a program knows it's structure and can modify it
        is_a?, kind_of?, respond_to?
    +   super , super()
    +   singletone class  with '<<'
    +   operator-overloading
    +   change object or class directly
        instance_variable_set,
        class_variable_set
    +   object-copy
        freeze,clone,dup, clone vs dup
    +   special : unFreeze
    +   creating objects specials
        initialize_copy, allocate
=end
#!$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

require_relative    "TUT.inc"     #<= require the file
$m.f_hdr("class",__FILE__)

#   HEADER
$m.f_thm("class overview")
s = <<HDR
    +   key:   class, super
    +   methods:
            is_a? kind_of?, respond_to?
            clone dup
            freeze, frozen?
            instance_variable_set, class_variable_set
    +   initialize
    +   inheritance, reflexion
    +   super, singletone-class, properties
    +   operator-overloading
    +   specials
HDR
$m.f_put(s)

#
#   === code
#

#   ----------------------------------------------------------------------------
#   THM: define
#   ----------------------------------------------------------------------------

$m.f_thm("define class")

#   define a simple class
$m.f_thm("output only",true)
class CCar
    def fSet(p_sCol)
        @vColor = p_sCol
    end
    def fOut
        $m.f_puts "myClass:{<'" + self.class.to_s +
            "'>} and myColor:'<#{@vColor}>'"
    end
end
x = CCar.new
x.fSet('pink')
x.fOut  #   <<< myClass :<'CCar'> and myColor:<''> # color not defined

#   define a class methods with 'self'
$m.f_thm("class ('self') methods",true)
class CCar_out
    @vColor = 'red' # class variable
    def self.fOut   # class-method 'fOut' is linked to a class and not not an object
        $m.f_puts "myClass:{<'" + self.class.to_s + "'>} and myColor:'<#{@vColor}>'"
    end
end
#   call class method without any object
CCar_out.fOut # => myClass:{<'Class'>} and myColor:'<red>'

#   ----------------------------------------------------------------------------
#   THM: constructor
#   ----------------------------------------------------------------------------

$m.f_thm("constructor")


#   init variable by calling
$m.f_thm("...default",true)
class CCar
    def initialize              # Ruby Constructor
        @vColor = 'red'         #   object-variable init
    end
    def fOut
        $m.f_puts "myClass:{<'#{self.class.to_s}'>} and myColor:'<#{@vColor}>'"
    end
end
x = CCar.new
x.fOut  #   <<< myClass :<'CCar'> and myColor:<'red'>

#   init variable by function
$m.f_thm("...with parameter",true)
class CCar1 # !RBY: not allowd CCar
    def initialize(p_sCol)
        @vColor = p_sCol
    end
    def fOut
        $m.f_puts "myClass:{<'#{self.class.to_s}'>} and myColor:'<#{@vColor}>'"
    end
end
x = CCar1.new('maroon')
x.fOut  #   <<< myClass :<'CCar'> and myColor:<'maroon'>

$m.f_thm("...multiple constructors",true)
class CCMul
    def initialize(p_sVal,p_iVal)       # standard-constructor
        @sVal = p_sVal
        @iVal = p_iVal
        @sCls = self.class.to_s
        @iObj = self.object_id
    end
    def self.f_init(p_iVal)             # helper-constructor
        new(__method__,__LINE__)
    end
    def fOut()
        $m.f_puts "OUT:[<#{@iObj};#{@sCls}]:<#{@sVal}><#{@iVal}>"
    end
end
x = CCMul.new('peter',__LINE__)
x.fOut  #   OUT:[<20484000;CCMul]:<peter><121>
x = CCMul.f_init(__LINE__)
x.fOut  #   OUT:[<20483400;CCMul]:<f_init><113>

$m.f_thm("extended version",true)
#   https://www.ruby-forum.com/topic/809975
class CCounter
    @iCtr = 0
    def initialize
        $m.f_trc(nil,__LINE__,__method__,"iCtr=<#{@iCtr}>") # <>
        self.class.fCtr += 1        # fCtr = (fCtr + 1)
        $m.f_trc(nil,__LINE__,__method__,"RET:iCtr=<#{@iCtr}>")
        @iCtr = self.class.fCtr     # copy clsCtr to objCtr
        $m.f_trc(nil,__LINE__,__method__,"EOF:iCtr=<#{@iCtr}>")
    end
    def self.fCtr
        $m.f_trc(nil,__LINE__,__method__,"iCtr=#{@iCtr}")
        @iCtr
    end
    def self.fCtr=(p_iVal)
        $m.f_trc(nil,__LINE__,__method__,"p_iVal=#{p_iVal}")
        @iCtr = p_iVal
    end
    def fOut(p_iLine)
        #   show objectId,objCtr,clsCtr
        $m.f_trc(nil,__LINE__,__method__,"OUTPUT")
        i =self.object_id
        p=p_iLine
        $m.f_inf "{#{p}}:ObjectId[#{i}]::#{@iCtr}/#{self.class.fCtr}"
    end
end
$m.f_inf("init","x",C_COLOR_CYAN)
x = CCounter.new
x.fOut(__LINE__) # object number 1 /  1
$m.f_inf("init","y",C_COLOR_CYAN)
y = CCounter.new
x.fOut(__LINE__) # object number 1 /  2
y.fOut(__LINE__) # object number 2 /  2
$m.f_inf("init","z",C_COLOR_CYAN)
z = CCounter.new
x.fOut(__LINE__) # object number 1 /  3
y.fOut(__LINE__) # object number 2 /  3
z.fOut(__LINE__) # object number 3 /  3

#   ----------------------------------------------------------------------------
#   THM: local/global/instance/class variables
#   ----------------------------------------------------------------------------

$m.f_thm("Ruby Variables(local,global,instance,class)")

$sVer = "init"                          # !VAR: global-variable
class CVar
    def initialize
        if not defined?(@@iCtr)
            @@iCtr=0                    # !VAR: class-variable
        end
        @@iCtr += 1
        @sCol   = 'white'               # !VAR: instance-variable
        @@sTmp = 'ready'
    end
    def fCol= p_sCol
        @sCol = p_sCol
    end
    def fCtr= p_iCtr
        @@iCtr = p_iCtr
    end
    def fOut
        #   called outside
        uCtr = @@iCtr                   # !VAR: local-variable
        $m.f_puts "OUT.o:{"   +
                ":lCtr=" + uCtr.to_s     + ';' +    # out:localVar==classVar
                ":cCtr=" + @@iCtr.to_s   + ';' +    # out:classVar
                ":oCol=" + @sCol.to_s    + ';' +    # out:objectVar
                "};"
        self.class.fOutCls # calls 'self.fOutput'
    end
    def self.fOutCls  # class method - not bound to an object
       $m.f_puts "OUT.c:{" +
                ":gVer="    + $sVer.to_s    + ';' + # out:globalVar
                ":cCtr="    + @@iCtr.to_s   + ';' + # out:classVar
                ":oCol="    + @sCol.to_s    + ';' + # out:objectVar # not works here
            "};"
    end
end

$m.f_thm("init",true,__LINE__)
x = CVar.new;
x.fOut
#   OUT.o:{:lCtr=1;:oCol=white;};
#   OUT.c:{:gVer=init;:cCtr=1;:oCol=;};

$m.f_thm("set",true,__LINE__)
x = CVar.new;
$sVer='SET'
x.fCol='red'
x.fCtr=3
x.fOut
#   OUT.o:{:lCtr=4;:oCol=red;};
#   OUT.c:{:gVer=SET;:cCtr=4;:oCol=;};

$m.f_thm("step",true,__LINE__)
x = CVar.new
$sVer='StepIt'
x.fOut
#   OUT.o:{:lCtr=4;:oCol=white;};
#   OUT.c:{:gVer=StepIt;:cCtr=4;:oCol=;};

#call class output function
$m.f_thm("out class fct",true,__LINE__)
z = CVar.new
CVar.fOutCls
#   OUT.c:{:gVer=SET;:cCtr=5;:oCol=;};

#
#   set directly variables of class or instance
#
$m.f_thm("set directly instance-variables and class-variables",true,__LINE__)
$sVer='DirectlySet'
z.instance_variable_set(:@sCol,'pink')
CVar.class_variable_set(:@@iCtr,4711)
z.fOut
#   OUT.o:{:lCtr=4711;:cCtr=4711;:oCol=pink;};
#   OUT.c:{:gVer=DirectlySet;:cCtr=4711;:oCol=;};

#   ----------------------------------------------------------------------------
#   THM: Properties ( getter/setter methods)
#   ----------------------------------------------------------------------------

#   properties - simple
$m.f_thm("Properties")

$m.f_thm("simple get+set properties",true)
class CCar
    def fGet
        return(@sCol)   # get object-variable
    end
    def fSet(p_sCol)
        @sCol = p_sCol  # set object-variable
    end
end
x = CCar.new                # create
x.fSet('Blue')                  # set attribute
sColor = x.fGet().to_s          # get (save and convert)
$m.f_puts "Color is :<'#{sColor}'>"     # => Color is :<'Blue'>

$m.f_thm("get+set with f= syntax",true)
class CCar
    def fGet
        return @sCol    # getter
    end
    def fSet= p_sCol
        @sCol = p_sCol  # settter object-variable
    end
end
x = CCar.new                # create
x.fSet='black'              # set attribute
$m.f_puts "Color is :<'#{x.fGet()}'>"     # => Color is :<'black'>

$m.f_thm("getter+setter with syntax:attr_<x>",true)
class CCar
    def initialize              # we don't need it
        @vColor = 'pink'
    end
    attr_accessor   :vColor     # read+write = getter(),setter()
    #   vColor is the same as '@vColor'
end # C~Car
x = CCar.new
$m.f_puts "Color is :<'#{x.vColor}'>"   # => Color is :<'pink'>
x.vColor = 'green'      # easy to write (set)
sColor   = x.vColor     # easy to read  (get)
$m.f_puts "Color is :<'#{sColor}'>"     # => Color is :<'green'>

$m.f_thm("complex example with properties",true)
class CCar
    def initialize
        @vColor = 'pink'
        @vSpeed = 100.1
        @vSize  = 2500
    end
    attr_accessor   :vColor     # (== @vColor)  :   read+write
    attr_writer     :vSpeed     # (== @vSpeed)  :   write-only, read with  fSpeed
    attr_reader     :vSize      # (== @vSize)   :   read-only,  write with fSize
    def fSpeed
        return @vSpeed
    end
    def fSize(pSize)
        @vSize = pSize
    end
    def fOut
        $m.f_puts "x::Color:<'#{@vColor}'>,Speed:<'#{@vSpeed}'>,Size:<'#{@vSize}'>"
    end
end
x = CCar.new
x.fOut          #   => "x::Color:<'pink'>,Speed:<'100.1'>,Size:<'2500'>"
#   --- acc io (writer+reader)
x.vColor = 'yellow' # easy to write (set)
s = x.vColor        # easy to read  (get)
$m.f_puts "Color is :<'#{s}'>"      # => Color is :<'yellow'>
#   --- acc writer
x.vSpeed    = 50.3  #   ok: write allowed
#   f = x.vSpeed    #   no read-access allowed with 'attr_write'
f = x.fSpeed        #   read by using a method
s = f.to_s
$m.f_puts "Speed is :<'#{s}'>"      # => Speed is :<'50.3'>
#   --- acc reader
#   x.vSize=1000    #   no write-access allowed with 'attr_reader'
x.fSize(1000)       #   write by using a method
i = x.vSize         #   OK: read allowed
s = i.to_s
$m.f_puts  "Size  is :<'#{s}'>"      # => Size is :<'1000'>

#   ----------------------------------------------------------------------------
#   THM: class inheritance
#   ----------------------------------------------------------------------------

$m.f_thm("class inheritance")
#   inheritance : Erbschaft
#   derive      : s. ableiten, erben

#   derive classes
$m.f_thm("derive",true)
class CCar
    protected
        def fClass
            $m.f_puts "hello class '#{self.class.to_s}'"
        end
    public
        def fOut
            fClass() # call proteced class
        end
end
#   CCarAudi inherits CCar
class CCarAudi < CCar
    public
        def fOut2
            $m.f_puts "fOut2!"
            fClass() # call proteced class
        end
end
x = CCar.new
x.fOut()    # => hello class 'CCar'
y = CCarAudi.new
y.fOut()        # => hello class 'CCarAudi'
y.fOut2()       # => "fOut2!" "hello class 'CCarAudi'"

#
#   === subTheme: reflection
#
$m.f_thm("reflexion",true,__LINE__)
#   <x>.is_a? <c>       : ? is object <x> defined by class <>
#   <x>.kind_of? <c>    : ? is object <x> defined by class <>
#   <x>respond_to? <m>  : ? has object <x> method <m>
bRc=(x.is_a? CCar); $m.f_puts "x.is_a? CCar : <#{bRc}>"   # true
bRc=(y.kind_of? CCar); $m.f_puts "y.kind_of? CCar : <#{bRc}>"   # true
bRc=(y.kind_of? CCarAudi); $m.f_puts "y.kind_of? CCarAudi : <#{bRc}>" # true
bRc=(y.respond_to? "fSecret");  $m.f_puts "y.respond_to? fSecret : <#{bRc}>" # false
bRc=(y.respond_to? "fInfo"); $m.f_puts "y.respond_to? fInfo : <#{bRc}>" # true

#
#   === subTheme: super
#

#   call a in an object of an derived class a same-name uppper-class method
$m.f_thm("super",true)
class CAnimal
    public
        def fOut
            $m.f_puts "ANIMAL class :<#{self.class}>"
        end
        def fOut2(p_sFile,p_iLine)
            $m.f_puts "ANIMAL code  :   <#{p_sFile}>;<#{p_iLine}>"
        end
end
class CCat < CAnimal
    public
        def fOut
            super   # use upper-class code
        end
        def fOut2(p_sFile,p_iLine)
            super(p_sFile,p_iLine)   # use upper-class code with parameters
        end
end
x = CCat.new
x.fOut  # ANIMAL class :<CCat>
x.fOut2(__FILE__,__LINE__)  # ANIMAL code  :   <t12_class.rb>;<233>

#   ----------------------------------------------------------------------------
#   THM: single-tone class
#   ----------------------------------------------------------------------------

$m.f_thm("singletone-class '<<'")

#   use operator '<<'
class String
    class << self
        def fValue(pX)
            "s1:"+ pX.to_s
        end
    end
end
x=42; s=String.fValue(x); $m.f_puts "String(<#{x}>) =>  <'#{s}'>"    # 42=>'s1:42'

#   or the same as ...
class String
    def self.fValue(pX)
        "s2:"+ pX.to_s
    end
end
x=11; s=String.fValue(x); $m.f_puts "String(<#{x}>) =>  <'#{s}'>"    # 11=>'s2:11'

#   or even shorter:
def String.fValue(pX)
    "s3:"+ pX.to_s
end
x=53; s=String.fValue(x); $m.f_puts "String(<#{x}>) =>  <'#{s}'>"    # 53=>'s2:53'

#   another '<<' example
sName='peter'       # sName is of the class String
class << sName
    def inspect     # overwrite string class method 'inspect'
         return "s4:Name!"
    end
end
s=sName.inspect; $m.f_puts "sName.inspect:#{s}"     #  => 's4:Name!'
sName='willi'; s=sName.inspect; $m.f_puts "sName.inspect:#{s}" # => 'willi'

#   ----------------------------------------------------------------------------
#   THM: Private, Protected, Public
#   ----------------------------------------------------------------------------

$m.f_thm("Private, Protected, Public")

class CCar
    def initialize      # Ruby Constructor
        @vColor = 'red'
    end
    attr_accessor   :vColor, :vSpeed
    private
        def fColor_prv
            return @vColor.to_s     # return string
        end
    protected :vSpeed
        def <=>(other_car)
            vSpeed <=> other_car.vSpeed
        end
    public
        def fShow
            return(fColor_prv);
        end
        def fUpdate
            @vColor = 'green'
        end
end
#   public
x = CCar.new
s = x.fShow
$m.f_puts "Color is now := [" + s + "]"

#   private, public
$m.f_thm("private vs public",true)
x = CCar.new
x.vColor = 'blue'
s = x.fShow
$m.f_puts "Color is now := [" + s + "]"
x.fUpdate
s = x.fShow
$m.f_puts "Color is any := [" + s + "]"   # ERROR

#   proteced example
$m.f_thm("protected",true)
x = CCar.new
x.vColor = 'blue'
x.vSpeed = 70.1
y= CCar.new
y.vColor = 'blue'
y.vSpeed = 70.1
puts (x == y)     # false
puts (x != y)     # true

#   ----------------------------------------------------------------------------
#   THM: operator OVERLOADING
#   ----------------------------------------------------------------------------

#   http://www.rubyinside.com/rubys-unary-operators-and-how-to-redefine-their-functionality-5610.html

$m.f_thm("operator overloading")

$m.f_thm("redefine ==(int)",true)
class COperator
    def initialize(pVal)
        @iNum = pVal
    end
    attr_reader :iNum   # defines @iNum
    def ==(pObject)
        # The operator '==' will be overload - 2.object is used
        $m.f_puts "01:@iNum:#{@iNum}"                  # show old value
        $m.f_puts "02:pObject.iNum:#{pObject.iNum}"    # show new-value
        n = @iNum.abs
        (n.equal? pObject.iNum.abs)
    end
end
x   = COperator.new(5)
y   = COperator.new(-5)
sRc = (x == y)
$m.f_puts "sRc: IS (x)==(y) ? : '#{sRc}'"

$m.f_thm("redefine @String",true)
#   http://www.rubyinside.com/rubys-unary-operators-and-how-to-redefine-their-functionality-5610.html
class CString < String
    def +@      # unary operator '+@'
        upcase
    end
    def -@      # '@' stopper
        downcase
    end
    def !
        swapcase
    end
    def ~
        reverse
    end
    #   difficult to find any else operator {'*','&','#','^','%','$'}
    def ^   # not works
        capitalize
    end
end
#   define - using new String class
sName   = CString.new("this is my String!")
#   define - use new String class
sRc = +sName; $m.f_puts "+('#{sName}'):upcase => '#{sRc}'"
sRc = -sName; $m.f_puts "-('#{sName}'):downcase  => '#{sRc}'"
sRc = !sName; $m.f_puts "!('#{sName}'):swapcase => '#{sRc}'"
sRc = ~sName; $m.f_puts "~('#{sName}'):reverse => '#{sRc}'"
=begin  syntax error
sRc = ^sName; $m.f_puts "*('#{sName}'):capitalize => '#{sRc}'"
=end
#   ----------------------------------------------------------------------------
#   THM: objects
#   ----------------------------------------------------------------------------

$m.f_thm("objects")

class CRabbit
    def initialize(p_sName)
        @sNam   =  p_sName
        @sCls   =  self.class.to_s
    end
    def fAge= p_iAge
        @iAge = p_iAge
    end
    def fNam= p_sNam
        @sNam = p_sNam
    end
    def fOut()
        $m.f_puts "Cls:<#{@sCls}>;Nam:<#{@sNam}>;Age:<#{@iAge}>"

    end
end

#
#   THM:freeze
#
$m.f_thm("freeze",true)
x = CRabbit.new('Harvey')
x.fAge=7
x.fOut # Nam:<Harvey>;Age:<10>
x.freeze
if (x.frozen?)
    $m.f_puts "OBJ(#{self.class.to_s}):isFrozen"
    #   This generates ax RunTime Error
    #   x.fAge=40 => RunTime Error
else
    $m.f_puts "OBJ:isNOTFrozen"
    x.fAge=10
end

#
#   THM:class unfreeze
#
require 'fiddle'    # for unFreeze
class CCat
    def initialize(p_sName)
        if not defined?(@@iCtr)
            @@iCtr=0
        end
        @@iCtr  += 1
        @sNam   =  p_sName
        @iAge=-1
    end
    attr_accessor :iAge,:sNam
    def fIsFrozen(p_sId)
        iOId = self.object_id
        if (self.frozen?)
            $m.f_puts "oID[#{iOId}](#{p_sId}) is frozen."
        else
            $m.f_puts "oID[#{iOId}](#{p_sId}) is NOT frozen."
        end
    end
    #   https://stackoverflow.com/questions/35633367/how-to-unfreeze-an-object-in-ruby
    def f_unFreeze
        Fiddle::Pointer.new(object_id * 2)[1] &= ~(1 << 3)
    end
    def fOut(p_sInf)
        iOId = self.object_id
        iCtr = @@iCtr
        $m.f_puts "oID[#{iOId}],cID[#{iCtr}](#{p_sInf}) :: <#{@sNam}>;<#{@iAge}>"
    end
end

#
#   THM:object methods
#
$m.f_thm("prepare 2 objects",true,__LINE__)
x = CCat.new('Spot')
x.iAge=5
x.fOut('sp') # Nam:<Spot>;Age:<5>;Ctr:<1>
y = CCat.new('Felix')
y.iAge=8
y.fOut('fl') # Nam:<Felix>;Age:<8>;Ctr:<2>
#   bind a function to the object-1, not to the class
def x.fTmp
    iAge=10
    iOId = self.object_id
    sMet = __method__
    $m.f_puts "fTMP::oID[#{iOId}];sMethod:<#{@sMet}>"
end

#
#   !THM:object copy
#

#
#   +   copy with '='
#
$m.f_thm("objectCopy with '='",true,__LINE__)
y = x   # this is only a link and not an object duplication !
y.fOut('Y')
#   now we change object y only
y.iAge=11
y.sNam='Whisky'
y.fOut('yB') # Nam:<Whisky>;Age:<11>;Ctr:<2>
# but also object 'x' has been changed
x.fOut('X?') # Nam:<Felix>;Age:<37>;Ctr:<2>

#   dup vs clone
#   First,  clone copies the singleton class, while dup does not.
#   Second, clone preserves the frozen state, while dup does not.

#
#   +   copy with 'dup'
#
$m.f_thm("objectCopy with 'dup'",true,__LINE__)
#   restore old values
x.sNam='Spot'
x.iAge=5
x.fOut('restore') # Nam:<Spot>;Age:<5>;Ctr:<2> : OK
y = x.dup
#   freeze - 'x' - demonstrate difference to clone
x.freeze
#   change y
y.sNam='Whisky'
y.iAge=33
y.fOut('y=x.dup') # Nam:<Whisky>;Age:<33>;Ctr:<2> : OK
#   x is unchanged
x.fOut('x') # Nam:<Spot>;Age:<5>;Ctr:<2> : OK
#   check freeze
x.fIsFrozen('x')
y.fIsFrozen('y')
#   check tmp - is 'fTmp' bound?
if (y.respond_to?'fTmp')
else
    y.fOut('y:not bound to fTmp')
end

#
#   +   unfreeze
#
$m.f_thm("prepare X to unFreeze",true,__LINE__)

#   !URL https://bugs.ruby-lang.org/issues/11473

=begin
    x.f_unFreeze        #!CRQ-210302: unfreeze - not possible
    x.fIsFrozen('x')    # not unfrozen
=end

#
#   +   copy with 'clone'
#
$m.f_thm("objectCopy with 'clone'",true,__LINE__)
#   use: x.close
z = y.clone #!CRQ-210302:use object 'y' instead of 'x'
z.sNam='Whisky'
z.iAge=33
z.fOut('z')
#   run function bound to the object
if (z.respond_to?'fTmp')
    z.fTmp()
    z.fOut('z2')
else
    z.fOut('z:not bound to fTmp')
end
#   x is unchanged
x.fOut('unchange x?')

#   ----------------------------------------------------------------------------
#   THM: other ways of creating objects
#   ----------------------------------------------------------------------------

$m.f_thm("enhanced object handling")

$m.f_thm('initialize_copy',true)

#   use a constructor as before
$m.f_inf('use:initialize')
class CDoc1
    attr_reader     :sTimeStamp
    def initialize()
        @sTimeStamp=Time.now
    end
end
x=CDoc1.new()
sleep(1)
y=x.clone   # or y=x.dup
bRc =  (x.sTimeStamp == y.sTimeStamp )
$m.f_puts   "? x(#{x.object_id}).Time==y(#{y.object_id}).Time =: <#{bRc}> :=: " +
            "#{x.sTimeStamp}"
# true! = same timeStamps, because first timeStamp hasn't change with clone

#   now use special constructor, which handles the clone different
$m.f_inf('use:initialize_copy')
class CDoc2
    attr_reader     :sTimeStamp
    def initialize()            # => used by object 'x'
        @sTimeStamp=Time.now
    end
    def initialize_copy(other)  # => used during y=x.clone
        @sTimeStamp=Time.now
    end
end
x=CDoc2.new()
sleep(1)
y=x.clone   # or y=x.dup
$m.f_inf("x.sTimeStamp:<#{x.sTimeStamp}>")
$m.f_inf("y.sTimeStamp:<#{y.sTimeStamp}>")

bRc =  (x.sTimeStamp == y.sTimeStamp )
$m.f_puts   "? x(#{x.object_id}).Time==y(#{y.object_id}).Time =: <#{bRc}> :=: " +
            "#{x.sTimeStamp}"
# FALSE => different timeStamps

#
#   !THM: allocate
#
#   allocate()
#   Allocates space for a new object of class’s class and does not call initialize
#   on the new instance. The returned object must be an instance of class.

$m.f_thm('allocate',true)
class CPerson
    attr_reader     :iAge
    def initialize(p_iAge)
        @iAge=p_iAge
    end
end

x=CPerson.new(25)
$m.f_puts "x(#{x.object_id}).AGE==(#{x.iAge})"  # x(3239940).AGE==(25)

#   do allocate - don't call 'initialize'
y=CPerson.allocate
$m.f_puts "y(#{y.object_id}).AGE==(#{y.iAge})"  # y(3237960).AGE==()

# end
$m.f_end()
