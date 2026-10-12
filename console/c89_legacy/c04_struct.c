/*  ########################################################################### */
/*  04: Complex Data Types                                                      */
/*  ########################################################################### */
/*
    encoding: UTF-8
    !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ
*/

#include    "c00_include.h"

int F04_struct(int p_iEc)
{
    int     i=77;
    char    string[]="ABCDEFGIJ";
#ifdef __C_NATIVE
    typedef     int         T_INT;
    typedef     unsigned char *  T_PTR;
    enum        ENUM_RGB { E_ROT, E_GELB, E_BLAU};
    enum        ENUM_KFZ { EN_PKW=3, EN_MOTOR_BIKE, EN_LKW };
    typedef enum KFZ_enum_tag {
            E_PKW = 1,      /* anderer Name als in ENUM */
            E_LKW = 2,
            E_BIKE = 3
    } T_KFZ;
    T_INT       myI = 4711;
    T_PTR       ptr2str = (unsigned char *)string;
    T_KFZ       myKfz = E_PKW;
    union u_tag
    {
        unsigned long int   m_dword;
        T_INT               m_int;          /* typedef usage */
        float               m_float;

    } uVar;
    typedef union u_tag     T_NUMBER;
    T_NUMBER    number1;
    struct sPosition_tag
    {
        int         x;
        int         y;
        int         z;
    } sPosition;
    struct sPosition_tag    sPos1;
    struct sPosition_tag    sPos2={-3,-6,-9};
    typedef  struct  sPosition_tag   T_POSITION;
    T_POSITION  sPos3={123,456,789};
    struct sPERSON1_tag
    {
        char                * m_name;
        unsigned int        m_plz;

    } person1 = {"Otto Maier",10012};
    typedef struct sPERSON2_tag         /* mit typedef */
    {
        char                * m_name;
        unsigned int        m_plz;
        T_KFZ               m_kfz;      /* ein ENUM */
    } T_PERSON;
    T_PERSON    person2 = {"Willy Wichtig",457128,E_BIKE};
    T_PERSON    ehepar[2] = {
                   {"Theodor Meier",457128,E_LKW},
                   {"Liselotte Meier",457128,E_PKW}
                } ;
    typedef struct tnode
    {
        struct tnode      * m_next;
        int                 m_nr;
        char              * m_name;

    } T_NODE;
    T_NODE  t1 = {(struct tnode *)NULL, 4711, "erster Node" };
    T_NODE  t2 = {(struct tnode *)NULL, 3311, "zweiter Node" };
    /*typedef unsigned long int   DWORD;*/
    typedef union u_REAL
    {
        USIGN32 m_dword;       /* 32-bit */
        float   m_float;

        struct  {
            int /* muss 'int' sein - nicht USIGN32 */       frc:23;
            int /* USIGN32 */       exp:8;
            int /* USIGN32 */       sgn:1;
        } m_real;

         struct  {
            int /* USIGN32 */      abs:31;         /* frc+exp */
            int /* USIGN32 */      sgn:1;
        } m_real_sgn;

    } T_REAL;
    T_REAL      r1;
    T_REAL      * p_r1 = &r1;

#endif  /* C_NATIVE */
    printf("============================================================ \n");
    printf("[C04]:  structures\n");
    printf("============================================================ \n");

    printf("--- compiled:");
    printf("DATETIME=(%s;%s)",__DATE__,__TIME__);
    printf("FILE: =[%s]\n", __FILE__);
#ifdef  __cplusplus
    printf("### isC++:=YES\n");
#else
    printf("### isC++:=NO !\n");
#endif

/*
 *  ***************************************************************************
 *  TYPEDEF
 *  ***************************************************************************
 *  === !KEY:   typedef
 */
    /*
     * typedef kann mitten im Programm erfolgen ?!
     */

    printf("*** [%s;%d]: Typedef\n",__FILE__,__LINE__);
#ifdef __C_ADVANCED
    typedef     long int     T_INT;
    T_INT       myI = 4711;
#endif
    printf("    (T_INT)myI  : %d\n",(int)myI);   /* warning */

#ifdef __C_ADVANCED
    typedef     unsigned char *  T_PTR;
    T_PTR       ptr2str = (unsigned char *)string;
#endif
                /*
                 * typecast - denn string ist char *
                 */
    printf("    (T_PTR)ptr2str    : %s\n",ptr2str);


/*
 *  ***************************************************************************
 *  ENUM
 *  ***************************************************************************
 *  === !KEY:   enum
 */

    printf("*** [%s;%d]: Enums\n",__FILE__,__LINE__);
    /*
     * enums sind eigentlich int-Konstanten
     */
#ifdef __C_ADVANCED
    enum    ENUM_RGB { E_ROT, E_GELB, E_BLAU};
#endif
    i   = E_ROT;
    printf("    Rot: %i\n",i);
    i   = E_GELB;
    printf("    Gelb: %i\n",i);
    i   = E_BLAU;
    printf("    Blau: %i\n",i);

#ifdef __C_ADVANCED
    enum    ENUM_KFZ { EN_PKW=3, EN_MOTOR_BIKE, EN_LKW };
#endif
    i   = EN_PKW;
    printf("    PKW: %i\n",i);
    i   = EN_MOTOR_BIKE;
    printf("    BIKE: %i\n",i);
    i   = EN_LKW;
    printf("    LKW: %i\n",i);

    /* ENUM mit typedef */
#ifdef   __C_ADVANCED
    typedef enum KFZ_enum_tag {
            E_PKW = 1,      /* anderer Name als in ENUM */
            E_LKW = 2,
            E_BIKE = 3
    } T_KFZ;
    T_KFZ       myKfz = E_PKW;
#endif
    printf("    (T_KFZ:enum)myKkz    : %d\n",myKfz);


/*
 *  ***************************************************************************
 *  UNION
 *  ***************************************************************************
 *  === !KEY:   union
 */
    printf("*** [%s;%d]: Union\n",__FILE__,__LINE__);

#ifdef   __C_ADVANCED
    union u_tag
    {
        unsigned long int   m_dword;
        T_INT               m_int;          /* typedef usage */
        float               m_float;

    } uVar;
#endif   /* __C_ADVANCED */

    uVar.m_float = (float)-123.456;

    printf("--- a) Union with different number types\n");
    printf("sizeof(uVar)    : %d\n",(int)sizeof(uVar));
    printf("Float   : %f\n",uVar.m_float);
    printf("==DWORD : %lX\n",uVar.m_dword);
    printf("==LINT  : %d\n",(int)uVar.m_int);

    /* UNION mit typedef */
    printf("--- b) T_Unions\n");
#ifdef   __C_ADVANCED
    typedef union u_tag     T_NUMBER;
    T_NUMBER    number1;
#endif   /* __C_ADVANCED */
    number1.m_float = 123.456F;     /* ohne 'F' warning in cl(msvc) */
    printf("Float   : %f\n",number1.m_float);
    printf("==DWORD : %lX\n",number1.m_dword);
    printf("==LINT  : %d\n",(int)number1.m_int);

/*
 *  ***************************************************************************
 *  STRUKTUREN und der Elementoperator {'.'}
 *  ***************************************************************************
 *  === !KEY:   struct
*/
    printf("*** [%s;%d]: Structure\n",__FILE__,__LINE__);

    /* Definition der Struktur */
#ifdef   __C_ADVANCED
    struct sPosition_tag
    {
        int         x;
        int         y;
        int         z;
    } sPosition;
#endif
    /* Hier wird die Struktur und eine Variable 'sPosition'
     * der Struktur definiert
     */

    /* ---  Explizite Form der Zuweisung */
    sPosition.x = 111;
    sPosition.y = 222;
    sPosition.z = 333;

    /* ---  Zugriff auf die Elemente ?ber den Elementoperator {'.'} */
    printf("sPos(x:%d;y:%d,z:%d)\n",
      sPosition.x,
      sPosition.y,
      sPosition.z);

     /* ---  nutzen des Tags */
#ifdef   __C_ADVANCED
    struct sPosition_tag    sPos1;
#endif
    sPos1.x = 2;
    sPos1.y = 4;
    sPos1.z = 8;
    printf("sPos1(x:%d;y:%d,z:%d)\n",sPos1.x,sPos1.y,sPos1.z);

     /* ---  Zuweisung direkt */
#ifdef   __C_ADVANCED
    struct sPosition_tag    sPos2={-3,-6,-9};
#endif
    printf("sPos2(x:%d;y:%d,z:%d)\n",sPos2.x,sPos2.y,sPos2.z);

     /* ---  Struktur mit typedef */
#ifdef   __C_ADVANCED
    typedef  struct  sPosition_tag   T_POSITION;
    T_POSITION  sPos3={123,456,789};
#endif
    printf("sPos3(x:%d;y:%d,z:%d)\n",sPos3.x,sPos3.y,sPos3.z);

    printf("--- Komplexe Strukturen\n");

#ifdef   __C_ADVANCED
    struct sPERSON1_tag
    {
        char                * m_name;
        unsigned int        m_plz;

    } person1 = {"Otto Maier",10012};
#endif
    printf("... person1\n");
    printf("NAME    : %s\n",person1.m_name);
    printf("PLZ     : %i\n",person1.m_plz);

#ifdef   __C_ADVANCED
    typedef struct sPERSON2_tag         /* mit typedef */
    {
        char                * m_name;
        unsigned int        m_plz;
        T_KFZ               m_kfz;      /* ein ENUM */
    } T_PERSON;
    T_PERSON    person2 = {"Willy Wichtig",457128,E_BIKE};
#endif
    printf("... person2\n");
    printf("NAME    : %s\n",person2.m_name);
    printf("PLZ     : %i\n",person2.m_plz);
    printf("KFZ     : %i\n",person2.m_kfz);

    printf("--- Strukturen-ARRAYs\n");
#ifdef   __C_ADVANCED
    T_PERSON    ehepar[2] = {
                   {"Theodor Meier",457128,E_LKW},
                   {"Liselotte Meier",457128,E_PKW}
                } ;
#endif
    for(i=0; i<2; i++) {
        printf("NAME[%d]: %s\n",i,ehepar[i].m_name);
        printf("PLZ     : %i\n",ehepar[i].m_plz);
        printf("KFZ     : %i\n",ehepar[i].m_kfz);
    }

/*
 *  ***************************************************************************
 *  BESONDERE STRUKTUREN        {rekursive,bit-}
 *  ***************************************************************************
 */
    printf("*** [%s;%d]: Besondere Strukturen\n",__FILE__,__LINE__);

    printf("--- a) rekursive \n");

#ifdef   __C_ADVANCED
    typedef struct tnode
    {
        struct tnode      * m_next;
        int                 m_nr;
        char              * m_name;

    } T_NODE;
    T_NODE  t1 = {NULL, 4711, "erster Node" };
    T_NODE  t2 = {&t1, 3311, "zweiter Node" };
#else
    t2.m_next  = &t1;
#endif
    printf("NAME    : %s\n",t1.m_name);
    printf("next    : %p\n",(unsigned char*)t1.m_next);
    printf("NR      : %i\n",t1.m_nr);
    printf("NAME    : %s\n",t2.m_name);
    printf("next    : %p\n",(unsigned char*)t2.m_next);
    printf("NR      : %i\n",t2.m_nr);


    printf("--- b) Bit-Felder \n");

#ifdef   __C_ADVANCED
    typedef unsigned long int   DWORD;
    typedef union u_REAL
    {
        USIGN32 m_dword;       /* 32-bit */
        float   m_float;

        struct  {
            USIGN32     frc:23;
            USIGN32     exp:8;
            USIGN32     sgn:1;
        } m_real;

         struct  {
            USIGN32     abs:31;         /* frc+exp */
            USIGN32     sgn:1;
        } m_real_sgn;

    } T_REAL;
    T_REAL      r1;
#endif
    r1.m_float  =   -123.456789F;

    printf("r1.m_float      : %f \n",r1.m_float);
    printf("r1.m_dword      : %lX\n",r1.m_dword);

#ifdef  __cplusplus
    printf("r1.m_real.sgn   : %lX\n",r1.m_real.sgn);
    printf("r1.m_real.abs   : %lX\n",r1.m_real_sgn.abs);
    printf("r1.m_real.exp   : %lX\n",r1.m_real.exp);
    printf("r1.m_real.frc   : %lX\n",r1.m_real.frc);
#else
/*  Der FormatSpecifier wird in
 *  C innerhalb von UNIONS nicht richtig beahndelt !
 */
    printf("r1.m_real.sgn   : %X\n",r1.m_real.sgn);
    printf("r1.m_real.abs   : %X\n",r1.m_real_sgn.abs);
    printf("r1.m_real.exp   : %X\n",r1.m_real.exp);
    printf("r1.m_real.frc   : %X\n",r1.m_real.frc);
#endif


/*
 *  ***************************************************************************
 *  Pointer auf Strukturen und die Elementoperatoren {'->','*.'}
 *  ***************************************************************************
 */

    printf("*** [%s;%d]: pointer auf Strukturen\n",__FILE__,__LINE__);
#ifdef __C_ADVANCED
    T_REAL      * p_r1 = &r1;
#endif

    printf("p_r1->m_float       : %f \n",p_r1->m_float); /* '->' : dereferenz-OP */
#ifdef  __cplusplus    /* format Sepcifier problem */
    printf("p_r1->m_real.frc    : %lX\n",p_r1->m_real.frc);
    printf("(*p_r1).m_real.sgn  : %ld\n",(*p_r1).m_real.sgn);
#else
    printf("p_r1->m_real.frc    : %X\n",p_r1->m_real.frc);
    printf("(*p_r1).m_real.sgn  : %d\n",(*p_r1).m_real.sgn);
#endif


    printf("--- EndOfFile:%s at LineNr:%d \n",__FILE__,__LINE__);
    return(p_iEc);
}


#ifndef __USE_TUTOR__MAIN
int main(int args, char *argv[]) {
    int     iEc = atoi(getenv("v_FWK_exitCode"));
    return  F04_struct(iEc);
}
#endif


