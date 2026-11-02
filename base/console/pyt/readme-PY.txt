=== readme.PY : Python

=== Version im PyScript validieren
    import sys
    assert sys.version_info >= (3,10)

=== operator psh window
wCLR    $>  _cls; _runY c
wALL    $>  _cls; _runY c; _runY ! -o_logging
wUNO    $>  _cls; _runY -o_raw -o_color -o_verbose -p_sCmd .\y33_os.py  # uno
w311    $>  _cls; _y .\y33_os.py    # v3.11
wTMP    $>  python              # run python

=== pyenv
https://realpython.com/intro-to-pyenv/
https://pypi.org/project/pyenv/
#   show current python version
$>pyenv version
#   list installed versions
$>pyenv versions
#   switch to another python version
$>pyenv shell 3.11.0
$>pyenv shell 3.12.0

=== vpython
https://vpython.org/
vpython:"VirtiualPython"
#   check vectorCAST vpy
$bUsr   =   ($env:UserName -eq 'zzHassP')
$bVca   =   ($env:VECTOR_LICENSE_FILE -eq '7650@hdhappvectorcastvtlic')
$bVpy   =   $bUsr -and $bVca
if ($bVpy) {    #   usr:MeVoith && VCA
    $C_sCompiler    =   'vpython'
    #   f_runLib_puts "&&& bUsr:<$bUsr> bVca:<$bVca> bVvPy:<$bVpy>"
}

=== work before starting with go
ps7$>  Set-Alias -Name _go  -Value  ".\run_wpsTutor.ps1"
ps7$>  $env:v_mode_bClr = 'true'
ps7$>  $env:v_mode_bVbs = 'true'
ps7$>  $env:v_mode_iLog = '2'
ps7$> $env:v_mode_bClr='true'

====    color setzenv in der CMD
cmd$> set v_mode_bClr=true


=== encoding
    Dieses Dokument in :
    •   UTF8        :   https://en.wikipedia.org/wiki/UTF-8

    codiert wird in :
    •   ANSI-1252   :   https://en.wikipedia.org/wiki/Windows-1252

=== lint of python
    $>  ruff check y*.py
    url:    https://pypi.org/project/ruff/0.0.122/
    ruff is using the file:
        pyproject.toml

=== keyword::python
    and	        A logical operator
    as	        To create an alias
    assert	    For debugging
    break	    To break out of a loop
    class	    To define a class
    continue	To continue to the next iteration of a loop
    def	        To define a function
    del	        To delete an object
    elif	    Used in conditional statements, same as else if
    else	    Used in conditional statements
    except	    Used with exceptions, what to do when an exception occurs
    False	    Boolean value, result of comparison operations
    finally	    Used with exceptions, is an exception or not
    for	        To create a for loop
    from	    To import specific parts of a module
    global	    To declare a global variable
    if	        To make a conditional statement
    import	    To import a module
    in	        To check if a value is present in a list, tuple, etc.
    is	        To test if two variables are equal
    lambda	    To create an anonymous function
    None	    Represents a null value
    nonlocal	To declare a non-local variable
    not	        A logical operator
    or	        A logical operator
    pass	    A null statement, a statement that will do nothing
    raise	    To raise an exception
    return	    To exit a function and return a value
    True	    Boolean value, result of comparison operations
    try     	To make a try...except statement
    while	    To create a while loop
    with	    Used to simplify exception handling
    yield	    To end a function, returns a generator
<<< sum:33

=== colorMode

+   Die Farbe darf nicht vorab gesetzt werden,
        denn tron8 importiert NICHT das colormodule.
    Siehe in der Library Lib_inc.py ...
        import colorama
    Dadurch kann das Python-Tutorial per default nicht den
        Farben Mode.
    Sie kann aber durch
        $>_runY -Color
    aktiviert werden.

=== misc

+   Python 3.9.5

+   Codierung ultraEdit ANSI
    url: https://de.wikipedia.org/wiki/Windows-1252
    •   ANSI-1252-Latin entspricht  ISO 8859-1
        $80...9F    :   € ƒ … † ‡ ‰ ‹› • – — ™
        $A0...BF    :   ¡ ¢ £ ¥ ¦ § © ±  µ ¶ ½ ¼ ¾ « » ·
        $C0...FF    :   ÷  äöüÄÖÜß

+   Codierung ISO8859
    url: https://de.wikipedia.org/wiki/ISO_8859-1

+   !WEB:=webEntry

    http://www.python-kurs.eu/python3_kurs.php
    https://www.udacity.com/wiki/cs258/all-any
    https://py-tutorial-de.readthedocs.org/de/python-3.3/stdlib.html

+   !DCR:=decorators

    @staticMethod, @classMethod, @proPerty

+   !KEY:=keywords(25)

    assert, break, class, continue, def, del, elif, else, except
    finally, for, from, global, if, import, in, lambda
    pass, print, raise, return, try, while, with, yield (25)

+   !FCT:=used build-in functions(64)

    __import__                      :1
    abs, all, any,  ascii,          :4
    bin, bool, bytearray, bytes,                 :4
    callable, chr, classmethod, compile, complex    :5
    delattr, dict, dir, divmod                   :4
    enumerate, eval, exec               :3
    filter, float, format, frozenset             :4
    getattr, globals                    :2
    hasattr, hash, help, hex        :4
    id, input, int, isinstance, issubclass, iter  :6
    len, list, locals               :3
    map, max, memoryview, min       :4
    next                                :1
    object, oct, open, ord           :4
    pow, print, property             :3
    repr, reversed        :2
    set, setattr, slice, sorted, staticmethod, str, sum, super   :8
    range, round          :2
    tuple, type           :2
    vars            :1
    zip             :1

+   !MTD=Methods
    append,extend,pop,insert,remove,sort,
    join,reverse,index,sort,remove,count

+   !REM:
    bytes und bytearray verhalten sich gleich
    Anm: einige builtIn fctn sind nicht notwendig, bzw. ersetzbar
           format  => s.format
           sum     => list sum
           sorted  => list.sort


>python --help
usage: python [option] ... [-c cmd | -m mod | file | -] [arg] ...
Options and arguments (and corresponding environment variables):
-b     : issue warnings about str(bytes_instance), str(bytearray_instance)
         and comparing bytes/bytearray with str. (-bb: issue errors)
-B     : don't write .py[co] files on import; also PYTHONDONTWRITEBYTECODE=x
-c cmd : program passed in as string (terminates option list)
-d     : debug output from parser; also PYTHONDEBUG=x
-E     : ignore PYTHON* environment variables (such as PYTHONPATH)
-h     : print this help message and exit (also --help)
-i     : inspect interactively after running script; forces a prompt even
         if stdin does not appear to be a terminal; also PYTHONINSPECT=x
-I     : isolate Python from the user's environment (implies -E and -s)
-m mod : run library module as a script (terminates option list)
-O     : optimize generated bytecode slightly; also PYTHONOPTIMIZE=x
-OO    : remove doc-strings in addition to the -O optimizations
-q     : don't print version and copyright messages on interactive startup
-s     : don't add user site directory to sys.path; also PYTHONNOUSERSITE
-S     : don't imply 'import site' on initialization
-u     : unbuffered binary stdout and stderr, stdin always buffered;
         also PYTHONUNBUFFERED=x
         see man page for details on internal buffering relating to '-u'
-v     : verbose (trace import statements); also PYTHONVERBOSE=x
         can be supplied multiple times to increase verbosity
-V     : print the Python version number and exit (also --version)
-W arg : warning control; arg is action:message:category:module:lineno
         also PYTHONWARNINGS=arg
-x     : skip first line of source, allowing use of non-Unix forms of #!cmd
-X opt : set implementation-specific option
file   : program read from script file
-      : program read from stdin (default; interactive mode if a tty)
arg ...: arguments passed to program in sys.argv[1:]


# http://stackoverflow.com/questions/3987041/python-run-function-from-the-command-line
DOS>
With the -c (command) argument (assuming your file is named foo.py):
$ python -c 'import foo; print foo.hello()'

#   steht man auf d:\my\cmd\y
DOS> python -c "import myLib as m; m.F_version()"

#   Aufruf eines Python Scripts von DOS
DOS> python -c "import os; os.system('py hello.py')"
DOS> python -c "print('hello')"

#   ***************************************************************************
#   Python Shell bedienen
#   ***************************************************************************
DOS>Python
>>> import os
>>> os.chdir(r"d:\my\cmd\y")
>>> os.getcwd()
>>> import myLib as m
>>> import myLib as m
>>> g = m.CLib()
>>> m.F_version()
>>> g.f_sVersion()


python -c "import LIB_inc; print (" id := <%s> " %(g_xId) )


+   log
    16.10.2023