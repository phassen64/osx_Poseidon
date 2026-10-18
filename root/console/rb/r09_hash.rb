=begin
    HASH:
    +   define:     {},Hash.new
    +   add :       store, merge!
    +   info:       count,length,size
    +   check:      empty?, equal?, eql?
                    has_key?(or key?), has_value?, member?, include?
    +   access      fetch, select,
                    each_key, each_value, each |key,value|
    +   change:     clear,shift
                    delete_if,keep_if
    +   modifier:   invert
    +   math Set Ops:
                    merge[!],
                    intersection    :: h1.keys&h2.keys
                    difference      :: h1.keys-h2.keys
    +   convert :
            hash2array  : h2a,h2s,to_sym, values,values_at
            array2hash  : a2h,Hash[*a1D],Hash[a2D]
            hash2set
    +   copy    :   dup, compare_by_identity[?]
=end
#!$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß


require_relative "TUT.inc"
$m.f_hdr("Hash",__FILE__)

#   ----------------------------------------------------------------------------
#   !mod: define
#   ----------------------------------------------------------------------------

$m.f_thm("define")

#   define empty hash, then overwrite with values
$m.f_thm('h={}"}',true,__LINE__)
h={}
h={'A'=>'Erde','B'=>'Mars','C'=>'Jupiter'}
$m.f_puts "h: #{h}"

#   classic : define with key-strings
$m.f_thm('h= {"key1"=>"value1",...,"keyN"=>"valueN"}',true,__LINE__)
h1 = { "Name"=>"Peter","City"=>"Nuernberg","PLZ"=>90489, "alive"=>true}
$m.f_puts "h1: #{h1}"

#   modern  : define with key-symbols  # also named as "colon-hash"
$m.f_thm("h={[:<keySymbol1>]=><value1>,..,:<keySymbolN>]=><valueN>",true,__LINE__)
h2 = {:Name=>"Peter",:City=>"Nuernberg",:PLZ=>90489,:alive=>true}
$m.f_puts "h2: #{h2}"

#   modern  : define with key-symbols and in steps
#   use:keySymbols, array-like access h[:<keySymbol>]=<value>
$m.f_thm("h[:<key1>]=<value1>;...;h[:<keyN>]=<valueN>",true,__LINE__)
h3 = Hash.new  # use class and constructor
h3[:Name]="Peter"; h3[:City]="Nuernberg"; h3[:PLZ]=90489 ; h3[:alive]=true
$m.f_puts "h3: #{h3}"

#   ----------------------------------------------------------------------------
#   !mod: add/extend a HASH
#   ----------------------------------------------------------------------------

$m.f_thm("add")

#   h={}
$m.f_thm("Sonne&Mond",true,__LINE__)
h={}  # define empty hash
h={'A'=>'Sonne'}
h.store('A','Sonne')
h.store('B','Erde')
h.store('C','Mond')
$m.f_puts h #{"A"=>"Sonne", "B"=>"Erde", "C"=>"Mond"}}
$m.f_putH(h,';')
#   exit

#   h=Hash.new
$m.f_thm("Peter,Paul&Mary - symbolHash",true,__LINE__)
h = Hash.new
k='001'; v='Peter'; h[k.to_sym]=v           # "001"=>"Peter"
k='002'; v='Paul';  h.merge!({k => v})      # "001"=>"Peter","002"=>"Paul"
k='003'; v='Mary';  h[k.to_sym]=v           # "001"=>"Peter","002"=>"Paul","003"=>"Mary"
$m.f_puts h # {:"001"=>"Peter", "002"=>"Paul", :"003"=>"Mary"}

#   ----------------------------------------------------------------------------
#   !mod: informations
#   ----------------------------------------------------------------------------

#   info:   count,length,size
$m.f_thm("informations")
h=h1
$m.f_inf "h: '#{h}'" #
x=h.count.to_s  ; $m.f_puts "h.count      := '#{x}' "
x=h.length.to_s ; $m.f_puts "h.length     := '#{x}' "
x=h.size.to_s   ; $m.f_puts "h.size       := '#{x}' " # size=alias(length)

#
#   THM: check
#
$m.f_thm("check")
k="Name"; v=90489; kSym=k.to_sym; h=h1

#   empty?
h={}
$m.f_thm("h.empty?",true,__LINE__)
$m.f_inf "h: '#{h}'"
bRc=(h.empty?); $m.f_puts ("h(#{h}).empty? =: '#{bRc}'") # true

#
#   --- key check
#

#   has_key? or key?
$m.f_thm("h.has_key?<key>",true,__LINE__)
h=h1
bRc = h.has_key?    k ;     $m.f_puts "h.has_key? '#{k}' =:  '#{bRc}'"   # t
bRc = h2.has_key?   k ;     $m.f_puts "h2.has_key? '#{k}' =:  '#{bRc}'"   # f
bRc = h3.has_key?   kSym;   $m.f_puts "h3.has_key? sym:'#{kSym}' =:  '#{bRc}'"   # t

$m.f_thm("h.key?<key> (==alias(has_key?)",true,__LINE__)
v="Peter"
bRc = h.key? k; $m.f_puts "h.key? '#{k}' =: '#{bRc}'"   #true

#   member? :  key||value
$m.f_thm("h.member?<key> (==alias(has_key?)",true,__LINE__)
bRc = h.member? k; $m.f_puts "h.member? '#{k}' =: '#{bRc}'"   # true
bRc = h.member? v; $m.f_puts "h.member? '#{v}' =: '#{bRc}'"   # false

#   include?
$m.f_thm("h.include?<key> (==alias(has_key?)",true,__LINE__)
v="Peter"
bRc = h.include? k; $m.f_puts "h.include? '#{k}' =: '#{bRc}'"   #true
bRc = h.include? v; $m.f_puts "h.include? '#{v}' =: '#{bRc}'"   #false

#   has_value?
$m.f_thm("h.has_value?<value>",true,__LINE__)
bRc = h.has_value? v ;    $m.f_puts "h.has_value? '#{v}' =:  '#{bRc}'"   # true

#
#   --- compare
#

$m.f_thm("informationsB")

h1={ 'A'=>'Sonne','B'=>'Erde','C'=>'Mond'}
h2={ "A"=>'Sonne',"B"=>'Erde',"C"=>'Mond'}
h3={ "Name"=>"Peter","City"=>"Nuernberg","PLZ"=>90489, "alive"=>true}
h4={}; h4[:A]='Sonne'; h4[:B]='Erde'; h4[:C]='Mond'
h5 = h4.clone;
h6=h1;
$m.f_puts ("h1:=<#{h1}>")
$m.f_puts ("h2:=<#{h2}>")
$m.f_puts ("h3:=<#{h3}>")
$m.f_puts ("h4:=<#{h4}>")
$m.f_puts ("h5:=<#{h5}>")

#   compare hashes: h1==h2
$m.f_thm("method:'=='",true,__LINE__)
bRc=(h1==h2);   $m.f_puts "h1==h2 =: '#{bRc}'" # true
bRc=(h1==h3);   $m.f_puts "h1==h3 =: '#{bRc}'" # false
bRc=(h1==h4);   $m.f_puts "h1==h4 =: '#{bRc}'" # false
bRc=(h5==h4);   $m.f_puts "h5==h4 =: '#{bRc}'" # true

#   eq? is same like '=='
$m.f_thm("method:'eq?' (same as: '==')",true,__LINE__)
bRc=(h1.eql? h2);   $m.f_puts "h1.eql? h2 =: '#{bRc}'" # true
bRc=(h1.eql? h3);   $m.f_puts "h1.eql? h3 =: '#{bRc}'" # true
bRc=(h1.eql? h4);   $m.f_puts "h1.eql? h4 =: '#{bRc}'" # false

#   equal? checks objects
$m.f_thm("method:'equal?'",true,__LINE__)
bRc=(h1.equal? h2);   $m.f_puts "h1.equal? h2 =: '#{bRc}'" # false !
bRc=(h1.equal? h4);   $m.f_puts "h1.equal? h4 =: '#{bRc}'" # false !
bRc=(h5.equal? h4);   $m.f_puts "h5.equal? h4 =: '#{bRc}'" # false  - only clone
bRc=(h1.equal? h6);   $m.f_puts "h1.equal? h6 =: '#{bRc}'" # true

#   ----------------------------------------------------------------------------
#   !mod: access
#   ----------------------------------------------------------------------------

$m.f_thm("single access")
h1={ "Name"=>"Peter","City"=>"Nuernberg","PLZ"=>90489, "alive"=>true}
$m.f_puts ("h1:=<#{h1}>")

#   x:=h['key'] : use string-hash and access to value
$m.f_thm("x:=h['key'] * access via key-string",true,__LINE__)
h=h1;
$m.f_inf "h1: '#{h}'"

k="Name"; x=h[k]; $m.f_puts "x=h1.[k:'#{k}'] := '#{x}'"  # 'Peter'
x=x.class; $m.f_inf "x.class => '#{x}'"  # 'String'

k='PLZ'; x=h[k]; $m.f_puts "x=h1.[k:'#{k}'] := '#{x}'"  # '90489'
x=x.class; $m.f_inf "x.class => '#{x}'"  # 'Fixnum'

k='plz' # case-sensitive
x=h2[k]; $m.f_puts "x=h2.[key:'#{k}'] := '#{x}'"  # ''
x=x.class; $m.f_inf "x.class => '#{x}'"  # 'NilClass'

#   x:=h[:key] : use colon-hash access to value - use 'to_sym'
$m.f_thm("x:=h[:key] * access via key-symbol",true,__LINE__)
h3[:Name]="Peter"; h3[:City]="Nuernberg"; h3[:PLZ]=90489 ; h3[:alive]=true; h=h3
$m.f_inf "h: '#{h}'"
#   !REM:the access with a key-symbol is h[K] and not h[:K]
x1=h[:Name];
k='Name'; kSym=k.to_sym; x2=h[kSym] # !!RBY:not use h[:kSym] -- that's wrong
$m.f_puts "x1:h[:Name] =: '#{x1}'"   # ?
$m.f_puts "x2:h[:kSym('#{k}')]  =: '#{x2}'"   # ?

#
#   THM:access via : fetch, key
#
$m.f_thm("single access via methods")
$m.f_puts ("h1.old:=<#{h1}>")
h1[:Name]="Eva"; h1[:City]="Stade"; h1[:PLZ]=21682 ; h1[:alive]=true
# this extens h1.old
$m.f_puts ("h1.new:=<#{h1}>")

#   fetch VALUE of standard hash
$m.f_thm("h.fetch(key) => value",true,__LINE__)
h=h1
k='Name'.to_sym    # it must be a symbol
bRc = h.fetch(k) ;      $m.f_puts "h1.fetch?(k:'#{k}') =:  '#{bRc}'"   # t

#   fetch VALUE of colon-hash via method:fetch
h=h1
k='PLZ'.to_sym;
bRc = h.fetch(k) ;      $m.f_puts "h1.fetch?(k:'#{k}') =:  '#{bRc}'"   # t

#   fetch KEY via method:key(value)
$m.f_thm("method 'key' => key",true,__LINE__)
v=90489;    bRc = h1.key(v) ; $m.f_puts "h1.key(v:'#{v}') =:  '#{bRc}'"   # 'PLZ'
v="Peter";  bRc = h1.key(v) ; $m.f_puts "h1.key(v:'#{v}') =:  '#{bRc}'"   # 'Name'
v="Stade";  bRc = h1.key(v) ; $m.f_puts "h1.key(v:'#{v}') =:  '#{bRc}'"   # 'City'

#
#   THM: selecting
#
$m.f_thm("selecting more elements")

#   method:select
$m.f_thm("method:'select'",true,__LINE__)
h   = { :books => 100, :blueRay => 30, :lp=>5, :dvd => 13, :cd => 45 }
$m.f_inf("h:#{h}")
s = h.select { |xKey,xVal|xVal>20 }; $m.f_puts "h.select{|key,val|val>20} =: <#{s}>"
$m.f_inf("hNow:#{h}",C_COLOR_CYAN)

#   method:each_key
$m.f_thm("method:'each_key' -- loop",true)
i=0
h.each_key do |x|
    $m.f_print "key[#{i}]:=#{x};"
    i+=1
end
$m.f_puts ""
#   !PHA: undefined is : h.each_key_with_index, h.each_value_with_index

#   method:each_value
$m.f_thm("method:'each_value' --loop",true,__LINE__)
i=0
h.each_value do |x|
    $m.f_print "val[#{i}]:=#{x};"
    i+=1
end
$m.f_puts ""

#   fetch key+value
$m.f_thm("simple fetch each key+value",true,__LINE__)
i=0
h.each do |xKey,xVal|
    $m.f_puts "[#{i}]:\tkey:'#{xKey}' \t=> val:'#{xVal}'"
    i+=1
end
$m.f_puts ""

$m.f_thm("method:sort")
# h2={:Name=>"Peter",:City=>"Nuernberg",:PLZ=>90489,:alive=>true}; h=h2
$m.f_puts h.sort
$m.f_inf("hNow:#{h}",C_COLOR_CYAN)

#   ----------------------------------------------------------------------------
#   !mod: change hash
#   ----------------------------------------------------------------------------

#
#   THM: change methods : clear, default
#
$m.f_thm("change complete hash")

#   clear
$m.f_thm("method : 'clear'",true,__LINE__)
h=h1
$m.f_inf "h: '#{h}'" #
h.clear; $m.f_puts "h.clear() => h:='#{h}'"

#   default : using default-values
$m.f_thm("method : 'default'",true,__LINE__)
k="cat"
vDefault="goFish_per_default"
#   h = Hash.new(k); $m.f_puts "h.Hash.new('#{k}') => h:='#{h}'"
h = { "a" => 100, "b" => 200 };
h.default = vDefault
$m.f_puts "h:='#{h}',vDefault:'#{vDefault}'"
x='a'; v=h[x]; $m.f_puts "h['#{x}']:='#{v}'"    #   100
x='b'; v=h[x]; $m.f_puts "h['#{x}']:='#{v}'"    #   200
x='c'; v=h[x]; $m.f_puts "h['#{x}']:='#{v}'"    #   "c" not defined use:"goFish_per_default"

#
#   THM: change single items methods : shift
#
$m.f_thm("change single item")

#   shift: remove last item (Key:Value)
$m.f_thm("method:'shift'",true,__LINE__)
h1 = { "Name"=>"Peter","City"=>"Nuernberg","PLZ"=>90489, "alive"=>true}
h=h1 # changes also h1
$m.f_inf "h: '#{h}'"
h.shift(); $m.f_puts "h1.shift() => h:='#{h}'"
h.shift(); $m.f_puts "h1.shift() => h:='#{h}'"
h.shift(); $m.f_puts "h1.shift() => h:='#{h}'"
h.shift(); $m.f_puts "h1.shift() => h:='#{h}' =>:empty"
h.shift(); $m.f_puts "h1.shift() => h:='#{h}'" # dito
h=h1 # !PHA:also h1 was changed
$m.f_inf "h: '#{h}'" #
h1 = { "Name"=>"Peter","City"=>"Nuernberg","PLZ"=>90489, "alive"=>true}

#
#   THM: change more items : delete_if, keep_if, merge, merge!, invert
#
$m.f_thm("change more items - alter hashes")

#   delete_if
$m.f_thm("method:'delete_if'",true,__LINE__)
h   = { :books => 100, :blueRay => 30, :lp=>5, :dvd => 13, :cd => 45 }
i   = 30
y   = h.delete_if { |xKey,xVal| xVal < i }
$m.f_puts "y=h.delete_if { |xKey,xVal| xVal < '#{i}'} =:..."
$m.f_puts "y=#{y}"
$m.f_inf("hNow:#{h}",C_COLOR_CYAN)  # {:books=>100, :blueRay=>30, :cd=>45}

#   keep_if
$m.f_thm("method:'keep_if'",true,__LINE__)
h   = { :books => 100, :blueRay => 30, :lp=>5, :dvd => 13, :cd => 45 }
i   = 30
y   = h.keep_if { |xKey,xVal| xVal < i }
$m.f_puts "y=h.keep_if { |xKey,xVal| xVal < '#{i}'} =:..."
$m.f_puts "y=#{y}"
$m.f_inf("hNow:#{h}",C_COLOR_CYAN) # {:lp=>5, :dvd=>13}

#   merge, merge!
h   = { :books => 100, :dvd => 13, :cd => 45 }
h2  = { :Name => 'Peter', :PLZ => 90489, :aLive => true }
$m.f_inf("h:#{h};h2:#{h2}")
$m.f_thm("method:'merge'",true,__LINE__)
y = h.merge(h2)
$m.f_puts "y=h.merge(h2)"
$m.f_puts "y=#{y}"
# y={:books=>100, :dvd=>13, :cd=>45, :Name=>"Peter", :PLZ=>90489, :aLive=>true}
$m.f_inf("hNow:#{h}:unchanged",C_COLOR_CYAN) # unchanged
$m.f_thm("method:'merge!'",true,__LINE__)
y = h.merge!(h2)
$m.f_puts "y=h.merge!(h2)"
$m.f_puts "y=#{y}"
$m.f_inf("hNow:#{h}:changed",C_COLOR_CYAN)  # changed !

#   invert : exchange h.each {key<=>val}
$m.f_thm("method:'invert'",true,__LINE__)
h   = { :books => 100, :blueRay => 30, :lp=>5 }
$m.f_inf "h:#{h}"                       #   h:{:books=>100, :blueRay=>30, :lp=>5}
y   = h.invert
$m.f_inf("y:#{y}",C_COLOR_CYAN)     #   y:{100=>:books, 30=>:blueRay, 5=>:lp}

#
#   !THM: math set operations
#
$m.f_thm("math operations")
$m.f_thm("math:h1.keys&h2.keys, h1.keys-h2.keys",true,__LINE__)
h1 = { :a=>1, :b=>2, :c=>3, :d=>4}
h2 = { :x=>-1, :y=>-2, :c=>-3, :z=>4}
$m.f_inf "h1:#{h1},h2:#{h2}"
h = h1.keys & h2.keys;      $m.f_puts "h=h1.keys & h2.keys=:<#{h}>"     # [:c]
h = h1.keys - h2.keys;      $m.f_puts "h=h1.keys - h2.keys=:<#{h}>"     # [:a, :b, :d] ?PHA
h = h1.values & h2.values;  $m.f_puts "h=h1.values & h2.values=:<#{h}>" # [4] => of keys {'d','z'}
h = h1.values - h2.values;  $m.f_puts "h=h1.values - h2.values=:<#{h}>" # [1, 2, 3]
#!PHA:not expected results, where are h2-values?
#   --- merge
$m.f_inf "h1:#{h1},h2:#{h2}"
h = h1.merge(h2);   $m.f_puts "h=h1.merge(h2)=:<#{h}>"
# {:a=>1, :b=>2, :c=>-3, :d=>4, :x=>-1, :y=>-2, :z=>4}
# exit

#   ----------------------------------------------------------------------------
#   !mod: convert hash
#   ----------------------------------------------------------------------------

#
#   THM: convert hash into array : to_a,keys,values
#
$m.f_thm("convert hash2array [h2a]")

#   a:=h.to_a
$m.f_thm("method:'h.to_a' => Array",true,__LINE__)
h   = { :books => 100, :blueRay => 30, :lp=>5 }; $m.f_inf "h:#{h}"
y   = h.to_a; $m.f_puts "y=h.to_a"
$m.f_inf("h:#{h}",C_COLOR_CYAN) # unchanged
$m.f_inf("y:#{y}",C_COLOR_CYAN) # y:[[:books, 100], [:blueRay, 30], [:lp, 5]]

#   a:=h.keys
$m.f_thm("method:'h.keys' => Array",true,__LINE__)
h   = { :books => 100, :blueRay => 30, :lp=>5 }; $m.f_inf "h:#{h}"
y = h.keys; $m.f_puts "y=h.keys"
$m.f_inf("y:#{y}",C_COLOR_CYAN) #  y:[:books, :blueRay, :lp]

#   a:=h.values         # get all values
$m.f_thm("method:'h.values' => Array",true,__LINE__)
h   = { :books => 100, :blueRay => 30, :lp=>5 }; $m.f_inf "h:#{h}"
y = h.values; $m.f_puts "y=h.values"
$m.f_inf("y:#{y}",C_COLOR_CYAN) #  y:[100, 30, 5]

#   a:=h.values_at      # get values selected
$m.f_thm("method:'h.values' => Array",true,__LINE__)
h   = { :books => 100, :blueRay => 30, :lp=>5 }; $m.f_inf "h:#{h}"
y = h.values_at(:books,:lp); $m.f_puts "y=h.values_at"
$m.f_inf("y:#{y}",C_COLOR_CYAN)  #  y:[100, 5]
# exit

#   array2hash: to_h, Hash[*a2D]
$m.f_thm("convert array2hash [a2h]")
$m.f_trc(nil,__LINE__,nil,"convert")
a1D     = [1,2,3,4,5,6]         # 1-dimension array, must be even
a2D    = [[1,2],[3,4],[5,6]]    # 2-dimension array, length must be even
$m.f_inf("a1D:<#{a1D}>;a2D:<#{a2D}>")
h = a2D.to_h;     $m.f_puts("a2D.to_h   =: <#{h}>")
h = Hash[a2D];    $m.f_puts("Hash[a2D]  =: <#{h}>")
h = Hash[*a1D];   $m.f_puts("Hash[*a1D] =: <#{h}>") # pointer

#
#   THM: convert hash2set: to_set
#
require 'set'
$m.f_thm("convert hash2set [h2s]")
$m.f_trc(nil,__LINE__,nil,"set")
h   = { 1=>2, 3=>4, 5=>6 }; $m.f_inf "h:#{h}"
e   = h.to_set
$m.f_inf("e:#{e}",C_COLOR_CYAN) # e:#<Set:0x2def838> - not {[1,2],...}
# exit

#   ----------------------------------------------------------------------------
#   !mod: duplicate hash
#   ----------------------------------------------------------------------------

#   copy hash:  dup,dup.compare_by_identity,
$m.f_thm("method:'dup' 'compare_by_identity'")
$m.f_thm("dup",true,__LINE__)
h1={"alpha"=>1, :echo=>2, 35=>3}
h2=h1.dup
h3=h1.dup.compare_by_identity
$m.f_inf("h1:#{h1}")

#   check:  eql?, compare_by_identity?
$m.f_thm("eql?,compare_by_identity?",true,__LINE__)
bRc = h1.eql? h2 ;      $m.f_puts "h1.eql? h2 =:  '#{bRc}'"   # true
bRc = h1.eql? h3 ;      $m.f_puts "h1.eql? h3 =:  '#{bRc}'"   # false
bRc = h2.compare_by_identity?; $m.f_puts "h2.compare_by_identity?=:'#{bRc}'"# f
bRc = h3.compare_by_identity?; $m.f_puts "h3.compare_by_identity?=:'#{bRc}'"# t

#   === end
$m.f_end

