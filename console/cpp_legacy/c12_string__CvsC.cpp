//  ****************************************************************************
//  TUTORIAL:   C++     :   C- and C++-string
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$
/*
    content:
        •   m:  C89-String      <cstring.h>
            •   m:  strcpy      :   Copy string
            •   m:  strlen      :   Get string length
            •   m:  strcat      :   Concatenate strings
            •   m:  strcmp      :   Compare two strings
            •   m:  strncmp --- using: n
            •   m:  strncpy
            •   m:  strncat
            •   m:  strerror    :   Get pointer to error message string
            •   m:  perror      :   Print error message <stdio.h>
            •   m:  strchr      :   Locate first occurrence of character in string
            •   m:  strrchr     :   Locate last occurrence of character in string
            •   m:  strpbrk     :   Locate characters in string
            •   m:  strstr      :   Locate substring
            •   m:  strcspn     :   Get span until character in string
            •   m:  strspn      :   Get span of character set in string
            •   m:  strtok      :   Split string into tokens
            •   m:  memset      :   Fill block of memory
            •   m:  memcpy      :   Copy block of memory
            •   m:  memmove     :   Move block of memory
            •   m:  memchr      :   Locate character in block of memory
            sum=20 functions
        •   m:   C++-String
            •   m:  new string
            •       •   s:  empty   :string S
            •       •   s:  byChar* :string S("Text")
            •       •   s:  auto    :string S(10,'c')
            •   m:  assign
            •       •   s:  byChar
            •       •   s:  byChar*
                    •   s:  byConstructor string()
            •   m:  access
                    •   s:  byIndex
                    •   s:  .at
            •   m:  size
                    •   s:  .length
                    •   s:  .capacity
                    •   s:  .reserve
                    •   s:  .resize
                    •   s:  .max_size
            •   m:  conversion:C<=>C++
                    •   s:  conversion:   C++ => C
                    •   s:  conversion:   C => C++
            •   m:  compare
                    •   s:  by operator ==
                    •   s:  .compare
            •   m:  search
                    •   s:  .find
                    •   s:  .rfind
                    •   s:  .find_first_of
                    •   s:  .find_last_not_of
            •   m:  modify
                    •   s:  add
                    •   s:  .append
                    •   s:  concatenation
                    •   s:  .replace
                    •   s:  .substr
                    •   s:  .swap
                    •   s:  .erase
            sum=17 methods
    keywords:
        •   char
        •   string
    url:
        https://www.w3schools.com/cpp/cpp_strings.asp
        https://cplusplus.com/reference/string/string/
 */


#include "Tutor.h"
using namespace std;


//  using:<ctype.h>
int F__check_c89String(CTutor &m) {
    int             iEc = m.f_iEc();
    const char*     sHdr = "stringType[ANSI-C]";
    int             iRc;
    int             n;
    char            c,cRc,*pc;
    char            s1[20],s2[10];
    char            z = m.E_COLOR_GRAY;

    m.f_chapter(sHdr,__FILE__,__LINE__,true);
    m.f_text(z,"iEc =:  '%d'",iEc);

//  =:= m:  strcpy

    m.f_menu("strcpy",__LINE__);
    strcpy(s1,"ABCDE");
    strcpy(s2,"abcde");
    m.f_text(z,"s1 \t=:%s",s1);
    m.f_text(z,"s2 \t=:%s",s2);

//  =:= m:  strlen

    m.f_menu("strlen",__LINE__);
    iRc = strlen(s1);
    m.f_text(z,"s1.len \t=:%d",iRc);
    iRc = strlen(s2);
    m.f_text(z,"s2.len \t=:%d",iRc);

//  =:= m:  strcat

    m.f_menu("strcat",__LINE__);
    pc  = strcat(s1,s2);    // gnuC++:undefined msc:defined
    m.f_text(z,"strcat(s1,s2) => s1 \t=:%s",s1);

//  =:= m:  strcmp

    m.f_menu("strcmp",__LINE__);
    strcpy(s1,"ABCDE");
    m.f_text(z,"s1 \t=: '%s'",s1);
    m.f_text(z,"s2 \t=: '%s'",s2);

    m.f_subMenu("perform :: iRc = strcmp(s1,s2)...",__LINE__);
    iRc = strcmp(s1,s2);
    m.f_text(z,"s1(%s)==s2(%s) \t=:%d",s1,s2,iRc);     // -1
    strcpy(s2,s1);
    iRc = strcmp(s1,s2);
    m.f_text(z,"s1(%s)==s2(%s) \t=:%d",s1,s2,iRc);     // 0
    strcpy(s2,"ABCD");
    iRc = strcmp(s1,s2);
    m.f_text(z,"s1(%s)==s2(%s) \t=:%d",s1,s2,iRc);     // 1

//  &&& using N &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

//  =:= m:  strncmp

    m.f_menu("strncmp",__LINE__);
    n   = strlen(s2);
    iRc = strncmp(s1,s2,strlen(s2));
    m.f_text(z,"s1(%s)==s2(%s)<%d> \t=:%d",s1,s2,n,iRc);     // 0

//  =:= m:  strncpy

    m.f_menu("strncpy",__LINE__);
    strcpy(s1,"123456789");
    strcpy(s2,"abcde");
    m.f_text(z,"s1 \t=: '%s'",s1);
    m.f_text(z,"s2 \t=: '%s'",s2);

    m.f_subMenu("perform :: pc = strncpy(s1,s2,len(s2))...",__LINE__);
    pc = strncpy(s1,s2,strlen(s2));
    m.f_text(z,"s1 \t=: '%s'",s1);
    m.f_text(z,"*pc\t=:'%c'",*pc);

//  =:= m:  strncat

    m.f_menu("strncat",__LINE__);
#ifdef __USE_MEMSET_INIT
    memset(s1,0,sizeof(s1));
    memset(s2,0,sizeof(s2));
#endif
    strcpy(s1,"123456789");
    strcpy(s2,"abcde");
    m.f_text(z,"s1 \t=: '%s'",s1);
    m.f_text(z,"s2 \t=: '%s'",s2);
    m.f_subMenu("perform :: pc = strncat(s1,s2,len(s2))...",__LINE__);
    pc = strncat(s1,s2,strlen(s2));
    m.f_text(z,"s1 \t=: '%s'",s1);
    m.f_text(z,"*pc\t=:'%c'",*pc);

//  &&& special     &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

//  =:= m:  strerror

    m.f_menu("strerror",__LINE__);
    iRc = errno;  m.f_text(z,"errno =: '%d'",iRc);
    m.f_subMenu("use strerror",__LINE__);
    m.f_text(z,"strError =: '%s'",strerror(errno));
    m.f_text(z,"anyError =: '%s'",strerror(12345));

//  =:= m:  perror

    m.f_menu("perror",__LINE__);
    perror("AnyStuffError");

//  &&& parser    &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

//  =:= m:  strchr  :   char * strchr ( char * str, int character )

    m.f_menu("strchr",__LINE__);
    strcpy(s1,"ABCDEFGH$!abcdefgh$");
    m.f_text(z,"s1 \t=: '%s'",s1);
    c   = '$';
    cRc = '?';
    pc  = strchr(s1,c);
    if (pc != NULL) {
        cRc = *pc;
    }
    m.f_text(z,"pc = strchr(s1,'%c') \t =: (%p)->'%c' ",c,pc,cRc);
    //      calculate size
    n = pc - s1;
    m.f_text(z, "iSize \t =: '%d'; ", n);
    //      show string without c
    if (pc != NULL) {
        *pc = 0; // !PHA: output pointer points exactly to char 'c'
    }
    m.f_text(z, "*pc=0;  => s1 \t =: '%s' ", s1);
    //      unknown char => pc == NULL
    c = '*';
    pc = strchr(s1, c);
    cRc = '?';
    if (pc != NULL) {
        cRc = *pc;
    }
    m.f_text(z, "pc = strchr(s1,'%c') \t =: (%p)==NULL->'%c' ", c, pc,cRc);


//  =:= m:  strrchr :   char * strrchr ( char * str, int character )
    m.f_menu("strrchr",__LINE__);
    strcpy(s1, "ABCDEFGH$!abcdefgh$");
    m.f_text(z,"s1 \t=: '%s'",s1);
    pc = strrchr(s1,c);
    if (pc != NULL) {
        cRc = *pc;
    }
    m.f_text(z,"pc = strrchr(s1,'%c') \t =: (%p)->'%c' ",c,pc,cRc);
    n = pc - s1;
    m.f_text(z, "iSize \t =: '%d'; ", n);
    //  show string without c
    if (pc != NULL) {
        *pc = 0; // !PHA: output pointer points to char before 'c'
    }
    m.f_text(z, "*pc=0;  s1 \t =: '%s'; ",s1);

//  =:= m:  strpbrk :   char * strpbrk ( char * str1, const char * str2 )

    strcpy(s1, "ABCDEFGH$!abcdefgh$");
    m.f_menu("strpbrk",__LINE__);
    strcpy(s2,"$!x");
    m.f_text(z,"s1 \t=: '%s'",s1);
    m.f_text(z,"s2 \t=: '%s'",s2);
    pc = strpbrk(s1,s2);
    cRc = '?';
    if (pc != NULL) {
        cRc = *pc;
    }
    m.f_text(z,"pc = strpbrk(s1,s2) \t =: (%p)->'%c'",pc,cRc);

//  =:= m:  strstr  :   char * strstr ( char * str1, const char * str2 )

    m.f_menu("strstr",__LINE__);
    strcpy(s2,"$!");        // s2 has to be an exact substring of s1
    m.f_text(z,"s1 \t=: '%s'",s1);
    m.f_text(z,"s2 \t=: '%s'",s2);
    pc = strstr(s1,s2);
    cRc = '?';
    if (pc != NULL) {
        cRc = *pc;
    }
    m.f_text(z, "pc = strstr(s1,s2) \t =: (%p)->'%c'", pc, cRc);
    m.f_text(z, "*pc \t =: (%s)", pc);

//  =:= m:  strcspn :   size_t strcspn ( const char * str1, const char * str2 )

    m.f_menu("strcspn",__LINE__);
    strcpy(s2,"$!x");
    m.f_text(z,"s1 \t=: '%s'",s1);
    m.f_text(z,"s2 \t=: '%s'",s2);
    iRc = strcspn(s1,s2);
    m.f_text(z,"strcspn(s1,s2) \t =: '%d'",iRc);

//  =:= m:  strspn  :   size_t strspn ( const char * str1, const char * str2 )

    m.f_menu("strspn",__LINE__);
    strcpy(s1,"ABC123");
    strcpy(s2,"ABCDEFGH");
    m.f_text(z,"s1 \t=: '%s'",s1);
    m.f_text(z,"s2 \t=: '%s'",s2);
    iRc = strspn(s1,s2);
    m.f_text(z,"strspn(s1,s2) \t =: '%d'",iRc);

//  =:= m:  strtok  :  char * strtok ( char * str, const char * delimiters )

    m.f_menu("strtok",__LINE__);
    strcpy(s1,"ABCDE;FGH;!abc;de$");
    strcpy(s2,";");
    m.f_text(z,"s1 \t=: '%s'",s1);
    m.f_text(z,"s2 \t=: '%s'",s2);
    pc = strtok(s1,s2);
    for(int i=1; pc != NULL && i<10; i++ ) {
        m.f_text(z,"pc[%d] = strtok(s1,s2) \t =: '%s' ",i,pc);
        pc = strtok(NULL,s2);
    }

//  &&& memory  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

//  =:= m:  memset  :  void * memset ( void * ptr, int value, size_t num )

    m.f_menu("memset",__LINE__);
    memset(s1,'x',sizeof(s1));
    s1[sizeof(s1)-1] = 0;   // else no c-string
    m.f_text(z,"s1 \t=: '%s'",s1);

//  =:= m:  memcpy :  void * memcpy ( void * destination, const void * source, size_t num )

    m.f_menu("memcpy",__LINE__);
    strcpy(s1,"ABCDEFGH$!abcdefgh$");
    strcpy(s2,"123456789");
    n = 5;
    memcpy(s1,s2,n);
    m.f_text(z,"memcpy(s1,s2,%d) => \t=: '%s'",n,s1);

//  =:= m:  memmove :  void * memmove ( void * destination, const void * source, size_t num )

    m.f_menu("memmove",__LINE__);
    strcpy(s1,"ABCDEFGH$!abcdefgh$");
    m.f_text(z,"s1 \t=: '%s'",s1);
    n = 5;
    memmove(s1+10,s1+0,n);
    m.f_text(z,"s1 \t=: '%s'",s1);

//  =:= m:  memchr :  void * memchr ( void * ptr, int value, size_t num )

    m.f_menu("memchr",__LINE__);
    strcpy(s1,"ABCDEFGH$!abcdefgh$");
    m.f_text(z,"s1 \t=: '%s'",s1);
    c   = '$';
    n   = 10;
    pc  = (char*)memchr(s1,c,n);   // like : strchr(s1,c)
    m.f_text(z,"pc = memchr(s1,'%c',%d) \t =: (%p)->'%c' ",c,n,pc,*pc);

    m.f_trace("endOf:c89String",__FILE__,__LINE__);
    return iEc;

}

//  using:internal c++ class

int F__check_cppString(CTutor &m) {
    int             iEc = m.f_iEc();
    char            c, *pc;
    char            cBuffer[40];
    const char  *pcc;
    int             i,n;
    size_t          tSize;
    int             iRc;
    bool            bRc;
    string          s1, s2;
    string          tString;
    char            z = m.E_COLOR_GRAY;
    const char*     sHdr = "stringType[C++ C11]";

    m.f_chapter(sHdr,__FILE__,__LINE__,true);
    m.f_text(z,"iEc =:  '%d'",iEc);

//  =:= m:  new string

    m.f_menu("construct a string",__LINE__);

//  =:= s:  empty   :string S
    m.f_subMenu("Empty",__LINE__);
    string t1;      // empty
    m.f_text(z,"t1 := '%s'",t1.c_str());

//  =:= s:  byChar* :string S("Text")
    m.f_subMenu("ByChar",__LINE__);
    string t2("ByChar*");
    m.f_text(z,"t1 := '%s'",t2.c_str());

//  =:= s:  auto    :string S(10,'c')
    m.f_subMenu("AutoSize",__LINE__);
    string t3(20,'x');
    m.f_text(z,"t3 := '%s'",t3.c_str());

//  =:= m:  assign

    m.f_menu("assign to a string",__LINE__);

//  =:= s:  byChar
    m.f_subMenu("By a single char",__LINE__);
    tString = 'x';
    m.f_text(z,"assigned char    := '%s'",tString.c_str());

//  =:= s:  byChar*
    m.f_subMenu("By char *",__LINE__);
    tString = "Hello - I'm a c++ string";
    m.f_text(z,"assigned char *  := '%s'",tString.c_str());

//  =:= s:  byConstructor string()
    m.f_subMenu("ByConstructor",__LINE__);
    s1 = std::string("string ByConstructor") ;
    m.f_text(z,"C++String1  := '%s'",s1.c_str());

//  =:= m:  access

    m.f_menu("access",__LINE__);
    s1  = "ABCDEFGHJ";
    m.f_text(z,"s1 := %s",s1.c_str());

//  =:= s:  byIndex
    m.f_subMenu("by Index",__LINE__);
    n   = 5;
    c   = s1[n];    // undefined, if n to large
    m.f_text(z,"s1[%d]       =: '%c'",n,c);    // 'F'

//  =:= s:  .at
    m.f_subMenu("by method at()",__LINE__);
    c   = s1.at(n);
    m.f_text(z,"s1.at(%d)    =: '%c'",n,c);    // 'F'

    //  this access omits an exception
    m.f_subMenu("by method at with exception",__LINE__);
    n   = 99;

// !CRQ-240515:exc
    i = 0;
#if defined(__BORLANDC__) && defined(_DEBUG)
    i = 1;
#else
    i = 2;
    m.f_text(z,"--- try:beg");
    try {
        c   = s1.at(n);
        m.f_text(z,"reply1:s1.at(%d)    =: '%c'",n,c);
    }
    catch (exception& p_tEx) {        // iExc is known
        m.f_text(z,"reply2:s1.at(%d) => '%s'",n,p_tEx.what());

    }
    catch (...) {
        iRc = -(__LINE__);
        m.f_text(z,"reply3:s1.at(%d) => EXC:'%d':'%s'",n,iRc,strerror(errno));

    }
    m.f_text(z,"--- try:end");
#endif

//  =:= m:  size

    m.f_menu("handle stringSize",__LINE__);

//  =:= s:  .length
    m.f_subMenu("length",__LINE__);
    tString = "abcdefgh";
    s1  = tString;
    n   = s1.length();
    m.f_text(z,"'%s'.length() =: '%d'",s1.c_str(),n);

//  =:= s:  .capacity
    m.f_subMenu("capacity",__LINE__);
    tSize   = s1.capacity();
    m.f_text(z,"'s1'.capacity() =: '%llu'",tSize);  // 20

//  =:= s:  .reserve
    m.f_subMenu("reserve",__LINE__);
    i = 100;
    s1.reserve(i);
    m.f_text(z,"'s1'.reserve(%d)",i);
    tSize   = s1.capacity();
    m.f_text(z,"'s1'.capacity_after_reserve =: '%llu'",tSize);  // 100

//  =:= s:  .resize
    m.f_subMenu("resize",__LINE__);
    i = 125;
    s1.resize(i);
    m.f_text(z,"'s1'.resize(%d)",i);
    tSize   = s1.capacity();
    m.f_text(z,"'s1'.capacity_after_resize =: '%llu'",tSize);  // !200

//  =:= s:  .max_size
    m.f_subMenu("maxSize",__LINE__);
    tSize   = s1.max_size();
    m.f_text(z,"'s1'.max_size() =: '%llu'",tSize);  // 9223372036854775807

//  =:= m:  conversion:C<=>C++

    m.f_menu("conversion CString <=> C++String",__LINE__);

//  =:= s:  conversion:   C++ => C
    m.f_subMenu("C++ => C",__LINE__);
    s1      = "Hello - I was a C++ String!";
    pcc     = s1.c_str();     // must be const char *
    m.f_text(z,"C++2C String     =: '%s'",pcc);

//  =:= s:  conversion:   C => C++
    m.f_subMenu("C => C++",__LINE__);
    strcpy(cBuffer,"Hello - I was a native C String!");
    pc      = cBuffer;
    s1      = std::string(pc);  // C => C++ :   use C++ string constructor
    pcc     = s1.c_str();       // C++ => C :   no we need a const char *
    m.f_text(z,"C2C++ String     =: '%s'",pcc);

//  =:= m:  compare

    m.f_menu("compare",__LINE__);
    s1  = tString;
    s2  = s1;

//  =:= s:  by operator ==
    m.f_subMenu("by==",__LINE__);
    bRc = ( s1 == s2 );

    m.f_text(z,"s1 == s2 => (bool)%d",bRc);
    m.f_subMenu("byMethod",__LINE__);

//  =:= s:  .compare
    iRc = s1.compare(s2);
    m.f_text(z,"s1.compare(s2) => %d",iRc);

//  =:= m:  search

    m.f_menu("string search",__LINE__);
    s1  = "and the name of the rose.";
    m.f_text(z,"s1 := '%s'",s1.c_str());
    strcpy(cBuffer,"the");

//  =:= s:  .find
    m.f_subMenu("find",__LINE__);
    n   = s1.find(cBuffer);    // ==> 4
    m.f_text(z,"s1.find('%s') \t=: '%d'",cBuffer,n);

//  =:= s:  .rfind
    m.f_subMenu("rfind",__LINE__);
    n   = s1.rfind(cBuffer);    // ==> 16
    m.f_text(z,"s1.rfind('%s') \t=: '%d'",cBuffer,n);

//  =:= s:  .find_first_of
    //  url: https://cplusplus.com/reference/string/string/find_first_of/
    m.f_subMenu("find_first_of",__LINE__);

    s1  =   "Please, replace the vowels in this sentence by asterisks.";
    s2  =   "aeiou";
    iRc =   s1.find_first_of(s2);    // ==> 2
    m.f_text(z,"('%s').find_first_of('%s')\n\t=: '%d'",
        s1.c_str(),s2.c_str(),iRc);

    s1  =   "ABCExFG ABCDEFGHxK 12x34";
    s2  =   "x";
    i   =   0;
    iRc =   s1.find_first_of(s2,i);    // ==> 4
    m.f_text(z,"('%s').find_first_of('%s',%d)\n\t=: '%d'",
        s1.c_str(),s2.c_str(),i,iRc);

    i   =   iRc;
    iRc =   s1.find_first_of(s2,i);    // ==> 4 ?PHA: 16 sollte es sein
    m.f_text(z,"('%s').find_first_of('%s',%d)\n\t=: '%d'",
        s1.c_str(),s2.c_str(),i,iRc);

    i   =   99;
    iRc =   s1.find_first_of(s2,i);    // ==> -1
    m.f_text(z,"('%s').find_first_of('%s',%d)\n\t=: '%d'",
        s1.c_str(),s2.c_str(),i,iRc);

//  =:= s:  .find_last_not_of
    //  url: https://cplusplus.com/reference/string/string/find_first_of/
    m.f_subMenu("find_last_not_of",__LINE__);

    s1  =   "ABCExFG 12xxx";
    s2  =   "x";
    i   =   0;
    iRc =   s1.find_last_not_of(s2,i);    // ==> 0 ?PHA
    m.f_text(z,"('%s').find_last_not_of('%s',%d)\n\t=: '%d'",
        s1.c_str(),s2.c_str(),i,iRc);

//  =:= C:  modify  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

//  =:= m:  modify

    m.f_menu("modify",__LINE__);

//  =:= s:  add

    s1  = tString;
    s2  = "123456";
    m.f_text(z,"s1 := %s",s1.c_str());
    m.f_text(z,"s2 := %s",s2.c_str());

    m.f_subMenu("add",__LINE__);
    s1 = s1 + s2;
    m.f_text(z,"s1 := s1+s2 \t=: '%s'",s1.c_str());

    m.f_subMenu("add+=<string>",__LINE__);
    s1  = tString;
    s1 += s2;
    m.f_text(z,"s1 += s2 \t=: '%s'",s1.c_str());

    //  add Char
    m.f_subMenu("add+=<char>",__LINE__);
    s1  = tString;
    s1 += '$';
    m.f_text(z,"s1 += CCHar \t=: '%s'",s1.c_str());

    m.f_subMenu("add+=<charArray>",__LINE__);
    s1  = tString;
    s1 += "!Hello";
    m.f_text(z,"s1 += CString \t=: '%s'",s1.c_str());

//  =:= s:  .append
    m.f_subMenu("append",__LINE__);
    s1  = tString;
    m.f_text(z,"s1 := %s",s1.c_str());
    m.f_text(z,"s2 := %s",s2.c_str());
    s1.append(s2);
    m.f_text(z,"s1.append(s2) \t=: '%s'",s1.c_str());

//  =:= s:  concatenation
    m.f_subMenu("string concatenation",__LINE__);
    s1  = "Houseball";
    s2  = "123456";
    m.f_text(z,"s1 := %s",s1.c_str());
    m.f_text(z,"s2 := %s",s2.c_str());
    tString   =  s1 + ":" + s2 + ":XYZ";
    m.f_text(z,"s1+s2+... \t=: '%s'",tString.c_str());

//  =:= s:  .replace
    m.f_subMenu("replace",__LINE__);
    s1  =   "ABCDEFGHIJ";
    s2  =   "1234567890";
    m.f_text(z,"s1 := '%s'",s1.c_str());
    m.f_text(z,"s2 := '%s'",s2.c_str());
    i   =   2;  //  iPos
    n   =   3;  //  iNumber
    s1.replace( i, n, s2);
    m.f_text(z,"s1.replace(%d,%d,s2) \t=: '%s'",i,n,s1.c_str());

//  =:= s:  .substr
    m.f_subMenu("substr",__LINE__);
    m.f_text(z,"s1 := '%s'",s1.c_str());
    i   =   2;  //  iPos
    n   =   3;  //  iNumber
    s2  =   s1.substr( i, n);
    m.f_text(z,"s1.substr(%d,%d) \t=: '%s'",i,n,s2.c_str());

//  =:= m:  .erase
    m.f_subMenu("erase",__LINE__);
    s1  =   "ABCDEFGHIJ";
    m.f_text(z,"s1 := '%s'",s1.c_str());
    i   =   2;  //  iPos
    n   =   3;  //  iNumber
    s1.erase( i, n);
    m.f_text(z,"s1.erase(%d,%d) \t=: '%s'",i,n,s1.c_str());

//  =:= s:  .swap
    m.f_subMenu("swap",__LINE__);
    s1  = "Peter";
    s2  = "Harvey";
    m.f_text(z,"s1  =: '%s'",s1.c_str());
    m.f_text(z,"s2  =: '%s'",s2.c_str());
    m.f_text(z,"s1.swap(s2)...");
    s1.swap(s2);
    m.f_text(z,"s1  =: '%s'",s1.c_str());
    m.f_text(z,"s2  =: '%s'",s2.c_str());

    m.f_trace("endOf:cppString",__FILE__,__LINE__);
    return iEc;
}


int F12_string(CTutor &m) {

//  =:= b:  declare
    int             iEc, iRc;
    const char*     sHdr = "string";

//  =:= b:  header
    iRc = iEc =
    m.f_header(sHdr,__FILE__,__LINE__);

//  =:= b:  intro
    m.f_status();
    m.f_chapter(sHdr,__FILE__,__LINE__,true);

//  =:= M:  C89-String
    iRc = F__check_c89String(m);
    if (iRc != iEc) {
        return iRc;
    }

//  =:= M:  C++-String
    iRc = F__check_cppString(m);
    if (iRc != iEc) {
        return iRc;
    }

//  =:= b:  footer
    m.f_menu("end",__LINE__);
    m.f_footer(sHdr,__FILE__,__LINE__);
    return(iEc);

};


#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor  m;
    if (p_iArgs >= 2) {
        m.f_mode_color(true);
    }
    return F12_string(m);
}
#endif
