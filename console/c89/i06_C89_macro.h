/*  ****************************************************************************
 *  tutorial.C89  include.macro                 ©[mATe64]           [2026-10-14]
 *  ****************************************************************************
 *  encoding: UTF-8
    !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ
*  ****************************************************************************/


#ifndef __USE_TUTOR_C89__INCLUDE_MACRO
#define __USE_TUTOR_C89__INCLUDE_MACRO

/*  ===========================================================================
 *  m:  F.macro
 *  ======================================================================== */


/*  s:  M.menu                                                              */
#define F_HEADER(x)     f_lib_header(x,__FILE__,__LINE__);
#define F_MENU(x)       f_lib_menu(x,__FILE__,__LINE__)
#define F_SHOW(x)       f_lib_show(x,__FILE__,__LINE__)
#define F_TRACE(x)  f_lib_trace(x, __FILE__, __LINE__)

/*  s:  M.file                                                             */
#define F_VPRINT_F(argList)     f_lib_vfprintf  argList
#define F_VPRINT_S(argList)     f_lib_vsprintf  argList

/*  s:  M.misc                                                             */
#define F_TIME()                f_lib_getTimeStr(gTimeStr)
#define F_DUMP(idStr,mem,size)  f_lib_dump(mem,size,__FILE__,__LINE__,idStr)




#endif /*__USE_TUTOR_C89__INCLUDE_MACRO */