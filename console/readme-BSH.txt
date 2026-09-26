=== Version
    2022 && 2024

=== Encoding
    Dieses File in
        •   UTF8
    die Source Files in :
        •   ANSI-1252

=== Encoding.links
    UTF8        :   https://en.wikipedia.org/wiki/UTF-8
    ANSI-1250   :   https://en.wikipedia.org/wiki/Windows-1250
    ANSI-1252   :   https://en.wikipedia.org/wiki/Windows-1252
    ISO-8859    :   https://en.wikipedia.org/wiki/ISO/IEC_8859-2

=== Readme HowTo

    https://www.tldp.org/LDP/Bash-Beginners-Guide/html/
    https://www.tutorialkart.com/bash-shell-scripting/bash-tutorial/
    https://www.tutorialkart.com/bash-shell-scripting/bash-read-file-examples/
    https://ryanstutorials.net/bash-scripting-tutorial/
    https://linuxconfig.org/bash-scripting-tutorial
    https://wiki.ubuntuusers.de/Shell/Bash-Skripting-Guide_f%C3%BCr_Anf%C3%A4nger/
    http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html:OK
    https://linuxhint.com/bash_scripting_tutorial_beginners/
    https://www.ernstlx.com/linux90bash.html : gut


=== Readme Ubtuntu/WSL

+	Start des Environments
	Auf $HOME eingeben
		bsh>+
	Dadurch wird das Alias '+' verwendet, welches
		in .bashrc
		das $HOME/PROFILE.bsh
    lädt.
	Nach der Ausführung des Alias, steht man im Verzeichnis
		D:\my\cmd\bsh

+	Files auf $HOME
		.bashrc
		.vimrc
		PROFILE.bsh
	Dieses Files werden zusätzlich in d:\my\cmd\bsh gespeichert

+	REM: das FILE .vimrc verhindert den color-mode

+   Credentials
    USR:peter PWD:peter|tron

+   TestMe
    return 0:true, 1:false
    $> test A = B       *   string compare
    $> test a -eq b     *   numerical test
    testMe
    #   0==true
    #   1==f

