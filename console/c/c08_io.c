/*  ######################################################################## */
/*  08: I/O  für stdout und FILEs  [2024]                                    */
/*  ######################################################################## */
/*
    encoding: UTF-8
    !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ
*/
/*
 *  --- Content:
 *  std IN:3
 *          void    scanf(char* fmt,arg1,...);
 *          int     getchar();
 *          char*   gets(char* str);
 *  std OUT:5
 *          void    printf(char* fmt,arg1,...);
 *          void    vprintf(char* fmt,va_list args);
 *          int     putchar(int c);
 *          int     puts(char *str);
 *          void    perror(const char* str);
 *  STRING:3
 *          int     sprintf(const char* str, const char* fmt,...);
 *          int     vsprintf(const char* str, const char* fmt,va_list args);
 *          int     sscanf(const char* str, const char* fmt,...);
 *  FILE access:3
 *          FILE*   fopen(const char* fname,const char* mode);
 *          FILE*   freopen(const char* fname,const char* mode,FILE* fpOld);
 *          int     fclose(FILE *fp);
 *  FILE write:7
 *          int     putc(int c,FILE* fp);       * MACRO to fputc()
 *          int     fputc(int c,FILE* fp);
 *          int     fputs(char *, FILE *)
 *          int     fprintf(FILE* fp,const char* fmt,...);
 *          int     vfprintf(FILE* fp,const char* fmt,va_list args);
 *          size_t  fwrite(const void* buf,size_t iLen,size_t count,FILE* fp);
 *          int     fflush(FILE* fp);
 *  FILE read:6
 *          int     getc(FILE* fp);             * MACRO to fgetc()
 *          int     fgetc(FILE* fp);
 *          char*   fgets(char *str,int len,FILE *fp);
 *          int     fscanf(FILE* fp, const char* fmt,...);
 *          int     ungetc(int c,FILE* fp);
 *          size_t  fread(void* buf,size_t iLen,size_t count,FILE* fp);
 *  FILE error:3
 *          void    clearerr(FILE* fp);
 *          int     feof(FILE* fp);
 *          int     ferror(FILE* fp);
 *  FILE seek:5
 *          int     fgetpos(FILE* fp,fpos_t* position);
 *          int     fsetpos(FILE* fp,const fpos_t* position);
 *          int     fseek(FILE* fp,long int offset,int origin);
 *              origin =: { SEEK_SET,   # Beginning of file
 *                          SEEK_CUR,   # Current position of the file pointer
 *                          SEEK_END    # End of file
 *                  }
 *          int     ftell(FILE *fp);
 *          void    rewind(FILE* fp);
 *  TMP file:2
 *          FILE*   tmpfile(void);
 *          char*   tmpnam(char* fname);
 *  FILE handling:2
 *          int     remove(const char* fname);
 *          int     rename(const char* oldfname, const char* newfname);
 *        [ int     f_copyFile(char *src, char *obj) ]  * internal fct
 */

 /*  USAGE:     DOS> run.exe [<x>]
 *              x : if set, IO is active
 *
*/

#ifndef __USE_TUTOR__MAIN
    #define INC__TUTOR_LIBRARY
#endif
#include "c00_include.h"


/*
 *  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
 *  m:  global
 *  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
*/

#define     C_FILE_NAME_BDY     "C08_IO"
#define     C_FILE_NAME_EXT     ".txt"

int g_isIoMode = 0;


/*
 *  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
 *  m:  module
 *  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
*/


/*
 *  ---------------------------------------------------------------------------
 *  FORMATE of printf /scanf
 *  ---------------------------------------------------------------------------
 *
 *  %c      :   char
 *  %s      :   string
 *  %d      :   decimal int with sign
 *  %i      :   int, decimal/octal/hex  with sign
 *  %e,%E   :   (+/-)N.N e(+/-)N
 *  %f      :   float or double
 *  %g,%G   :   use shorter version of %e or %f
 *  %h,%H   :   hex number with big/small capitals
 *  %o      :   octal number
 *  %u      :   unsigned int
 *  %p      :   pointer
 *  %n      :   int*
 *  %%      :   print or read a '%'
 *  %[]     :   scanf()     : read char set
 *  ---------------------------------------------------------------------------
*/

int F_mod_scanf() {

    F_MENU("scanf");

    int     iVal;
    float   fVal;
    char    cVal;
    double  dVal;
    short   int siVal;
    long    int liVal;
    unsigned long int   uliVal;


    if (!g_isIoMode) {
        printf ("... no STDIN, choose >prog.exe x\n");
        goto l_STDOUT;
    }

    /* --- scanf(),printf() */

    printf("---scanf()\n");

    printf(">>> char                :");
    /* scanf("%c",&cVal); */
    cVal = '$';
    printf("<<< cVal=%c\n",cVal);


    printf(">>> int                 :");
    /* scanf("%i",&iVal); */
    iVal = 123;
    printf("iVal=%d\n",iVal);
    printf("\t\tDec     :%d\n",iVal);
    printf("\t\tHex     :%x\n",iVal);
    printf("\t\tOct     :%o\n",iVal);

    printf(">>> float               :");
    /* scanf("%f",&fVal); */
    fVal = (float)123.456;
    printf("<<  fVal=%f\n",fVal);
    printf("\t\tfloat.f :%f\n",fVal);
    printf("\t\tfloat.e :%e\n",fVal);
    printf("\t\tfloat.g :%g\n",fVal);

    printf(">>> double              :");
    /* scanf("%lf",&dVal);  */
    dVal = 123.456;
    printf("<<< dVal=%f\n",dVal);

    printf(">>> short int           :");
    /* scanf("%hd",&siVal);    */
    siVal = -12;
    printf("<<< siVal=%d\n",siVal);

    printf(">>> long int            :");
    /* scanf("%ld",&liVal); */
    liVal = -12345;
    printf("<<< liVal=%ld\n",liVal);

    printf(">>> unsigned long int   :");
    /* scanf("%lu",&uliVal); */
    uliVal = -12345;
    printf("<<< uliVal=%ld\n",uliVal);

l_STDOUT:
    return __LINE__;
}


/*
 *  ***************************************************************************
 *  stdOUT: printf  Formate
 *  ***************************************************************************
 *  void    printf(char* fmt,arg1,...);
 */

int F_mod_printf() {

    F_MENU("printf");

    int     iVal;
    double  dVal;
    char    strAbc[]="ABCDEFGHIJKLMNOP";

    iVal = 123;
    printf("\tiVal=%d(DEC)=%o(OCT)=%x(HEX)\n",iVal,iVal,iVal);
    printf("\ts=<%s>\n\n",strAbc);

    printf("\tF=s[3]=:c   :<%c>\n",strAbc[3]);
    printf("\tF=s         :<%s>\n",strAbc);
    printf("\tF=10s       :<%10s>\n",strAbc);
    printf("\tF=.10s      :<%.10s>\n",strAbc);
    printf("\tF=-10s      :<%-10s>\n",strAbc);
    printf("\tF=-15s      :<%-15s>\n",strAbc);
    printf("\tF=15.10s    :<%15.10s>\n",strAbc);
    printf("\tF=-15.10s   :<%-15.10s>\n",strAbc);

    dVal=123.456;
    printf("\tF=f         :<%f>\n",       dVal);
    printf("\tF=5f        :<%5f>\n",      dVal);
    printf("\tF=.5f       :<%.5f>\n",     dVal);
    printf("\tF=-5f       :<%-5f>\n",     dVal);
    printf("\tF=3.2f      :<%3.2f>\n",    dVal);
    printf("\tF=1.3f      :<%1.3f>\n",    dVal);

    return __LINE__;
}


/*
 *  ***************************************************************************
 *  stdOUT: andere Funktionen
 *  ***************************************************************************
 *  void    vprintf(char* fmt,va_list args);
 *  int     putchar(int c);
 *  int     puts(char *str);
*/

int F_mod_stdout() {

    F_MENU("stdoutput functions:putchar,puts,vprintf");

    char        cVal;
    char        cTab='\t';
    char        strAbc[]="ABCDEFGHIJKLMNOP";

    cVal = '@';

    /* ---  putchar() */
    F_SHOW("putchar");
    putchar(cTab);
    putchar(strAbc[3]);
    printf("\n");
    printf("\tputchar(cVal) : ");
    putchar(cVal);
    printf("\n");

    /* ---  puts() */
    F_SHOW("puts");
    printf("\tsputs(strAbc) : ");
    puts(strAbc);
    printf("\n");

    /* ---  vprintf() */
#ifdef __USE_EXPERT
    F_SHOW("vprintf");
    char *      largs[]={"ersterStr","zweiterStr"};
    va_start(largv, largs,...);
    va_list     largv;
    printf("\t vprintf(strAbc) : ");
    vprintf("str1='%s':str2='%s'",largv);
    printf("\n");
    va_end (largv);
#endif

    return __LINE__;
}


/*
 *  ***************************************************************************
 *  STRING functions
 *  ***************************************************************************
 *  int     sprintf(const char* str, const char* fmt,...);
 *  int     vsprintf(const char* str, const char* fmt, va_list args);
 *  int     sscanf(const char* str, const char* fmt,...);
 */


int F_mod_string() {

    F_MENU("extended string functions");

    int         iVal=-1;
    char        str[256];
    char        strAbc[]="ABCDEFGHIJKLMNOP";

    printf("\tFCT:={sprintf,sscanf,vsprintf}\n\n");

    /* ---  sprintf() */
    printf("\tsprintf(str,\"ABC='%%s',iVal='%%d'\") : \n");
    sprintf(str,"ABC='%s',iVAL='%d'",strAbc,iVal);
    printf("\tstr              =   <%s>\n",str);

    /* ---  vsprintf()       - wie direkter Aufruf ? */
    f_VSPRINTF(str,"abc='%s',ival='%d'",strAbc,iVal);
    printf("\tf_VPRINTF::str   =   <%s>\n",str);

    /* teste MACRO mit vsprintf
     */
    F_VPRINT_S((str,"abc='%s',ival='%d'",strAbc,iVal));
    printf("\tF_VPRINT_S::str  =   <%s>\n",str);

    return __LINE__;
}


/*
 *  ***************************************************************************
 *  FILE:   fopen/fclose
 *  ***************************************************************************
 *  FILE*   fopen(const char* fname,const char* mode);
 *  FILE*   freopen(const char* fname,const char* mode,FILE* fpOld);
 *  int     fclose(FILE *fp);
 */

/*
 *  ---------------------------------------------------------------------------
 *  fopen modifier
 *  ---------------------------------------------------------------------------
 *  r       :       read
 *  w       :       write
 *  a       :       append and create, append:write at file end
 *  r+      :       read and write
 *  w+      :       read and write, create file if not exist
 *  a+      :       append, create file if not exist
 *  rb      :       read bin file
 *  wb      :       write bin file
 *  ab      :       append bin file
 *  wb+,w+b :       read and write bin file, create file if not exist
 *  ab+,a+b :       append bin file, create file if not exist
 *  ---------------------------------------------------------------------------
 */

int F_mod_fileMake__ASC() {

    FILE    *fp;
    int     i,n;
    int     iRc;
    char    cFileName[256];
    char    cBuffer[256];

    F_MENU("make.ASC");

    /* FileName */
    strcpy(cFileName,C_FILE_NAME_BDY);
    strcat(cFileName,".asc");
    strcat(cFileName,C_FILE_NAME_EXT);
    printf("\tFileName = '%s'\n",cFileName);

    /*  open */
    fp  = fopen(cFileName,"w+");
    if (fp == 0) {
        printf("\t??? I can't openWrite FILE:'%s!?\n",cFileName);
        return -__LINE__;
    }

    /*  write EyeCat */
    sprintf(cBuffer,"!ASC:240403\n");
    iRc = fputs(cBuffer,fp);
    if (iRc < 0) {
        printf("\t??? write ID1 not possible!\n");
        return -__LINE__;
    }

    /*  write String */
    sprintf(cBuffer,"ABCDEFGHIJ");
    for (i=0 ; i<5; i++) {
        n   = rand() % 100;
        iRc = fprintf(fp,"%4.4d:%s:%2.2d:#\n",i+1,cBuffer,n);
        if (iRc == 0) {
            break;
        }
    }
    if (iRc == 0) {
        printf("\t??? write STR error not possible!\n");
        return(-__LINE__);
    }

    /*  write LastID */
    sprintf(cBuffer,"----:created at:[%s;%s]:$",__DATE__,__TIME__);
    iRc = fputs(cBuffer,fp);
    if (iRc < 0) {
        printf("\t??? write ID2 not possible!\n");
        return -__LINE__;
    }

    /*  close */
    iRc = fclose(fp);
    printf("\tfClose.ASC(fp=<%p>):  <%d>\n",(unsigned char*)fp,iRc);

    return __LINE__;
}

/*
 *  ***************************************************************************
 *  FILE:   bin files
 *  ***************************************************************************
 *  REM:    write a bin file
 *  ...     FCT:=see above
 *  size_t  fwrite(const void* buf,size_t iLen,size_t count,FILE* fp);
 *  size_t  fread(void* buf,size_t iLen,size_t count,FILE* fp);
 *  int     fflush(FILE* fp);       # write immediately
 */

int F_mod_fileMake__BIN() {

    FILE    *fp;
    int     i,n,iRc=-1,iVal;
    char    cFileName[256];

    F_MENU("make.BIN");

    /* FileName */
    strcpy(cFileName,C_FILE_NAME_BDY);
    strcat(cFileName,".bin");
    strcat(cFileName,C_FILE_NAME_EXT);
    printf("\tFileName = '%s'\n",cFileName);

    /* fopen */
    fp = fopen(cFileName,"wb+");
    printf("\tfp=<%p>\n",(unsigned char*)fp);

    /* write eyeCat */
    i = '!';
    assert((iVal=fputc(i,fp)) == i);

    /* write firstLine */
    for(i=0; i<15;i++) {
        fputc(i+1,fp);
    }

    /* write nextLine */
    for(n=0; n<6;n++) {
        for(i=0; i<16;i++) {
            fputc(i+'A',fp);
        }
    }

    /* write lastLine */
    for(i=0; i<15;i++) {
        fputc(i+1,fp);
        assert(fflush(fp) == 0);
    }

    /* write end Cat */
    i = '$';
    assert((iVal=fputc(i,fp)) == i);

    /*  close */
    assert(fclose(fp) == 0);

    /*  show */
    printf("\tflose.BIN(fp=<%p>):  <%d>\n",(unsigned char*)fp,iRc);

    return __LINE__;
}


/*
 *  ***************************************************************************
 *  FILE:   char access
 *  ***************************************************************************
 *  int     fputc(int c,FILE* fp);      # retVal = written char c
 *  int     fgetc(FILE* fp);            # retVal = read char
 *  int     putc(int c,FILE* fp);       # == fputc, #define putc(x,fp) fputc(x,fp)
 *  int     getc(FILE* fp);             # == fgetc, #define getc(x,fp) fgec(x,fp)
 *  int     ungetc(int c,FILE* fp);     # retVal = c
 */

int F_mod_fileChar() {

    F_MENU("fileChar :: fputc|fgetc|putc|getc|ungetc");

    int     i, iPos,iRc,iVal;
    char    c;
    FILE    *fp;
    char    cBuffer[256];
    char    cFileName[256];

    /* define ASC file name  */
    strcpy(cFileName,C_FILE_NAME_BDY);
    strcat(cFileName,".asc");
    strcat(cFileName,C_FILE_NAME_EXT);
    printf("\tusing:file=<%s>\n",cFileName);

    /* ---  fputc(),putc() */

    F_SHOW("fputc|putc");

    fp = fopen(cFileName,"r+");    /* mode:write&read asc; don't create */
    if (fp == 0) {
        printf("\t??? fopen file:<%s>",cFileName);
        return -__LINE__;
    }
    printf("\tFP := <%p>\n",fp);

    /* goto begin/END */
    fseek(fp,0,SEEK_END);
    fputc('\n',fp);     /* newLine */
    iPos = ftell(fp);

    /* write:fputc */
    printf("\tTry fputc...\n");
    sprintf(cBuffer,"!Yoda64*$\n");
    for(i=0; i<(int)strlen(cBuffer);i++) {
        c = cBuffer[i];
        iRc = fputc(c,fp);
        if (isprint(c)) {
            printf("\tiRc := fputc('%c',fp=<%p>) => <%x>\n",c,fp,iRc);
        }
        assert(iRc == c);
    }

    /* write:putc */
    printf("\n\tTry putc...\n");
    sprintf(cBuffer,"!Harvey*$\n");
    for(i=0; i<(int)strlen(cBuffer);i++) {
        c = cBuffer[i];
        iRc = putc(c,fp);
        if (isprint(c)) {
            printf("\tiRc := putc('%c',fp=<%p>) => <%x>\n",c,fp,iRc);
        }
        assert(iRc == c);
    }

    /* close */
    iRc = fclose(fp);
    assert(iRc == 0);

    /*
     * Unter Windows wird aus '10'='0a' automatisch
     * '0d0a' = \r\n - nicht jedoch unter UNIX.
     * Auch die 'bin' option n?tzt da nichts.
     */


    F_SHOW("fgetc|getc");

    /* openRead */
    fp = fopen(cFileName,"r");    /* mode:read */
    assert(fp != 0);
    printf("\tFP := <%p>\n",fp);

    fseek(fp,iPos,SEEK_SET);
    printf("\tiPos := <%d>\n",iPos);

    /* fgetc */
    printf("\n\tTry fgetc...\n");
    iVal = fgetc(fp);
    printf("\tfgetc[%d] =: <%x> *\n",i,iVal);
    assert(iVal == '!') ;   /* check */
    for (i=1; i<10; i++ ) {
        iVal = fgetc(fp);
        printf("\tfgetc[%d] =: <%x>\n",i,iVal);
    }

    /* fgetc */
    printf("\n\tTry getc...\n");
    iVal = getc(fp);
    printf("\tgetc[%d] =: <%x> *\n",i,iVal);
    assert(iVal == '!') ;   /* check */
    for (i=1; i<10; i++ ) {
        iVal = getc(fp);
        printf("\tgetc[%d] =: <%x>\n",i,iVal);
    }

    /* ungetc ??? */
    printf("\n\tTry ungetc...\n");
    fseek(fp,0,SEEK_SET);
    c = '!';
    iVal = ungetc(c,fp);
    printf("\tUngetc(%c) =: <%x>\n",c,iVal);

    /* close */
    assert(fclose(fp) == 0);


    return __LINE__;

}

/*
 *  ***************************************************************************
 *  FILE:   string access
 *  ***************************************************************************
 *  int     fputs(char *srcStr, FILE *)                 # retVal=0:OK
 *  char*   fgets(char *objStr,int objLen,FILE *fp);    # retVal = objStr
 */

int F_mod_fileString() {

    FILE    *fp;
    int     c,i,iRc;
    char    cFileName[256];
    char    cBuffer[128];
    char   *cPtr;

    F_MENU("stringAccess :: fputs|fgets ");

    /* define ASC file name  */
    strcpy(cFileName,C_FILE_NAME_BDY);
    strcat(cFileName,".asc");
    strcat(cFileName,C_FILE_NAME_EXT);
    printf("\tusing:file=<%s>\n",cFileName);

    /* file:openWrite+Read */
    fp = fopen(cFileName,"r+");    /* mode:write+read */
    assert(fp != 0);
    printf("\tFP := <%p>\n",fp);

    /* file:gotoEND  */
    fseek(fp,0,SEEK_END);

    /* setBuffer */
    strcpy(cBuffer,"!WriteAsString$");

    /* file:WRITE */
    iRc = fputs(cBuffer,fp);
    printf("\tFputs(cBuffer,fp) : <%x>\n",iRc);

    /* file:close */
    assert(fclose(fp) == 0);

    /* file:open */
    assert ((fp = fopen(cFileName,"r")) != 0) ;    /* mode:read */
    printf("\tFP := <%p>\n",fp);

    /* file:READ */
    cPtr = fgets(cBuffer,sizeof(cBuffer),fp);
    printf("\tCptr      :   <%p>\n",cPtr);
    for (i=0; i<sizeof(cBuffer); i++) {
        c = cBuffer[i];
        if (!isprint(c)) {
            cBuffer[i] = 0;
            break;
        }
    }
    assert(cBuffer[0] == '!');  /* check */
    printf("\tCBuffer   :   <%s>\n",cBuffer);

    /* file:close */
    assert(fclose(fp) == 0);

    return __LINE__;

}


/*
 *  ***************************************************************************
 *  FILE:   format access
 *  ***************************************************************************
 *  int     fprintf(FILE* fp,const char* fmt,...);
 *  int     fscanf(FILE* fp, const char* fmt,...);
 *  int     vfprintf(FILE* fp,const char* fmt,va_list args);
 */

int F_mod_fileFormat() {

    FILE    *fp;
    int     i,c,iRc,
            iFileSize,
            iVal;
    char    cFileName[256];
    char    cBuffer[64];

    F_MENU("FILE.formatAccess :: fprintf|fscanf ");

    /* define ASC file name  */
    strcpy(cFileName,C_FILE_NAME_BDY);
    strcat(cFileName,".asc");
    strcat(cFileName,C_FILE_NAME_EXT);
    printf("\tusing:file=<%s>\n",cFileName);

    /* file:open */
    assert ((fp = fopen(cFileName,"r+")) != 0) ;    /* mode:write+read */
    printf("\tFP.write := <%p>\n",fp);

    /* file:gotoEND  */
    fseek(fp,0L,SEEK_END);
    iFileSize = ftell(fp);
    printf("\tiFileSize := <%d>\n",iFileSize);

    /* file:WRITE::fprintf */
    fputc('\n',fp); /* last line end */
    iVal    = 1234;
    strcpy(cBuffer,"!TomasGehtZurSchule");
    iRc     = fprintf(fp,"\nINT=(%d),STR=(%s)\n",iVal,cBuffer);
    printf("\tiRc := <%d>\n",iRc);

    /* file:close */
    assert(fclose(fp) == 0);

    /* file:open */
    assert ((fp = fopen(cFileName,"r")) != 0) ;    /* mode:write */
    printf("\tFP.read := <%p>\n",fp);

    /* file:scan */
    iRc     = fscanf(fp,"%s",cBuffer);
    for (i=0; i<sizeof(cBuffer); i++) {
        c = cBuffer[i];
        if (!isprint(c)) {
            cBuffer[i] = 0;
            break;
        }
    }
    assert(cBuffer[0] == '!');  /* check */
    printf("\tBuffer   :    <%s>\n",cBuffer);

    /* file:close */
    assert(fclose(fp) == 0);

    return __LINE__;
}

/*
 *  ***************************************************************************
 *  FILE:   record or struct access
 *  ***************************************************************************
 *  size_t  fwrite(const void* buf,size_t iLen,size_t count,FILE* fp);
 *  size_t  fread(void* buf,size_t iLen,size_t count,FILE* fp);
 *  int     fflush(FILE* fp);       # write immediately
 */

int F_mod_fileRecord() {


    int     i, iRc;
    FILE    *fp;
    char    cFileName[128];
    typedef struct {
            int     m_nr;
            char    m_name[11];
            char    m_eyeCat;
    } T_FILE_RECORD;
    T_FILE_RECORD   r1,r2,rX;

    F_MENU("FILE.recordAccess :: fwrite,fread,fflush ");


    /* ---  fwrite(),fread(),fflush() */
    memset(cFileName,0,sizeof(cFileName));
    strcpy(cFileName,C_FILE_NAME_BDY);
    strcat(cFileName,".rec.txt");

    /*  recordAcess */
    r1.m_nr=1;
    strcpy(r1.m_name,"PETER?");
    r1.m_eyeCat = '!';
    r2.m_nr=2;
    strcpy(r2.m_name,"HARVEY!");
    r2.m_eyeCat = '!';
    printf("\tSizeof(T_FILE_RECORD) : %d(dec)\n",(int)sizeof(T_FILE_RECORD));

    /* ---  fwrite()*/
    F_SHOW("fwrite");
    fp      = fopen(cFileName,"wb+");       /* fileOpen : write*/
    assert (fp != 0);
    i = fwrite(&r1,sizeof(r1),1,fp);        /* 1 object */
    assert(i == 1);
    i = fwrite(&r2,sizeof(r2),1,fp);        /* second 1 object */
    assert(i == 1);
    printf("\tI=fwrite(&r1,sizeof(r1),1,fp): <%d>\n",i);

    /* ---  fflush()*/
    F_SHOW("fflush");
    i = fflush(fp);     /* write now ! */
    printf("\tI=fflush(fp): <%d>\n",i);
    assert(i == 0);

    /* ---  fread()*/
    i = fread(&rX,sizeof(rX),1,fp);        /* 1 object */
    printf("\tI=fread(&rX,sizeof(rX),1,fp): <%d>\n",i);
    assert(i >= 0); /* MsVs returns 0 */

    /* CLOSE */
    iRc = fclose(fp);
#ifdef __BORLANDC__
    assert (iRc == -1);  /* !CRQ-240515:RAD:fClose error  */
#else
    assert (iRc == 0);
#endif
    printf("\t--- written file: <%s>\n\n",cFileName);

    return __LINE__;
}


/*
 *  ***************************************************************************
 *  FILE:   error handling
 *  ***************************************************************************
 *  void    perror(const char *s);
 *  void    clearerr(FILE* fp);
 *  int     feof(FILE* fp);
 *  int     ferror(FILE* fp);
 *  char*   strerror(int);
 */

/*
 *  ***************************************************************************
 *  FILE:   seek
 *  ***************************************************************************
 *  int     fgetpos(FILE* fp,fpos_t* position);         # save filePos
 *  int     fsetpos(FILE* fp,const fpos_t* position);   # set to saved filePos
 *  int     fseek(FILE* fp,long int filePosOff,int origin); # goto filePos
 *  int     ftell(FILE *fp);                            # get filePosition
 *  void    rewind(FILE* fp);                           # goto filePos=0
 */

int F_mod_fileSeek() {

    FILE    *fp;
    int     i,iRc,fPos,
            iFileSize;
    fpos_t  tPosition;
    char    c;
    char  * cPtr;
    char    cBuffer[256];
    char    cFileName[256];

    F_MENU("fileSEEK");

    /* define ASC file name  */
    strcpy(cFileName,C_FILE_NAME_BDY);
    strcat(cFileName,".asc");
    strcat(cFileName,C_FILE_NAME_EXT);
    printf("\tusing:file=<%s>\n",cFileName);

    /* open for read */
    assert((fp = fopen(cFileName,"r+")) != 0);

    /* fileSize */
    i = fseek(fp,0,SEEK_END);
    iFileSize = ftell(fp);
    printf("\tFileSize <%d>'\n",iFileSize);

    /* GETS */
    i = fseek(fp,0,SEEK_SET);
    cPtr = fgets(cBuffer,sizeof(cBuffer),fp);
    printf("\tCptr      :   <%p>\n",cPtr);
    for (i=0; i<sizeof(cBuffer); i++) {
        c = cBuffer[i];
        if (!isprint(c)) {
            cBuffer[i] = 0;
            break;
        }
    }
    printf("\tBUFFER <%s>'\n",cBuffer);

    /* setTo fpos==2 */
    fPos    = 2;
    i = fseek(fp,fPos,SEEK_SET);

    /* GetPosition and SAVE */
    iRc = fgetpos(fp,&tPosition);         /* save this pos */
    printf("\tI=fgetpos(fp,&tPos):RC=<%d> => fpos:=<%ld>\n",iRc,ftell(fp));

    /* getC 3x  */
    i = fgetc(fp);
    printf("\tI1 = fgetc[fpos=%d ++]    : <%x>='%c'\n",fPos,i,i);
    i = fgetc(fp);
    printf("\tI2 = fgetc[fpos++]       : <%x>='%c'\n",i,i);
    i = fgetc(fp);
    printf("\tI3 = fgetc[fpos++]       : <%x>='%c'\n",i,i);

    /* --- ftell */
    fPos = ftell(fp);
    printf("\tFPos  = ftell(fp)        : <%d>\n",fPos); /* fpos=5 */

    /* --- restore old position */
    i = fsetpos(fp,&tPosition);         /* restore old pos */
    printf("\tI=fsetpos(fp,&tPos):RC=<%d> <= fpos:=<%ld>\n",iRc,ftell(fp));

    /* --- READ */
    i = fgetc(fp);
    printf("\tI4 = fgetc[fpos=%d ++]   : <%x>='%c'\n",fPos,i,i);
    i = fgetc(fp);
    printf("\tI5 = fgetc[fpos=%d ++]   : <%x>='%c'\n",fPos,i,i);

    assert(fclose(fp)==0);

    return __LINE__ ;
}

/*
 *  ***************************************************************************
 *  FILE:   tempNames und tempFiles
 *  ***************************************************************************
 *  FILE*   tmpfile(void);
 *  char*   tmpnam(char* fname);
 */
    /*  --- tmpfile() */
    /*  tmpFiles ...
     *  +   sind binary files
     *  +   sind nur im RAM
     *  +   ben?tigen kein fopen - optional fclose
     *  +   werden automatisch gel?scht beim Beenden des Programms
     *  +   k?nnen genauso behandelt werden wie normale Files
     */

int F_mod_fileTemp() {



    F_MENU("FILE.temp.NOK ");

#define x_USE_TMPNAME
#ifdef  __USE_TMPNAME    /* &&& WARNING */

    FILE *  fp;
    char *  pTmpName;

    F_SHOW("tempName");

    /* f: tmpName */
    pTmpName = tmpnam(NULL);
    printf("\tTmpName  = '%s'\n",pTmpName);

    /* f: access with */
    assert((fp = fopen(pTmpName,"w+")) != 0);
    assert((fputs("!MyTmpFile$\n",fp)) != 0);
    assert (fclose(fp) == 0);

    F_SHOW("fp := tmpFile");

    int     iRc;
    int     iFilePos;

    /* f: fpTemp */
    fp  = tmpfile();
    assert(fp != 0);
    printf("\tFP.tmpfile =: <%p>\n",fp);

    /* puts */
    iRc = fputs("ABCDEFGHIJ",fp);
    printf("\tFputs.iRc: <%d>\n",iRc);

    /* filePos */
    iFilePos = ftell(fp);
    printf("\tFilePos : <%d>\n",iFilePos);

    /* close */
    assert(fclose(fp)==0);

#endif

    return __LINE__;
}

/*
 *  ***************************************************************************
 *  Copy, Rename, Remove Files      use f_copyFile(src,obj)
 *  ***************************************************************************
 *  int     f_copyFile(char *srcFile, char* objFile);
 *  int     remove(const char* fname);
 *  int     rename(const char* fname_old, const char* fname_new);
 */


int F_mod_fileHandling() {

    char    cFileX[256];
    char    cFile1[256];
    char    cFile2[256];
    char    cFile3[256];


    F_MENU("filehandling: copy,rename,remove");

    /* define ASC file name  */
    strcpy(cFileX,C_FILE_NAME_BDY);
    strcat(cFileX,".asc");
    strcat(cFileX,C_FILE_NAME_EXT);
    printf("\tUsing:file=<%s>\n",cFileX);

    /* helper  */
    strcpy(cFile1,C_FILE_NAME_BDY);
    strcat(cFile1,".001.txt");
    printf("\tUsing:file1=<%s>\n",cFile1);
    strcpy(cFile2,C_FILE_NAME_BDY);
    strcat(cFile2,".002.txt");
    printf("\tUsing:file2=<%s>\n",cFile2);
    strcpy(cFile3,C_FILE_NAME_BDY);
    strcat(cFile3,".003.txt");
    printf("\tUsing:file3=<%s>\n",cFile3);

    F_SHOW("copy&&rename");

    /* m1:  copyFile */
    f_copyFile(cFileX,cFile1);
    printf("\tCOPY : fileX:<%s> => file:<%s>\n",cFileX,cFile1);
    f_copyFile(cFileX,cFile2);
    printf("\tCOPY : fileX:<%s> => file:<%s>\n",cFileX,cFile2);

    /* m2:  renameFile */
    printf("\tRENAME: file:<%s> => file:<%s>\n",cFile1,cFile3);
    rename(cFile1,cFile3);

    /* m3:  removeFile */
    printf("\tREMOVE: file:<%s>\n",cFile2);
    remove(cFile2);

    return __LINE__;
}

/*
 *  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
 *  m:  body
 *  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
*/

#define F_CHK()   { \
    if ( iRc < 0) { \
        printf("?Code:%d at:[%d]",(iRc),(__LINE__)); \
        assert(iRc=0);return(-(__LINE__)); } }

int F08_io(int p_iEc)
{
    int iRc;

    F_MENU("MAIN: CTutor::IO");

    printf("\tcompiled:\n");
    printf("\tDATE=(%s;%s)\n",__DATE__,__TIME__);
    printf("\tFILE:[%s;%d]\n", __FILE__,__LINE__);

    #ifdef  __cplusplus
        printf("\t### isC++:=YES\n");
    #else
        printf("\t### isC++:=NO !\n");
    #endif

    /*  IO ? */
    g_isIoMode = 1;

    /*  subfunction call */

    printf("\n\ts:call subfunction...\n");

    iRc = F_mod_scanf();    printf("\n\tRC.scanf    =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_printf();   printf("\n\tRC.printf   =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_stdout();   printf("\n\tRC.stdout   =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_string();   printf("\n\tRC.string   =: <%d>\n",iRc); F_CHK();

    iRc = F_mod_fileMake__ASC();
        printf("\n\tRC.init.ASC     =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_fileMake__BIN();
        printf("\n\tRC.init.BIN     =: <%d>\n",iRc); F_CHK();


    iRc = F_mod_fileChar();     printf("\n\tRC.fileChar     =: <%d>\n",iRc);  F_CHK();
    iRc = F_mod_fileString();   printf("\n\tRC.fileString   =: <%d>\n",iRc);F_CHK();
    iRc = F_mod_fileFormat();   printf("\n\tRC.f.formatAccess   =: <%d>\n",iRc);F_CHK();
    iRc = F_mod_fileRecord();   printf("\n\tRC.f.record =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_fileSeek();     printf("\n\tRC.f.seek   =: <%d>\n",iRc); F_CHK();
    iRc = F_mod_fileTemp();     printf("\n\tRC.f.temp       =: <%d>\n",iRc);F_CHK();
    iRc = F_mod_fileHandling(); printf("\n\tRC.f.handling   =: <%d>\n",iRc);F_CHK();

    printf("\n\n\n--- EndOfFile:[%s] at LineNr:[%d] \n",__FILE__,__LINE__);

    return(p_iEc);

}   /* end of F */


/*  ######################################################################## */
/*	main */
/*  ######################################################################## */

#ifndef __USE_TUTOR__MAIN
int main(int args, char *argv[]) {
    int     iEc = atoi(getenv("v_FWK_exitCode"));
    return  F08_io(iEc);
}
#endif
