=== readme.RB : ruby

    Dieses Dokument in :
    •   UTF8        :   https://en.wikipedia.org/wiki/UTF-8

    codiert wird in :
    •   ANSI-1252   :   https://en.wikipedia.org/wiki/Windows-1252

=== keyword::ruby
    https://www.geeksforgeeks.org/ruby-keywords/?ref=lbp

    __ENCODING__	The script encoding of the current file.
    __LINE__	    The line number of this keyword in the current file.
    __FILE__	    The path to the current file.
    BEGIN	        Runs before any other code in the current file.
    END	            Runs after any other code in the current file.
    alias	        Creates an alias between two methods (and other things).
    and	            Short-circuit Boolean and with lower precedence than &&
    begin	        Starts an exception handling block.
    break	        Leaves a block early.    
    case	        Starts a case expression.
    class	        Creates or opens a class.
    def	            Defines a method.
    defined?	    Returns a string describing its argument.
    do	            Starts a block.
    else	        The unhandled condition in case, if and unless expressions.
    elsif	        An alternate condition for an if expression.
    end	            The end of a syntax block. Used by classes, ...
    ensure	        Starts a section of code that is always run when an exception is raised.
    false	        Boolean false.
    for	            A loop that is similar to using the each method.
    if	            Used for if and modifier if expressions.
    in	            Used to separate the iterable object and iterator variable in a for loop.
    module	        Creates or opens a module.
    next	        Skips the rest of the block.
    nil	            A false value usually indicating “no value” or “unknown”.
    not	            Inverts the following boolean expression. Has a lower precedence than !
    or	            Boolean or with lower precedence than ||
    redo	        Restarts execution in the current block.
    rescue	        Starts an exception section of code in a begin block.
    retry	        Retries an exception block.
    return	        Exits a method.
    self	        The object the current method is attached to.
    super	        Calls the current method in a superclass.
    then	        Indicates the end of conditional blocks in control structures.
    true	        Boolean true.
    undef	        Prevents a class or module from responding to a method call.
    unless	        Used for unless and modifier unless expressions.
    until	        Creates a loop that executes until the condition is true.
    when	        A condition in a case expression.
    while	        Creates a loop that executes while the condition is true.
    yield	        Starts execution of the block sent to the current method.
<<< sum:41

=== call me

DOS:    
    cd d:\repository\GIT\console\tutorial\rb

cmd>rb uezip.rb --cmd parse --prj d:\my\cfg\IDM\ue24\_prj\EMPTY.prj --dir d:\my\zip.out --verbose --color

ruby uezip.rb --cmd unzip --prj d:\my\cfg\IDM\ue24\_prj\Samba.prj --dir d:\my\zip --verbose --color --obj d:\my\zip.out --flat --overwrite f


cmd>uez.bat zip d:\my\cfg\IDM\ue24\_prj\RBY.prj d:\my\zip
!CRQ-210206: FEL-Syntax:{':txt:rb:ino'} or {'.'} or {txt}

cmd>rb uezip.rb --cmd zip --prj d:\my\cfg\IDM\ue24\_prj\RBY.prj --dir d:\my\zip.out --verbose --color

+   Wir testen das Projekt Samba
cmd>rb ueZip.rb
cmd>rb ueZip.rb --cmd parse --prj d:\my\cfg\IDM\ue27\_prj\Samba.prj --ext ":rb:py:txt"
cmd>rb ueZip.rb --cmd parse --prj d:\my\cfg\IDM\ue27\_prj\PYTHON.prj --ext ":rb:py:txt"

+   mit verbose
cmd>rb ueZip.rb --cmd parse --prj d:\my\cfg\IDM\ue27\_prj\PYTHON.prj --ext ":rb:py:txt" --verbose

+   FEHLER!!!
rb ueZip.rb --cmd parse --prj d:\my\cfg\IDM\ue27\_prj\PYTHON.prj --ext ":rb:py:txt"


=*= Readme RUBY 2019

+ uedit projects tools
  Project1:= "H:\MY\cmd\rb\uez.bat zip d:\MY\zip %R"
  Project2:= "H:\MY\cmd\rb\uez.bat unzip d:\MY\zip %R"
  workingDir:=Temp

+ gems
>   call gem install -f --local *.gem

>   gem list



=*= Readme RUBY - P.Hassen 2017

=== Installation
Es wurde der Ruby-Installer verwendet.
Die MinGW/MS2 Shells werden nicht benötigt.

+ gems
>   call gem install -f --local *.gem

>   gem list

=== Verwendung
a)  Interactice Ruby
irb>
b)  DOS Shell mit gesetztem Pfad
*   Mit der irb können einfach Kommandos getestet werden.


#   Versionsausgabe
dos>    ruby -v

#   Help
dos>    ruby -h

#   Ruby File starten
dos>    ruby hello.rb


=== Tutorial
a) Files uxx.rb -
kurze Zusammenfassung

b) Ruby Quick Syntax
txx.rb


=== Variable Value

$@  The location of latest error
$_  The string last read by gets
$.  The line number last read by interpreter
$&  The string last matched by regexp
$~  The last regexp match, as an array of subexpressions
$n  The nth subexpression in the last match (same as $~[n])
$=  The case-insensitivity flag
$/  The input record separator
$\  The output record separator
$0  The name of the ruby script file currently executing
$*  The command line arguments used to invoke the script
$$  The Ruby interpreter's process ID
$?  The exit status of last executed child process

=== Variable
+   local   :   irb>    x=5
+   global  :   irb>    $x=5
+   classglobal  :   irb>    $x=5


=== Variable Scope

$               A global variable
@               An instance variable
{[a-z],'_'}     A local variable
[A-Z]           A constant
@@              A class variable

=== Variablen bestimmen
irb>    local_variables
irb>    global_variables
irb>    instance_variables


=== Power Shell
PS> Get-ChildItem -Path env:*


=== IRB short Intro
* Starten vom Startmenü
irb> Dir.pwd                    # where I am
irb> Dir.chdir "H:/MY/cmd/rb"   # zum Tutorial
irb> Dir.glob("*")  # alle Files dieses Directories ausgeben
irb> load "tmp.rb"  # ruby script ausführen - es darf kein exit() hier stehen


IRB.conf[:IRB_NAME] = "irb"

Commands

At the irb prompt, you can enter any valid Ruby expression and see the results.
You can also use any of the following commands to control the irb session.

exit, quit, irb_exit Quits this irb session or subsession. If you've used cb to
change bindings (see below), exits from this binding mode. conf, irb_context
Displays current configuration. Modifying the configuration is achieved by
invoking methods of conf. conf.back_trace_limit n Sets display lines of
backtrace as top n and tail n. The default value is 16. conf.debug_level = N
Sets debug level of irb. conf.ignore_eof = true/false Specifies the behavior of
an end of file received on input. If true, it will be ignored; otherwise, it
will quit irb. conf.ignore_sigint= true/false Specifies the behavior of ^C
(control-c). If false, ^C will quit irb. If true, ^C during input will cancel
input and return to the top level; during execution, ^C will abort the current
operation. conf.inf_ruby_mode = true/false If true, changes the prompt and
disables readline support, allowing irb to work with inf-ruby-mode. [inf-ruby-
mode allows Emacs users to interact with Ruby while editing programs. See the
file inf_ruby.el in the misc directory of the distribution for more details.]
The default value is false. conf.inspect_mode = true/false/nil Specifies inspect
mode according to the following values:

true  Display inspect (default). false  Display to_s. nil  Inspect mode in non-
math mode, non-inspect mode in math mode.

conf.irb_level Displays the current binding level (see cb). conf.math_mode
Displays whether or not Ruby is in math mode. conf.use_loader = true/false
Specifies whether or not irb's own file reader method is used with load/require.
conf.prompt_c The prompt for a continuing statement (for example, immediately
after an ``if''). conf.prompt_i The standard, top-level prompt. conf.prompt_s
The prompt for a continuing string. conf.rc = true/false Specifies whether or
not to use the initialization file ~/.irbrc. conf.use_prompt = true/false
Specifies whether or not to display prompts. conf.use_readline = true/false/nil
Specifies whether or not to use Readline according to the following values:

true  Use Readline. false  Do not use Readline. nil  Use Readline except for
inf-ruby-mode (default).

conf.verbose=true/false Specifies whether or not verbose messages are displayed.
cb, irb_change_binding [ obj ]  Creates and enters a new binding that has its
own scope for local variables. If obj is given, it will be used as self in the
new binding. irb [obj]  Starts an irb subsession. If obj is given, it will be
used as self. jobs, irb_jobs Lists irb subsessions. fg n, irb_fg n Switches into
the specified irb subsession. n may be any of the following values:

irb subsession number thread id irb object self (the obj that launched a
particular subsession)

kill n, irb_kill n Kills an irb subsession. n may be any of the values as described for irb_fg.

