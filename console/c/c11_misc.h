#ifndef     INC_MISC_H 
#define     INC_MISC_H 

/* 
    encoding: UTF-8
    !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ
*/

enum EColor { e_red, e_yellow, e_green };
typedef enum EColor TColor;

typedef struct {
    int     m_iVal;
    char    m_cVal;
    TColor  m_eVal;
} TRecord;

#endif