/*  ****************************************************************************
 *  tutorial.C89  include.file                  ©[mATe64]           [2026-10-12]
 *  ****************************************************************************
    encoding: UTF-8
    !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ
*  ****************************************************************************/


#ifndef __USE_TUTOR_C89__INCLUDE_FILE
#define __USE_TUTOR_C89__INCLUDE_FILE

/*  ===========================================================================
 *  m:  T.File
 *  ======================================================================== */

#include <stdio.h>

#ifdef  OS_WINDOWS
    #include <fcntl.h>
    typedef int                         T_FILE;
    typedef int                         T_FILE_ACCESS;
    #define FILE_OPEN_ERR               -1
    #define FILE_CLOSE_OK               0
    #define fp2fh(fp)                   (T_FILE)((fp)->_file)
    #define fh2fd(fp)                   (int)fp
#else
    int read(int,void*,int);        /* #include <fcntl.h> */
    typedef FILE *                      T_FILE;
    typedef char *                      T_FILE_ACCESS;
    #define C_FILE_ACCESS_WRITE         "w+"
    #define C_FILE_ACCESS_READ          "r"
    #define C_FILE_ACCESS_WRITE_BIN     "wb+"
    #define C_FILE_ACCESS_READ_BIN      "rb"
    #define FILE_OPEN_ERR               0
    #define FILE_CLOSE_OK               0
    #define fp2fh(fp)                   (T_FILE)fp
    #define fh2fd(fp)                   ((fp)->_file)
#endif

#ifndef fileno
    #define fileno(__F) ((__F)->_file)   /* with strict ANSI warning */
#endif

#endif /*__USE_TUTOR_C89__INCLUDE_FILE */