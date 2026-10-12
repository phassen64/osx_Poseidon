/*  ######################################################################## */
/*  09: System-Funktionen                                                    */
/*  ######################################################################## */

/*
    encoding: UTF-8
    !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ
*/

/*  --- Content:
 *  TIME & DATE             : time, localtime, clock, strftime
 *  RANDOM                  : srand,rand
 *  CHAR-test               : iscntrl, ispunct, isalpha, isnum
 *  CHAR-change             : tolower, toupper
 *  MALLOC                  : malloc, free, calloc, realloc
 *  MEMORY                  : memset, memcpy, memcmp, memmove
 *  STRING                  : strcpy, strcat, strcmp
 *  STRING-test             : strchr, strstr, strspn, strtok
 *  STRING-convert          : atof, atoi, atol, strtod, strol, sprintf
 *  SYSTEM                  : assert, abort, exit, system, signal
 *  ERROR Handling          : strerror, perror and errno
 *  LIMITs                  : CHAR_BIT, FLT_MAX,...
 *  MATHEMATIC              : abs, ceil, div, pow, sin
 */


#ifndef __USE_TUTOR__MAIN
    #define INC__TUTOR_LIBRARY
#endif
#include "c00_include.h"

#define C_FILE_NAME "TUTOR_FILE_SYS"

#if __NOTUSED
    #include    <stdio.h>       /* IO-funkionen         CPP: <iostream>  */
    #include    <time.h>        /* localtime():         CPP: <ctime>     */
    #include    <math.h>        /* mathematische Fktn   CPP <cmath>      */
    #include    <stdlib.h>      /* diverse, z.B. atof()           */
    #include    <ctype.h>       /* Macros zum Testen von Zeichen */
#endif

/* Eigene Includes, die unter '.' gesucht werden
 * Die Header-Datei deaktiviert m?gliche Warnings
 * bei der Windows-Compilierung
*/


/*
 * helper
 */

void myExit(void)
{
    printf("&&& : Here is myExit() [%s;%d] function.\n",__FILE__,__LINE__);
    printf("\tTIME=[%s] \n",F_TIME());
}

/*
 *  ***************************************************************************
 *  m: DateTime         <time.h>
 *  ***************************************************************************
 *  void    srand(unsigned int startNr);
 *  int     rand(void);

 *  clock_t         clock(void);                            # ret=<runningTime>
 *  struct lconv*   localeconv(void);                       # localInfo
 *  --- struct tm
 *  char*       asctime(const struct tm *ptr);              # asc time
 *  size_t      strftime(char* str,size_t maxSize,
 *                  ...char* fmt, const struct tm *time)    # ret=len
 *  --- struct time_t
 *  time_t      time(time_t *time)                          # currentTime
 *  char*       ctime(const time_t *time);                  # ret="weekday..."
 *  double      difftime(time_t time2, time_t time1);       # ret=time2-time1
 *  --- struct tm & time_t
 *  struct tm*  gmtime(const time_t *time);                 # get time
 *  struct tm*  localtime(const time_t *time)               # get loc time
 *  time_t      mktime(struct tm* time)                     # make time
 */

/*
 *  ---------------------------------------------------------------------------
 *  formats of strftime()
 *  ---------------------------------------------------------------------------
 *  %a      :   abbreviation for weekday name
 *  %A      :   weekday name
 *  %b      :   abbreviation month name
 *  %B      :   monthname
 *  %c      :   standard date-time str
 *  %C      :   last two of YYYY
 *  %d      :   day nr (1-31)
 *  %H      :   Hour(0-23)
 *  %l      :   hour(1-12)
 *  %j      :   dayNr in the year or julianDay (1-366)
 *  %m      :   month nr (1-12)
 *  %M      :   minute nr (0-59)
 *  %p      :   A.M. or P.M.
 *  %S      :   secondNr (0-59)
 *  %U      :   weekNr (0-53)
 *  %w      :   weekday nr (0-6,sunday==0)
 *  %x      :   standard date str
 *  %X      :   standard time str
 *  %y      :   year YY without century
 *  %Y      :   year YYYY
 *  %Z      :   name of the time zone
 *  %%      :   char '%'
 *  ---------------------------------------------------------------------------
*/

int F_mod_dateTime() {

    int             i;
    char            cFileDateStr[128];
    char            cFileTimeStr[128];
    char            cTimeStr[256];
    time_t          v_time_t;
    time_t          v2_time_t;
    struct  tm  *   p_tmCurTime;
    struct  tm  *   p_tmAnyTime;
    clock_t         v_clock_t;
    double          diffTimeVal;

    printf("\n&&& menu : DATE&TIME [%s;%d]\n\n",__FILE__,__LINE__);

    strcpy(cFileDateStr,__DATE__);
    strcpy(cFileTimeStr,__TIME__);
    printf("\tF_TIME()     :{%s}\n",F_TIME()); /* isMacro */
    printf("\tFileDateStr  :{%s}\n",cFileDateStr);
    printf("\tFileTimeStr  :{%s}\n",cFileTimeStr);

    /*  --- time() */
    /*  INITIALISE THE TIME
     *  get the current time
     */

    /*  --- ctime() */
    time(&v_time_t);
    printf("\tctime(&time_t)\t=: <%s>\n",ctime(&v_time_t));

    /*  --- asctime() */
    p_tmCurTime = localtime(&v_time_t);
    printf("\tasctime() \t=: <%s>\n",asctime(p_tmCurTime));

    /* use printf() to show date&time
     */
    printf("\tYear:%d\n",1900+p_tmCurTime->tm_year);
    printf("\tMonth:%d\n",1+p_tmCurTime->tm_mon);
    printf("\tWday:%d\n",1+p_tmCurTime->tm_wday);
    printf("\tHour.Minute:(%2.2d:%2.2d)\n",p_tmCurTime->tm_hour,p_tmCurTime->tm_min);

    /* use sprintf()
     */
    sprintf(cTimeStr,"DATE=%2.2d.%2.2d.%4.4d;TIME=%2.2d:%2.2d:%2.2d",
                     p_tmCurTime->tm_mday,
                     p_tmCurTime->tm_mon+1,
                     p_tmCurTime->tm_year+1900,
                     p_tmCurTime->tm_hour,
                     p_tmCurTime->tm_min,
                     p_tmCurTime->tm_sec);
    printf("\tsprintf.TIMESTR:<%s>\n",cTimeStr);


    /*  --- strftime() */
    i = strftime(
        cTimeStr,sizeof(cTimeStr),
        "DATE=%d.%m.%Y,TIME=%H:%M:%S",
        p_tmCurTime);
    printf("\t01: i=strftime(cStr); i=<%d>,\n\tcStr=<%s>\n",i,cTimeStr);

    i = strftime(
        cTimeStr,sizeof(cTimeStr),
        "LDATE:{%a.%b.%y},TYPE:{%p},ZONE:{%Z}",
        p_tmCurTime);
    printf("\t02: i=strftime(cStr); i=<%d>,\n\tcStr=<%s>\n",i,cTimeStr);

    i = strftime(
        cTimeStr,sizeof(cTimeStr),
        "std={%c};stdDATE:{%x},stdTIME:{%X}",
        p_tmCurTime);
    printf("\t03: i=strftime(cStr); i=<%d>,\n\tcStr=<%s>\n",i,cTimeStr);

    /*  --- clock() */
    v_clock_t = clock();
    assert(v_clock_t != -1);
    printf("\t--- clock()  =<%d>\n",(int)v_clock_t);
    printf("\tCLOCKS_PER_SEC  =<%d>\n",(int)CLOCKS_PER_SEC);
    printf("\tclock()/CLOCKS_PER_SEC  =<%e>\n",(float)v_clock_t/CLOCKS_PER_SEC);


    /* TRY TO GET A DIFFERENZ of times
     * USE file time to create a second time value
     * time() -> time_t
     * localtime(time_t) -> struct tm
     */

    time(&v2_time_t);
    p_tmAnyTime = localtime(&v2_time_t);    /* use curr time values */
    printf("\t... p_tmCurTime :%p\n",(unsigned char*)p_tmCurTime);
    printf("\t... p_tmAnyTime :%p\n",(unsigned char*)p_tmAnyTime);
                    /* ?== p_tmCurTime */

    /*  --- gmtime() */
    printf("--- gmtime()\n");
    p_tmAnyTime = gmtime(&v2_time_t);       /* use curr time values */
    printf("\t... p_tmAnyTime(gmtime) :%p\n",(unsigned char*)p_tmAnyTime);
                    /* ?== p_tmCurTime */

/*  ??????????????????????????????????????????????????????? */
/*  Die folgenden Aktionen klappen nicht,
    denn sowohl p_tmAnyTime als auch p_tmCurTime
    verweisen jetzt auf die gleich interne Struktur.
    Die Differenz ist folglich nicht definiert.
    work around: eventuell sub function verwenden
*/

    strcpy(cTimeStr,cFileTimeStr);      /* HH:MM:SS */

    i = strftime(
        cTimeStr,sizeof(cTimeStr),
        "DATE=%d.%m.%Y,TIME=%H:%M:%S",
        p_tmCurTime);
    printf("\t04: strftime(CURR) \n\t cStr=<%s>\n",cTimeStr); /* ?not saved*/

    i = strftime(
        cTimeStr,sizeof(cTimeStr),
        "DATE=%d.%m.%Y,TIME=%H:%M:%S",
        p_tmAnyTime);
    printf("\t05: strftime(ANY) \n\t  cStr=<%s>\n",cTimeStr);

    /*  --- mktime() */
    /*      create a new time struct */
    v2_time_t   = mktime(p_tmAnyTime);
    /*  --- difftime() */
    diffTimeVal = difftime(v2_time_t,v_time_t);
    printf("\tdiffTime: %f\n",diffTimeVal);

    return __LINE__;
}


/*
 *  ***************************************************************************
 *  m: RANDOM Funktionen       <stdlib.h>
 *  ***************************************************************************
 *  void    srand(unsigned int startNr);
 *  int     rand(void);
 */
int F_mod_random() {

    time_t          v_time_t;

    printf("\n&&& menu : RANDOM [%s;%d] \n\n",__FILE__,__LINE__);

    time(&v_time_t);

    printf("\t00:   srand(%ld)\n",(long int)v_time_t);
    srand((unsigned int)v_time_t);         /* srand() for init rand() */
    printf("\t01:   rand()  :%d\n",rand());
    printf("\t02:   rand()  :%d\n",rand());

    return __LINE__;
}


/*  ***************************************************************************
 *  m: CHAR-test Funktionen    <ctype.h>
 *  ***************************************************************************
 *  int is{cntrl,print,graph,punct,...} (int cChar);    #iRet={0:FALSE;1:TRUE}
 */

int F_mod_charTest() {

    int     i;
    char    testLine[] = "a+0; Az!";
    char *  pChar = testLine;
    char    c;

    printf("\n&&& menu : charTest [%s;%d] \n\n",__FILE__,__LINE__);

    for(i=0; *pChar != 0 ;i++, pChar++) {
        c = *pChar;
        printf("\tCHAR: '%c'   ::   ",c);
        if(iscntrl(c)){printf("CNT;");}
        if(isprint(c)){printf("PRN;");}
        if(isgraph(c)){printf("GPH;");}
        if(ispunct(c)){printf("PCT;");}
        if(isalpha(c)){printf("ALP;");}
        if(islower(c)){printf("LOW;");}
        if(isupper(c)){printf("UPP;");}
        if(isdigit(c)){printf("DEC;");}
        if(isxdigit(c)){printf("HEX;");}
        printf("\n");
    }
    return __LINE__;
}

/*  ***************************************************************************
 *  CHAR-change Funktionen    <ctype.h>
 *  ***************************************************************************
 *  int tolower(int cChar);     # iRet= {lower(cChar) | cChar}
 *  int toupper(int cChar);     # iRet= {upper(cChar) | cChar}
 */

int F_mod_charChange() {

    printf("\n&&& menu : charChange[ %s;%d] \n\n",__FILE__,__LINE__);

    char    cSign1 = 'a',
            cSign2 = 'B';

    printf("\t1: tolower('%c')=%c; tolower('%c')='%c'\n",
                cSign1,tolower(cSign1),cSign2,tolower(cSign2));
    printf("\t2: toupper('%c')=%c; toupper('%c')='%c'\n",
                cSign1,toupper(cSign1),cSign2,toupper(cSign2));

    return __LINE__;
}


/*
 *  ***************************************************************************
 *  MALLOC Funktionen
 *  ***************************************************************************
 *  void*   malloc(size_t memSize);
 *  void*   realloc(void *memPtr_old, size_t memSize_new);
 *  void*   calloc(size_t numMemBlocks, size_t memSize);
 *  void    free(void* memPtr);
 */

int F_mod_mallocTest() {

    printf("\n&&& menu : mallocTest[ %s;%d] \n\n",__FILE__,__LINE__);

    int     i;
    char    cFileName[256];
    void    *pDynBuffer1;
    void    *pDynBuffer2;
    void    *pDynBuffer3;
    FILE    *fp;
    struct  _sVal {
            int     m_id;
            char    m_name[20];
    } *psVal;
    int     lSize;
    int     iNr;

    /*  --- malloc */
    /*
     *  Der Buffer von 'malloc' ist nicht initialisiert !
     */
    printf("*** malloc\n");
    pDynBuffer1 = malloc(20);
    for(i=0; i<10; i++) {
        ((char*)(pDynBuffer1))[i] = (char)(0x41+i);
    }
    iNr = i;
    printf("\t malloc()     : <%p>\n",pDynBuffer1);
    printf("\t BUFFER       : <%s>\n",(char *)pDynBuffer1);

    /* --- realloc */
    printf("*** realloc\n");
    pDynBuffer2 = realloc(pDynBuffer1,40);
    for(i=0; i<10; i++) {
        ((char*)pDynBuffer2)[i+iNr] = (char)(0x61+i);
    }
    printf("\t realloc()    : <%p>\n",pDynBuffer2);
    printf("\t BUFFER       : <%s>\n",(char *)pDynBuffer2);

    /*  --- calloc */
    printf("*** calloc\n");
#if 0
    psVal = (struct _sVal *)(pDynBuffer3)   = calloc(3,sizeof(struct _sVal));
#endif
    pDynBuffer3 = calloc(3,sizeof(struct _sVal));
    printf("\t calloc() : <%p>\n",pDynBuffer3);
    psVal       = (struct   _sVal *)pDynBuffer3;
    psVal->m_id = 1;
    strcpy(psVal->m_name,"Erster");
    psVal++;
    psVal->m_id = 2;
    strcpy(psVal->m_name,"Zweiter");
    psVal++;
    psVal->m_id = 3;
    strcpy(psVal->m_name,"Dritter");

    /* save this struct into a bin file */
    printf("... save calloc struct into file\n");
    strcpy(cFileName,C_FILE_NAME);
    strcat(cFileName,".001.txt");       /* strcpy,strcat [c09] */
    fp      = fopen(cFileName,"wb+");   /* fileOpen : write,BINmode */
    assert(fp != 0);
    lSize = sizeof(struct _sVal);
    printf("\t sizeof(struct) :%d\n",lSize);
    psVal       = (struct   _sVal *)pDynBuffer3;
    for(i=0; i<3; i++,psVal++)
    {
        fwrite(psVal,sizeof(struct _sVal),1,fp);        /* 1 object */
    }
    assert(fclose(fp) == 0);
    printf("\t ... written file: %s\n",cFileName);

    /*  free */
    printf("*** free\n");

#ifdef CRQ240514        /* !CRQ */
    free(pDynBuffer1);
    free(pDynBuffer2);
    free(pDynBuffer3);
#endif

    return __LINE__;
}

/*
 *  ***************************************************************************
 *  MEMORY Funktionen   <string.h> {memset,memXcpy,memXcmp};X={[n]}
 *  ***************************************************************************
 *  ---     DESC:   bytes bearbeiten
 *                  Die Funktionen sind vom Typ
 *                  void * memX(void *obj,void *src,len)
 *                  Der Return-Wert ist void* obj.
 *  ---     FCT:
 *  void*   memset(void* obj, int c, size_t len);
 *  void*   memcpy(void* obj, const void* src, size_t len);
 *  void*   memmove(void* obj, const void* src, size_t len);
 *  void*   memcmp(const void* m1, const void* m2, size_t len);
 *  void*   memchr(const char* src, int c, size_t len);
 *
 */

int F_mod_memoryTest() {

    int             i;
    unsigned char   memBuf[] = {'A',5,9,0,'%','\\',' ','z','#','\0'};
    unsigned char   memSRC[] = "abcdefghij";
    unsigned char   memOBJ[20];
    void    *       memPtr;

    printf("\n&&& menu : memoryTest [%s;%d] \n\n",__FILE__,__LINE__);

    printf("\tBUF=<%s>\n",memBuf);
    printf("\tSRC=<%s>\n",memSRC);

    /* ---  void* memset(void* obj, int c, size_t len) */
    memset(memOBJ,'#',sizeof(memOBJ));
    printf("\tmemset(obj,'#',sizeof(obj))     : obj=<%s>\n",memOBJ);

    /* ---  void* memcpy(void* obj, const void* src, size_t len) */
    memcpy(memOBJ,memBuf,sizeof(memBuf));
    printf("\tmemcpy(obj,BUF,sizeof(BUF))     : obj=<%s>\n",memOBJ);

    memcpy(memOBJ,memSRC,sizeof(memSRC));
    printf("\tmemcpy(obj,src,sizeof(src))     : obj=<%s>\n",memOBJ);

    /* ---  void* memmove(void* obj, const void* src, size_t len) */
    /*      =~ memcpy, jedoch mit �berlappung von memSRC/OBJ */
    memmove(memOBJ,&(memOBJ[5]),sizeof(memSRC));
    printf("\tmemmove(obj,&obj[5],sizeof(src)): obj=<%s>\n",memOBJ);

    /* ---  void* memcmp(const void* m1, const void* m2, size_t len) */
    /*      =~ strncmp() */
    /*      m1<m2   => i<1
     *      m1==m2  => i=0
     *      m1>m2   => i>0
     */
    i = memcmp(memOBJ,memSRC,5);
    printf("\tmemSRC    = <%s>\n",memSRC);
    printf("\tmemOBJ    = <%s>\n",memOBJ);
    printf("\tmemcmp(src,obj,5): isEQU=<%d>\n",i);  /* == 1 ???*/

    /*  --- void * memchr(const char* src, int c, size_t len) */
    #ifdef  __cplusplus
        memPtr = memchr((void*)memBuf,9,sizeof(memBuf));
    #else
        memPtr = (void*)(memchr((const void*)memBuf,9,sizeof(memBuf)));
    /*  REM:    Eigentlich muesste kein typecast
                gemacht werden, aber ohne warning
     */
#endif
    printf("\tp = memchr(buf,'9',sizeof(buf)): p=<%p>\n",memPtr);

    return __LINE__;
}


/*
 *  ***************************************************************************
 *  STRING Funktionen   {strXcpy,strXcat,strXcmp,strLen};X={[n]} <string.h>
 *  ***************************************************************************
 *  ---     DESC:  Strings als ganzes ver�ndern oder vergleichen.
 *  int     strcpy  (const char *s1, const char *s2);
 *  int     strcmp  (const char *s1, const char *s2);
 *  int     strcat  (const char *s1, const char *s2);
 *  int     strcpy  (const char *s1, const char *s2, size_t copyLen);
 *  int     strncmp (const char *s1, const char *s2, size_t compareSize);
 *  int     strncat (const char *s1, const char *s2, size_t catSize);
 *  --- special str cmp
 *  int     strcoll (const char *s1, const char *s2);
 *          # strcmp with setlocale()
 *  int     strxfrm (const char *s1, const char *s2, size_t count);
 *          # format str for strcmp
 */

int F_mod_stringMake() {

    int  i;
    char strSRC[] = "ABCDEFGHIJ";
    char strOBJ[40] ;
    char strTMP[40]= "abc";
    const char*   strSRC_LOCAL = "abc����";
    const char*   strOBJ_LOCAL = "abc�";

    printf("\n&&& menu : stringMake [%s;%d] \n\n",__FILE__,__LINE__);


    printf("\tSRC=<%s>\n",strSRC);

    /* --- int strlen(char* src) */
    i = strlen(strSRC);
    printf("\tstrlen(src)         \n\t\t: len=%d\n",i);

    /* ---  char* strcpy(char* obj, const void* src) */
    memset(strOBJ,0,sizeof(strOBJ));
    strcpy(strOBJ,strSRC);
    printf("\tstrcpy(obj,src)     \n\t\t: obj=%s\n",strOBJ);

    /* ---  char* strncpy(char* obj, const void* src, size_t len) */
    memset(strOBJ,0,sizeof(strOBJ));
    strncpy(strOBJ,strSRC,5);
    printf("\tstrncpy(obj,src,5)  \n\t\t: obj=%s\n",strOBJ);

    /* ---  char* strcat(char* obj, const void* src) */
    strcat(strOBJ,strTMP);
    printf("\tstrcat(<%s>,src)    \n\t\t: obj1=%s\n",strTMP,strOBJ);
    strcpy(strTMP,strOBJ); /* save result */

    /* ---  char* strncat(char* obj, const void* src, size_t len) */
    strncat(strOBJ,strSRC,5);
    printf("\tstrncat(obj,src,5)  \n\t\t: obj3=%s\n",strOBJ);

    /* ---  int strcmp(const char* s1, const void* s2) */
    /*      s1<s2   => i<1
     *      s1==s2  => i=0
     *      s1>s2   => i>0
     */
    printf("\tSRC=<%s>\n",strSRC);
    printf("\tOBJ=<%s>\n",strOBJ);
    printf("\tTMP=<%s>\n",strTMP);
    i = strcmp(strTMP,strSRC);
    printf("\tstrcmp('%s','%s') \n\t\t: isEQU=<%d>\n",strTMP,strSRC,i);
    i = strcmp(strOBJ,strSRC);
    printf("\tstrcmp('%s','%s')   \n\t\t: isEQU=<%d>\n",strOBJ,strSRC,i);
    i = strcmp(strSRC,strOBJ);
    printf("\tstrcmp'%s','%s')   \n\t\t: isEQU=<%d>\n",strSRC,strOBJ,i);
    strcpy(strTMP,strSRC);
    i = strcmp(strSRC,strTMP);
    printf("\tstrcmp('%s','%s')   \n\t\t: isEQU=<%d>\n",strSRC,strTMP,i);

    /* ---  int strncmp(const char* s1, const void* s2, size_t len) */
    i = strncmp(strOBJ,strSRC,3);
    printf("\tstrncmp('%s','%s',3) \n\t\t: isEQU=<%d>\n",strOBJ,strSRC,i);


    printf("\n\t&&& String mit Umlauten [%s;%d]\n\n",__FILE__,__LINE__);

    /* ---  int strcoll(const char* s1, const void* s2, size_t len) */
    /*      ANM: wie strcmp() - nutzt jedoch setlocale() */
    /*      s1<s2   => i<1
     *      s1==s2  => i=0
     *      s1>s2   => i>0
     */

    printf("\tSRC_LOCAL=<%s>\n",strSRC_LOCAL);
    printf("\tOBJ_LOCAL=<%s>\n",strOBJ_LOCAL);
    i = strcoll(strOBJ,strSRC);
    printf("\tstrcoll(obj,src)  : isEQU=<%d>\n",i);

    /* i = strxfrm(char *s1, char *s2, size_t count); */
    #ifdef __cplusplus
        i = strxfrm(strTMP,
                    (const char *)F_STR(strSRC_LOCAL),
                    strlen(F_STR(strSRC_LOCAL)));
        // convert unsigned char[8] -> char *
    #else
        i = strxfrm((char *)strTMP,(const char *)&(strSRC_LOCAL[0]),strlen(strSRC_LOCAL));
    #endif
    printf("\tstrxfrm(tmp,src,4)    : i=<%d>;tmp=<%s>\n",i,strTMP);

    return __LINE__;
}


/*
 *  ***************************************************************************
 *  STRING-test Funktionen          <string.h>
 *  ***************************************************************************
 *  char*   strchr(const char* str, int cPat);     # sRet=first(cPat)
 *  char*   strrchr(const char* str, int cPat);     # sRet=last(cPat)
 *  size_t  strspn(const char* s1, const char* s2); # iRet=len(s1_IN_s2)
 *  size_t  strcspn(const char* s1, const char* s2); # iRet=len(s1_NOT_IN_s2)
 *  char*   strstr(const char *s1, const char* s2); # sRet=first(s1=s2)
 *  char*   strpbrk(const char* sPat1, const char* sPat2); # sRet=first(s1=s2)
 *  char*   strtok(char *s1, const char *s2Token);  # sRet=ptr2s1;s1==s2Token
 *  --- content:
 *      strchr,strrchr      : char seek
 *      strstr              : strSeek
 *      strspn,strcspn      : strSeek, get Position
 *      strbbrk, strtok     : token seek (7)
 */

int F_mod_stringTest() {

/*  int     i; */
    char    strPAT[]       = "ABCDEFGHIJabcdefghij";
    size_t  len;
    char    strTXT[]       = "Text;mit;verschie-denen#Trenner Zeichen.";
    char    sTOKEN[]       = ".;#- ";
#ifdef CRQ240514  /* !CRQ */
    char    strTXT1[40],
            strTXT2[40];
#endif
    char    testLine[] = "a+0; Az!";
    char *  pChar = testLine;

    printf("\n&&& menu : stringTest [%s;%d] \n\n",__FILE__,__LINE__);

    printf("\n\tsrc=<%s>\n",strPAT);
    /* ---  char* strchr(const char* src, int c) */
    /*      get left char */
    pChar = strchr(strPAT,'A');
    printf("\tstrchr(src,'A') \n\t\t: pc=<%p>\n",pChar);

    /* ---  char* strrchr(const char* src, int c) */
    /*      get right char */
    pChar = strrchr(strPAT,'A');
    printf("\tstrrchr(src,'A') \n\t\t: pc=<%p>\n",pChar);

    /* ---  int strstr(const char* src, const char* obj) */
    /*      has s1 a copy of s2 inside ? */
    pChar = strstr(strPAT,"abc");
    printf("\tstrstr(src,\"abc\") \n\t\t: pc=<%p>\n",pChar);
    printf("\t\t: *pc=<%c>\n",*pChar);

    /* ---  int strspn(const char* src, const char* obj) */
    /*      how many chars fit in obj starting left ? */
    len = strspn(strPAT,"XACB");
    printf("\tstrspn(src,\"XACB\") \n\t\t: len=<%d>\n",(int)len);

    /* ---  int strcspn(const char* src, const char* obj) */
    /*      how many chars fit >not< in obj starting left ? */
    len = strcspn(strPAT,"ab");
    printf("\tstrcspn(src,\"ab\")\n\t\t: len=<%d>\n",(int)len);

    /* ---  char* strpbrk(const char* src, const char* obj) */
    /*      where is in src >1 char< of obj starting left ? */
    pChar = strpbrk(strPAT,"ab");
    printf("\tstrpbrk(src,\"ab\")\n\t\t: pc=<%p>\n",pChar);

    /* ---  char* strtok(char* src, const char* obj) */
    /*      where is in src >1 str< of obj first time ? */

#ifdef CRQ240514  /* !CRQ */
    /* strtok l?scht strTXT, daher brauchen wir
         * f?r jeden Test eine neue Zeichenkette
         */
    strcpy(strTXT1,strTXT);
    strcpy(strTXT2,strTXT);

    /*      1.ter TEST    */
    #ifdef  __cplusplus
        pChar = strtok(strTXT1,";#.");
    #else
        pChar = (char *)(strtok(strTXT1,";"));
    #endif
    printf("\tstrtok(%s,\";\") \n\t\t: pc=<%s>\n",strTXT,pChar);

    /* 2.ter TEST */
    printf("\tstrtok(\"%s\",\"%s\")  :\n",strTXT,sTOKEN);
    pChar = (char*)(strtok(strTXT2,sTOKEN));
    for (i=1; pChar != NULL && i<=10; i++)
    {
        printf ("\t\t token[%d]:'%s'\n",i,pChar);
        pChar = (char*)(strtok(NULL,sTOKEN));
    }
#endif

    return __LINE__;
}


/*
 *  ***************************************************************************
 *  STRING-convert Funktionen
 *  a)  CHAR                ->      INT/FLOAT/DOUBLE       <stdlib.h>
 *  b)  INT/FLOAT/DOUBLE    ->      CHAR            <string.h>
 *  ***************************************************************************
 *  FCT::
 *  double              atof    (const char *str);
 *  int                 atoi    (const char *str);
 *  long int            atol    (const char* str);
 *  double              strtod  (const char* start, char** end);
 *  long int            strtol  (const char* start, char** end, int radix);
 *  unsigned long int   strtoul (const char* start, char** end, int radix);
 *  -   end         : zeigt hinter dem Zahlenwert im Str '100.0DM' -> 'DM'
 *  -   radix [2;36]: ist Zahlenbasis
 *  ---------------------------------------------------------------------------
 *  atof, atol, atoi,           : string->zahl
 *  strtod, strol, strtoul      : string->zahl
 *  sprintf                     : zahl  ->string
 */

int F_mod_stringConvert () {


    printf("\n&&& menu : stringConvert [%s;%d] \n\n",__FILE__,__LINE__);

    char    sWert[]="-123.2345678";
    char    sWert1[]="-9876";
    char    sWert2[]="-12345678";
    char    sWertx[]="   -123.45678 float Zahl";
    char    sWerty[]="   -ACDC hexZahl";
    char    sWertz[]=" 7654321LONG";
    char    *pcWert;
    char    sWertStr[80];
    int     iBase;
    double  dWert;
    int     iWert;
    long int   lWert;
    unsigned long int   ulWert;

    printf("\n\t&&& atoX functions [%s;%d]\n",__FILE__,__LINE__);

    dWert   = atof(sWert);
    printf("\tatof(\"%s\")    \t=:  %f\n",sWert,dWert);

    iWert   = atoi(sWert1);
    printf("\tatoi(\"%s\")    \t=:  %i\n",sWert1,iWert);

    lWert   = atol(sWert2);
    printf("\tatol(\"%s\")    \t=:  %ld\n",sWert2,lWert);


    printf("\n\t&&& strtoX functions [%s;%d]\n",__FILE__,__LINE__);

    /*
     * Diese Funktionen wandeln nicht nur von STRING nach zahl,
     * sondern geben auch die chrPtr Position hinter den gelesenen
     * Zahlen aus.
     * Ferner bieten die 'stro(u)l' Funktionen die M?glichkeit,
     * andere Zahlen-Formate umzuwandeln.
     */

    dWert   = strtod(sWertx,&pcWert);
    printf("\tstrtod(\"%s\") \n\t\t=:  {%f;'%s'}\n",sWertx,dWert,pcWert);
    /* error(strtod):=> result={HUGE_VAL} and errno={ERANGE} */

    iBase   = 16;       /* 2...36 */
    lWert   = strtol(sWerty,&pcWert,iBase);
    printf("\tstrtol(\"%s\"(16),%d)      \n\t\t=: {%ld;'%s'}\n",
                sWerty,iBase,lWert,pcWert);
    /* error(strtol):=> result={LONG_MAX|LONG_MIN} and errno={ERANGE} */

    iBase   = 8;       /* 2...36 */
    ulWert   = strtoul(sWertz,&pcWert,iBase);
    printf("\tstrtoul(\"%s\"(8),%d)     \n\t\t=:  {%ld,'%s'}\n",
            sWertz,iBase,ulWert,pcWert);
    /* if (strtol() == error) :=> result={ULONG_MAX} and errno={ERANGE} */


    printf("\n\t&&& sprintf : zahl->STRING  [%s;%d]\n",__FILE__,__LINE__);
    /*
     *  sprintf
     */
    sprintf(sWertStr,"%f",dWert);
    printf("\tstring1(%f)  \t=: \"%s\"\n",dWert,sWertStr);
    sprintf(sWertStr,"%i",iWert);
    printf("\tstring2(%i)  \t=: \"%s\"\n",iWert,sWertStr);
    sprintf(sWertStr,"%ld",lWert);
    printf("\tstring2(%ld)  \t=: \"%s\"\n",lWert,sWertStr);
    sprintf(sWertStr,"%lu",ulWert);
    printf("\tstring2(%lu)  \t=: \"%s\"\n",ulWert,sWertStr);

    return __LINE__ ;
}


/*
 *  ***************************************************************************
 *  ENVIRONMENT functions
 *  ***************************************************************************
 *  ---     EXIT handling
 *  void    assert(int expression);
 *  void    abort(void);
 *  int     atexit(void (*fct)(void));
 *  void    exit(int exit_code);
 *  ---     OS ENVIRONMENT
 *  char*   getenv(const char *name);
 *  int     system(const char *sysCmd);
 *  ---     JUMP between fctn
 *  void    longjmp(jmp_buf, int status);
 *  int     setjmp(jmp_buf envBuf);
 *  ---     SIGNAL handling
 *  int     raise(int signal);
 *  void    (*signal(int signal, void(*fct)(int)))(int);
 */

int F_mod_envTest() {

    int         i=99;
    jmp_buf     jmpBuffer;
    char    *   envStr;

    printf("\n&&& menu : environmentTest [%s;%d] \n\n",__FILE__,__LINE__);


    /* ---  atexit */
    /*  springt zur exit function und kehrt zur�ck
        Die Exi-Funktion wird erst nach dem Ende von main
        aufgerufen
        */
    i   = atexit(myExit);
    printf("\n\t&&& atexit(myExit())  :<%d>\n",i);

    /* ---  setjmp / longjmp */
    printf("\n\t&&& setjmp() / longjmp()\n");
    /*
     *  In diesem Beispiel werden die jmp-Befehle
     *  wie GOTO verwendet.
     *  Es klappt aber auch mit verschiedenen Funktionen
     */
    i   = -1;
    i   = setjmp(jmpBuffer);  /* LABEL L1 */
    printf("\t--- i=setjmp(jmpBuffer)  =:<%d>\n",i);    /* 0,1,2 */
    i ++;
    if (i < 3) {
        printf("\t\t::longjmp(jmpBuffer,%d)\n",i);
        longjmp(jmpBuffer,i);   /* GOTO label L1 */
    }


    /* getenv */
    printf("\n\t&&& getenv\n");
    envStr  = getenv("path");
    printf("\tPATH=getenv(\"path\")... \n");
    if (envStr != NULL) {
        printf("\t<<< PATH::<%s>\n",envStr);
    } else {
        printf("\t<<< PATH == 0\n");
    };

    return __LINE__;
}


/*
 *  ***************************************************************************
 *  ERROR HANDLING (ERRNO)              <errno.h>
 *  ***************************************************************************
 */
 /*
  *     strerror()          <string.h>
  *     errno....           <errno.h>
  *     perror()
  */

int F_mod_errorHandling() {

    goto l_errorHandling;

    int     i;
    char    sError[256];

l_errorHandling:
    printf("\n&&& menu : errorHandling [%s;%d] \n\n",__FILE__,__LINE__);

#ifndef  __cplusplus
    char    errStr[]="Fehlertext";
    strcpy(errStr,"Fehler");

    /* ---  char* strerror(int iErrorNr) */
    printf("\t--- strerror()\n");
    for(i=0; i<10; i++) {
        printf("\t\tstrerror(%d) =:<%s>\n",i,strerror(i));
    }

    printf("\t--- perror()\n");
    memset(sError,0,sizeof(sError));
    sprintf(sError,"\t\tOK: perror[%s,%d]",__FILE__,__LINE__);

#if 0
    /*  --- void perror(const char *s) */
    for(i=0; i<5; i++) { /* print 5 errors */
        errno = i;      /* set global var errno */
        printf("\perror(errno=%d):...\n",i);
        perror(errStr); /* is void function */
    };
#endif

#endif

    return __LINE__;
}


/*
 *  ***************************************************************************
 *  WERTGRENZEN       <limits.h> und <float.h>
 *  ***************************************************************************
 */

int F_mod_limitTest() {

    printf("\n&&& menu : limitTest [%s;%d] \n\n",__FILE__,__LINE__);

    printf("\n\t*** Integer [%s;%d]\n",__FILE__,__LINE__);

    printf("\tCHAR_BIT    : %d\n",CHAR_BIT);
    printf("\tCHAR_MAX    : %d\n",CHAR_MAX);
    printf("\tCHAR_MIN    : %d\n",CHAR_MIN);
    printf("\tSCHAR_MAX   : %d\n",SCHAR_MAX);
    printf("\tSCHAR_MIN   : %d\n",SCHAR_MIN);
    printf("\tINT_MAX     : %ld\n",INT_MAX);
    printf("\tINT_MIN     : %ld\n",INT_MIN);
    printf("\tSHRT_MAX    : %d\n",SHRT_MAX);
    printf("\tSHRT_MIN    : %d\n",SHRT_MIN);
    printf("\tLONG_MAX    : %ld\n",LONG_MAX);
    printf("\tLONG_MIN    : %ld\n",LONG_MIN);

    printf("\tUCHAR_MAX   : %d\n",UCHAR_MAX);
    printf("\tUSHRT_MAX   : %d\n",USHRT_MAX);
    printf("\tUINT_MAX    : %u\n",UINT_MAX);   /* !CRQ-240515:RAD warning*/
    printf("\tULONG_MAX   : %ld\n",ULONG_MAX);

    printf("\n\t*** Float&Double [%s;%d]\n",__FILE__,__LINE__);

    printf("\tFLT_MAX     : %g\n",FLT_MAX);
    printf("\tFLT_MIN     : %g\n",FLT_MIN);
    printf("\tFLT_MANT_DIG: %d\n",FLT_MANT_DIG);  /* flt mantisse */
    printf("\tFLT_MAX_EXP : %d\n",FLT_MAX_EXP);
    printf("\tFLT_MIN_EXP : %d\n",FLT_MIN_EXP);
    printf("\tFLT_DIG     : %d\n",FLT_DIG);
    printf("\tFLT_EPSILON : %g\n",FLT_EPSILON);
    printf("\tFLT_RADIX   : %d\n",FLT_RADIX);     /* basis_exp */
    printf("\tFLT_ROUNDS  : %d\n",FLT_ROUNDS);

    printf("\tDBL_MAX     : %g\n",DBL_MAX);
    printf("\tDBL_MIN     : %g\n",DBL_MIN);
    printf("\tDBL_MANT_DIG: %d\n",DBL_MANT_DIG);
    printf("\tDBL_MAX_EXP : %d\n",DBL_MAX_EXP);
    printf("\tDBL_MIN_EXP : %d\n",DBL_MIN_EXP);
    printf("\tDBL_DIG     : %d\n",DBL_DIG);
    printf("\tDBL_EPSILON : %g\n",DBL_EPSILON);

    return __LINE__;
}

/*
 *  ***************************************************************************
 *  MATHEMATISCHE Funktionen <math.h>
 *  ***************************************************************************
 */

int F_mod_mathTest() {

    int         i;
    double      dBase,dExp;
    double      dFrac,dMant;
    double      dVal1,dVal2;
    double      dSum;
    int         iVal1,iVal2;
    int         iSum;
    long int    liVal1,liVal2;
    div_t       tDiv;
    ldiv_t      l_tDiv;

    printf("\n&&& menu : mathTest [%s;%d] \n\n",__FILE__,__LINE__);

    iVal1    =   -981;
    iSum    =   abs(iVal1);
    printf("\tabs()     :: FCT(%d) =: %d\n", iVal1,iSum);

    iVal1   =   13;
    iVal2   =   3;
    tDiv    =   div(iVal1,iVal2);
    printf("\tdiv(x,y)  :: FCT(%d,%d) =: (%d,%d)\n",
                                iVal1,iVal2,tDiv.quot,tDiv.rem);
    liVal1  =   1234567890;
    liVal2  =   91;
    l_tDiv  =   ldiv(liVal1,liVal2);
    printf("\tldiv(x,y) :: FCT(%ld,%ld) =: (%ld,%ld)\n",
                                liVal1,liVal2,l_tDiv.quot,l_tDiv.rem);

    dBase   =   -981.321;
    dFrac   =   modf(dBase,&dMant);
    printf("\tmodf()    :: FCT(%f,&d) == (%f,%f) = :%f\n", dBase,dBase,dMant,dFrac);

    dVal1   =   12.125;
    dSum    =   frexp(dVal1,&i);
    printf("\tfrexp()   :: FCT(%f,&i)    == (%f,%i) =: %f\n", dVal1,dVal1,i,dSum);

    dBase   =   -981.321;
    dSum   =   fabs(dBase);
    printf("\tfabs()    :: FCT(%f) =: (%f)\n", dBase,dSum);

/*  gcc has not ceil etc */
#if defined(__cplusplus) || defined (_MSC_VER_)
        printf("\tVERSION:C++ || MSVER'\n");
#else
        printf("\tVERSION:gcc\n");
        return __LINE__;
#endif

    dBase   =   -981.321;
    dSum    =   ceil(dBase);
    printf("\tceil()    :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   981.321;
    dSum    =   ceil(dBase);
    printf("\tceil()    :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   -981.321;
    dSum    =   floor(dBase);
    printf("\tfloor()   :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   981.321;
    dSum    =   floor(dBase);
    printf("\tfloor()   :: FCT(%f) =: %f\n", dBase,dSum);


    dVal1   =   12.125;
    dVal2   =   3.425;
    dSum    =   fmod(dVal1,dVal2);
    printf("\tfmod()    :: FCT(%f,%f) =: %f\n", dVal1,dVal2,dSum);

    dBase   =   1.3;
    dExp    =   4.1;
    dSum    =   pow(dBase,dExp);
    printf("\tpow()     :: FCT(%f,%f) =: %f\n", dBase,dExp,dSum);

    dBase   =   100.10;
    dSum    =   log10(dBase);
    printf("\tlog10()   :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   4.5;
    dSum    =   exp(dBase);
    printf("\texp()     :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   100.10;
    dSum    =   log(dBase);
    printf("\tlog()     :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   100.10;
    dSum    =   sqrt(dBase);
    printf("\tsqrt()    :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   C_PI/2;
    dSum    =   sin(dBase);
    printf("\tsin()[RAD]    :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   30;
    dSum    =   cos(dBase);
    printf("\tcos()[RAD]    :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   30;
    dSum    =   tan(dBase);
    printf("\ttan()[RAD]    :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   0.5;
    dSum    =   asin(dBase);
    printf("\tasin()[RAD]   :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   0.5;
    dSum    =   acos(dBase);
    printf("\tacos()[RAD]   :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   0.5;
    dSum    =   atan(dBase);
    printf("\tatan()[RAD]   :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   C_E/2;
    dSum    =   sinh(dBase);    /* 0.5 * (e ** x - e ** -x) */
    printf("\tsinh()[RAD]   :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   C_E/2;
    dSum    =   cosh(dBase);   /* 0.5 * (e ** x + e ** -x) */
    printf("\tcosh()[RAD]   :: FCT(%f) =: %f\n", dBase,dSum);

    dBase   =   C_E/2;
    dSum    =   tanh(dBase);
    printf("\ttanh()[RAD]   :: FCT(%f) =: %f\n", dBase,dSum);

    return __LINE__;
}

/*
 *  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
 *  m:body
 *  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
*/

#define F_CHK()   { \
    if ( iRc < 0) { \
        printf("?Code:%d at:[%d]",(iRc),(__LINE__)); return(iRc); } }

int F09_system(int p_iEc)
{
    int iRc;

    printf("=== system functions\n");

    printf("\tcompiled:\n");
    printf("\tDATE=(%s;%s)\n",__DATE__,__TIME__);
    printf("\tFILE:[%s;%d]\n", __FILE__,__LINE__);

    #ifdef  __cplusplus
        printf("\t### isC++:=YES\n");
    #else
        printf("\t### isC++:=NO !\n");
    #endif


    /*  subfunction call */

    printf("\n\ts:call subfunction...\n");

    iRc = F_mod_dateTime();     printf("\n\tRC.dateTime         =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_random();       printf("\n\tRC.random           =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_charTest();     printf("\n\tRC.charTest         =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_charChange();   printf("\n\tRC.charChange       =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_mallocTest();   printf("\n\tRC.malloc           =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_memoryTest();   printf("\n\tRC.memory           =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_stringMake();   printf("\n\tRC.stringMake       =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_stringTest();   printf("\n\tRC.stringTest       =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_stringConvert();printf("\n\tRC.stringConvert    =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_envTest();      printf("\n\tRC.envTest          =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_errorHandling();printf("\n\tRC.errorHandling    =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_limitTest();    printf("\n\tRC.limitTest        =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_mathTest();     printf("\n\tRC.mathTest         =: <%d>\n",iRc); F_CHK();


    printf("\n\n\n--- EndOfFile:[%s] at LineNr:[%d] \n",__FILE__,__LINE__);
    return(p_iEc);

} /* main */



/*  ######################################################################## */
/*	main */
/*  ######################################################################## */

#ifndef __USE_TUTOR__MAIN
int main(int args, char *argv[]) {
    int     iEc = atoi(getenv("v_FWK_exitCode"));
    return  F09_system(iEc);
}
#endif
