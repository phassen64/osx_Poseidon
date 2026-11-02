=begin
    Threads
    +   creating :  Thread.new
    +   local var:  Thread.current[]
    +   keys:       Thread,ThreadGroup
    +   methods1:   Thread.<x>;     x=:{new,stop,main,current,kill}
    +   methods2:   pThread.<x>;    x=:{kill,priority,list.size}
=end
#!$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß

require_relative "TUT.inc"
$m.f_hdr("meta",__FILE__)

$m.f_thm("timout",true,__LINE__)
require 'timeout'
def f_forever
    i=0
    while(true) do
        i+=1
        $m.f_puts "hello:#{i}"
        sleep(0.5)  # !Exc, when timeout is active
    end
end
begin
    Timeout.timeout(5) do
        f_forever
    end
rescue Timeout::Error => e
    $m.f_exc("of:Timeout","#{e}",__LINE__)
rescue StandardError => e
    $m.f_exc("of:StandardError","#{e}",__LINE__)
end

#
#   === !THM:any
#

#   Introduction
sHere =<<THEME
    Traditional programs have a single thread of execution the statements or
    instructions that comprise the program are executed sequentially until the
    program terminates.
    A multithreaded program has more than one thread of execution.
    Within each thread, statements are executed sequentially,
    but the threads themselves may be executed in parallel on a multicore CPU,
    for example.
    Often on a single CPU machine, multiple threads are not actually executed in parallel,
    but parallelism is simulated by interleaving the execution of the threads.
    Ruby makes it easy to write multi-threaded programs with the Thread class.
    Ruby threads are a lightweight and efficient way to achieve concurrency in your code.
THEME
$m.f_doc("Introduction:","Threads",sHere.to_s)

#
#   === !THM:create Threads
#
$m.f_thm("Creating and Manipulation Threads")

#   create
$m.f_thm("create",true,__LINE__)

#   a) simply define a thread with Thread.new{...}
p = Thread.new {
    sleep(1)  # sleep, then show Tread-Pointer
    $m.f_trc(nil,__LINE__,__method__,"I am the thread:=[#{p}]")
    # <<< trc:?F;32;?M;I am the thread:=[#<Thread:0x00000003148a90>]
}
sleep(2)    # waiting, meanwhile the the tread is starting
$m.f_inf "continue:A"

#   b) Thread.new(x,y) with parameters
i=4711
s='Peter'
p = Thread.new(i,s) {
    sleep(1)
    $m.f_trc(nil,__LINE__,nil,"[#{p}]::p1:'#{i}';p2:'#{s}'")
}
p.join  # like sleep(x), waiting in the block until thread p is ready
$m.f_inf "continue:B"

#   c) issue - 'when' using local variables
#   Who is faster? The block or the thread?
i=123
p = Thread.new{
    sleep(1)
    i=-77   # thread changes local-variable 'i'
    $m.f_trc(nil,__LINE__,nil,"[#{p}]::i:'#{i}")
}
sleep(1)
$m.f_inf "continue:C: i=#{i}" # i='123' or '-77'

#
#   === !THM:thread-local-variables
#

$m.f_thm("thread-local variables",true,__LINE__)

#   REM:
#       Thread-local-variables are not local-variables!
#       They can be defined in a
#       a)  symbol-syntax   p[:key]=value       or
#       b)  string-syntax   p["key"]=value

#
#   a) define 1-thread with 3 thread-local-variables
#
$m.f_trc(nil,__LINE__,nil,"a) create 1 threads")
p = Thread.new {
    pD = Thread.current #   get local data-pointer
    $m.f_trc(nil,__LINE__,nil,"[#{p}]::pD:'#{pD}")
    #   create 3 variables
    pD[:sName]  = 'Mary'
    pD[:iLine]  = __LINE__
    pD['sTime'] = Time.now.strftime("%H:%M:%S") # 15:31:35
}
p.join    # wait for the thread
$m.f_inf "continue:a"
#   access to the thread-local-data outside of the thread-block
#   check, if exists with key?
if (p.key? :sName)
    $m.f_puts "NAME:<#{p[:sName]}>"
end
if (p.key? :iLine)
    i=p[:iLine]
    $m.f_puts "LINE:<#{i}>"
end
if (p.key? :sTime)
    s=p[:sTime] # same as s=p['sTime']
    $m.f_puts "TIME:<#{s}>"
end

#
#   === !THM:query Threads
#

=begin
    Thread.<x>;x={'main','kill','pass','list','exit','stop'}
#   p.<x>.<x>;x={'kill','status'}
=end

$m.f_thm("querying and changing a thread status",true,__LINE__)
#   show the main-thread
p   = Thread.main; $m.f_puts "pMAIN:=<#{p}>"
ap  = []    # array of thread-pointer
#   define 5 Threads-Pointer, creation-time differs 1 sec
C_THREAD_MAX=5
iMax=C_THREAD_MAX
iMax.times do |i|
    $m.f_inf "Thread.new #{i}/#{iMax}..." #
    sNow=Time.now.strftime("%H:%M:%S:%L")    # with ms
    iRnd=rand(100)  #   0...99
    ap[i] = Thread.new(i) {  |p_iIdx|
        p=Thread.current  # pointer to current running thread
        # save Data
        p[:sNow]=sNow
        p[:iRnd]=iRnd
        p[:iIdx]=p_iIdx
        1.upto(200) { |j|
            # fetch current Thread-values
            p=Thread.current  # pointer p is global
            sNow=p[:sNow]
            iRnd=p[:iRnd]
            iIdx=p[:iIdx]
            if (j%20==0)
                $m.f_trc(nil,__LINE__,nil,"T[#{iIdx}|#{p}]:=<#{sNow}|#{iRnd}>")
            end
            sleep(0.1)
        }
    }
    sleep(0.5)
end

#   show all running threads
sleep(5)
a=Thread.list;n=a.size; $m.f_inf "L(#{n})=<#{a}>"
sleep(1)
#   kill thread 2
i=2
bRc=(ap[i].alive?); $m.f_inf "T[#{i}].alive?=:#{bRc}"
Thread.kill(ap[i])
sleep(0.1) # kill needs time
a=Thread.list;n=a.size; $m.f_inf "L(#{n})=<#{a}>"
#   kill thread 4
i=4; ap[i].kill
sleep(0.1) # kill needs time
a=Thread.list;n=a.size; $m.f_inf "L(#{n})=<#{a}>"
#   give up time slice
Thread.pass
sleep(0.1)

#   show status
i=0
s=ap[i].status
$m.f_inf "status:<#{s}>"
sleep(5)
$m.f_inf "continue"

#   set priority
i=0;    ap[i].priority=5

#   get priority
i=3;    x=ap[i].priority; $m.f_inf "priority(#{i}):<#{x}>"
i=0;    x=ap[i].priority; $m.f_inf "priority(#{i}):<#{x}>"

#
#   === !THM:rendevouz of threads
#

#   join
$m.f_thm("rendevouz of threads",true,__LINE__)

#   loop through all threads,
#   t.join(don't continue, until 't' is done)
Thread.list.each { |x|
    $m.f_inf "join:(#{x})..."
    x.join if x!= Thread.current
}

#
#   === !THM:exceptions
#

$m.f_thm("exceptions",true,__LINE__)
def f_bdy_ThrExc(p_sTId,p_bExc,p_fDelay)
    p = Thread.current
    p[:sTId]=p_sTId # save my params
    p[:bExc]=p_bExc
    p[:bDel]=p_fDelay
    for i in 1..100 do
        p = Thread.current
        sTId=p[:sTId]
        bExc=p[:bExc]
        if (bExc && (i==5))
            s="DoRaise::AnyExc sends thread:<#{sTId}>"
            $m.f_trc(nil,__LINE__,nil,"#{s}")
            raise s  # stops this thread
        end
        $m.f_puts "[#{sTId}](#{Thread.current}):#{i}"
        sleep(p[:bDel])
    end
end
pT1 = Thread.new do
    f_bdy_ThrExc('A',true,1)
end
begin
    pT1.status
    #   pT1.join
rescue => e     #   define excHandler
    sCls=e.class; sMsg=e.message
    $m.f_trc(nil,__LINE__,nil,"Thread raised:<#{sCls}>:<#{sMsg}>")
end
#   aborts all threads, main+T2, in case of not handled exc
#   or without no rescue
#   pT1.abort_on_exception=true

pT2 = Thread.new do
    f_bdy_ThrExc('B',false,3)
end
#   main-threads sleeps
sleep(8)   # sleep main thread
pT2.kill

#
#   === !THM:thread group
#
$m.f_thm("thread group",true,__LINE__)
iThrMax = 3  # !CRQ-210302:take iThrMax:=5=>3
iRunMax = 100
def f_bdy_ThrGrp(p_iTId)
    p = Thread.current
    p[:iTId]=p_iTId # save my params
    for i in 1..100 do
        p = Thread.current
        iTId=p[:iTId]
        $m.f_puts "T[#{p_iTId}]:(#{Thread.current}:[#{i}])"
        sleep(0.5)  #
    end
end
aT  = Array.new
pTg = ThreadGroup.new
for i in 1..iThrMax do
    aT[i] = Thread.new do f_bdy_ThrGrp(i) end
    pTg.add aT[i]
    sleep(0.1)      # wait for group command in main-Thread
end
n=pTg.list.size
$m.f_puts "nThreads:<#{n}>"
sleep(iThrMax)
p=aT[2]; $m.f_puts "I will kill Thread:<#{p}>..."; Thread.kill(p)
sleep(3)
iCtr=0
pTg.list.each { |x| iCtr+=1 if x.alive? }
$m.f_puts "iCtr:<#{iCtr}>;n:<#{n}>"
pTg.enclose         # close group
$m.f_puts "I will kill all other threads...";
pTg.list.each { |x| x.kill }
sleep(3)
$m.f_puts "ready!";

#
#   === !THM:sync threads
#
$m.f_thm("synchronize threads")

$m.f_thm("using:MUTEX",true,__LINE__)
require 'thread'
$iSem = 0
$xSem = Mutex.new
def f_bdy_ThrMutex(p_iTId)
    p = Thread.current
    p[:iTId]=p_iTId # save my params
    i=0
    i.upto(100) do
        p = Thread.current
        iTId=p[:iTId]
        p[:iIdx]=i
        if (iTId==1)
            if ($xSem.owned?)   # have I already the Sem?
                p[:sSem]='true'.m_yellow
                $iSem += 1
                $xSem.unlock    # release sem
            else
                $xSem.lock      # reservate sem
                p[:sSem]='false'.m_yellow
            end
            bSem=true
        else
            if ($xSem.locked?)  # locked by another ?
                p[:sSem]='false'.m_red
            else
                p[:sSem]='true'.m_green
                $xSem.synchronize { $iSem += 10 } # do for all threads
            end
        end
        iSem=$iSem
        $m.f_puts "T[#{p_iTId}]:(#{Thread.current}:[#{p[:iIdx]}]):#{iSem}:#{p[:sSem]}"
        sleep(0.5)
    end # do
end # f~bdy_ThrMutex
#   create threads
aT    = Array.new
aT[1] = Thread.new do f_bdy_ThrMutex(1) end
aT[2] = Thread.new do f_bdy_ThrMutex(2) end
$m.f_puts "thread-main is sleeping"
sleep(5)
$m.f_puts "thread-main comes up"
aT[1].kill
aT[2].kill
sleep(5)

#   === end
#
$m.f_puts "THREAD test successfully!"
$m.f_end




