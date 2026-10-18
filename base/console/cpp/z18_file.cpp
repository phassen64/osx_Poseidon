//  ****************************************************************************
//  TUTORIAL:   C++     :   file <stdio>
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$
/*
    content:
        •   m:  fopen
        •   m:  fclose
        •   m:  fwrite
        •   m:  fread
        •   m:  fputs
        •   m:  fgets
    url:
        •   https://www.w3schools.com/cpp/cpp_files.asp
        •   https://cplusplus.com/reference/cstdio/
            •   https://cplusplus.com/reference/cstdio/fopen/
            •   https://cplusplus.com/reference/cstdio/fwrite/
            •   https://cplusplus.com/reference/cstdio/fputs/
            •   https://cplusplus.com/reference/cstdio/fgets/

    fopen modifier:
        •   r       :       read
        •   w       :       write
        •   a       :       append and create, append:write at file end
        •   r+      :       read and write
        •   w+      :       read and write, create file if not exist
        •   a+      :       append, create file if not exist
        •   rb      :       read bin file
        •   wb      :       write bin file
        •   ab      :       append bin file
        •   wb+,w+b :       read and write bin file, create file if not exist
        •   ab+,a+b :       append bin file, create file if not exist

    IHX
        https://de.wikipedia.org/wiki/Intel_HEX#%C3%9Cbersicht
        "100000000C9462000C948A000C948A000C948A0070"

 */

#include "Tutor.h"
using namespace std;

//  ===========================================================================
//  helper fileName
//  ===========================================================================

char * F__getFileName(CTutor &m, 
            char *p_sFileName, const char *p_sFExt=".txt") {

    string      SFile;
    string      S;
    const char    *   pcc;
    char    sFileName[80];
    char    sFileBody[60];
    char    sRandom[10];
    char        z = m.E_COLOR_GRAY;
    char *s=p_sFileName;
    int         iRandom;
    int         n;
    char  *pScratchDir = m.f_sScratchDirectory();

    //  fetch fileName
    strcpy(s,__FILE__);         /* conflicts with .. pathes ? */

    //  init 
    memset(sFileName, 0, sizeof(sFileName));
    memset(sFileBody, 0, sizeof(sFileBody));

    //  convert:filePath->fileName 
    //  'c:\dir\file.exe' -> 'file.exe'
    SFile   =   std::string(s);
    n       =   SFile.length();
    size_t iPos = SFile.find_last_of("\\");
    S = SFile.substr(iPos+1, n);    // behind
    pcc = S.c_str();
    strcpy(sFileName, pcc);

    //  subtract FileExtension
    pcc     = strrchr(sFileName,'.');
    size_t iSize = pcc-sFileName;
    sFileBody[0] = '\0';
    strncpy(sFileBody,sFileName,iSize);
    sFileBody[iSize] = 0;

    //  random Number
    iRandom =   m.f_iRandom(9999,1001); m.f_text(z,"iRnd =:'%d'",iRandom);
    sprintf(sRandom,"%d",iRandom);

    //  change FileName
    *s = 0;
    strcpy(s,sFileBody);
    strcat(s,".");
    strcat(s,sRandom);
    strcat(s,".tmp");
    strcat(s, p_sFExt);

    //  dirScratch
    s = m.f_sJoinPath(pScratchDir,s);

    return s;

}

enum E_IHX_DataType {
    E_IHX_DataRecord,
    E_IHX_EndOfFileRecord,
    E_IHX_ExtendedSegmentAddressRecord,
    E_IHX_StartSegmentAddressRecord,
    E_IHX_ExtendedLinearAddressRecord,
    E_IHX_StartLinearAddressRecord,
    E_IHX_special = 0xEE
};

//  ===========================================================================
//  helper hex2int
//  ===========================================================================

// url: https://de.wikipedia.org/wiki/American_Standard_Code_for_Information_Interchange
// url: https://de.wikipedia.org/wiki/American_Standard_Code_for_Information_Interchange#ASCII-Tabelle

// convert 1 char into hex => only 1 digit
int f_cHex2Int(int c) {
    int iAsc;
    c = toupper(c);
    if (c >= '0' && c <= '9') {
        iAsc = c - '0';
    }
    else if (c >= 'A' && c <= 'F') {
        iAsc = c - 'A' + 10;
    }
    else {
        iAsc = 0;
    }
    return iAsc;
}

unsigned int f_sHex2Int(char *s, int p_iSize=2) {
    int iAsc;
    unsigned int uSum = 0;
    for(int i=0; i<p_iSize; i++) {
        iAsc = f_cHex2Int(*s++); uSum *= 16; uSum += iAsc;
    }
    return uSum;
}


//  ===========================================================================
//  helper ihx
//  ===========================================================================

#define C_IHX__SIG_SIZE     1      //  ':'
#define C_IHX__NUM_SIZE     1*2
#define C_IHX__ADR_SIZE     2*2
#define C_IHX__TYP_SIZE     1*2
#define C_IHX__DAT_SIZE     16*2   //  maximal 16 HexNumber == 32 bytes for data
#define C_IHX__CRC_SIZE     1*2
#define C_IHX__REC_SIZE     0x30

#define C_IHX__STARTER      ':'

unsigned int f__ihx_crcCalculate(
        char*   p_sIhxRecord,
        bool    p_bIgnoreEndingCrc = false) {
/*
    Die Pr�fsumme = 3C0
     ":10010000214601360121470136007EFE09D2190140";
     CRC=0x40
*/

    const char cStart = ':';
    int     n;
    char    c;
    char*   s = p_sIhxRecord;
    bool    bSum = false;
    T_TUTOR__UINT8     uCrc = 0;
    T_TUTOR__UINT8     uVal=0, uAsc=0;
    T_TUTOR__UINT16    uSum=0;

    n  = strlen(p_sIhxRecord);
    if (*s == cStart) { s++; n--; };
    if (p_bIgnoreEndingCrc) {
        n -= C_IHX__CRC_SIZE; // ignore last 2 digits;
    }

    for (int i=0; i < n; i++, s++) {
        c = *s;
        if (!isxdigit(c)) {
            break;
        }
        if (i > C_IHX__REC_SIZE) {
            break;
        }
        uAsc = f_cHex2Int(c);
        if (bSum) {
            uVal += uAsc;
            uSum += uVal;
        }
        else {
            uVal = uAsc * 0x10;
        }
        bSum = !bSum;
    }
    uCrc = uSum & 0xFF;
    uCrc = ~uCrc;
    uCrc += 1;
    return uCrc;

} // f~~ihx_crcCalculate


char * f__ihx_recGenerate(char *p_sRec, T_TUTOR__UINT16 p_wAddr, int p_iDataLen=16) {

    char *      s           = p_sRec;
    int         iDataLen    = p_iDataLen;
    char *      p = s;
    const char cStart   = ':';
    const char *sType   = "02"; // special
    char        sNum[C_IHX__NUM_SIZE+1];
    char        sAddr[C_IHX__ADR_SIZE+1];
    char        sCrc[C_IHX__CRC_SIZE+1];
    char        sData[C_IHX__DAT_SIZE+1];
    char        sHexValue[1*2+1];
    int         i, iRnd, n;
    T_TUTOR__UINT8     uCrc = 0xCC;
    char        sRec[C_IHX__REC_SIZE],
                sTmp[C_IHX__REC_SIZE];
    char    *pRec, *pTmp;
    char        c;

//  AddrBuffer
    sprintf(sAddr,"%4.4x",p_wAddr);

//  DataBuffer
    s = sData;
    memset(sData,0,sizeof(sData));
    for(i=0; i<iDataLen; i++) {
        iRnd = rand() % 255;;       // 0...255
        sprintf(sHexValue,"%2.2x",iRnd);
        strcat(sData,sHexValue);
    }
    sData[sizeof(sData)-1] = 0;

//  DataLen
    iDataLen = strlen(sData) / 2;
    sprintf(sNum,"%2.2x",iDataLen);

//  Tmp
    sprintf(sTmp,"%s%s%s%s", sNum, sAddr, sType, sData);

 // Rec :=toUpper(Tmp)
    memset(sRec, 0, sizeof(sRec));
    n = strlen(sTmp);
    for (i = 0, pRec = sRec, pTmp = sTmp; i < n; i++) {
        c = *pTmp++;
        *pRec++ = toupper(c);
    }
    *pRec = 0;

//  Crc calc
    uCrc = f__ihx_crcCalculate(sRec);
    sprintf(sCrc, "%2.2X", uCrc);

//  finally compose record
    s = p_sRec;
    sprintf(s, "%c%s%s", cStart, sRec, sCrc);

    return (char*)p;

} // f~~ihx_recGenerate


int F__ihxGenerator(CTutor &m, const char* p_sFileTxt, int p_iMaxRec=10, bool p_bSelfTest=false) {
    FILE*       fp;
    char            z = m.E_COLOR_GRAY;
    T_TUTOR__UINT16        uAddress = 0xA000;
    char            sBuffer[C_IHX__REC_SIZE];
    char    *   s = sBuffer;
    unsigned int    uCrc;
    int             nRec=p_iMaxRec;
    const char* sRec = ":10010000214601360121470136007EFE09D2190140";
    int         iDataLen;
    int         iRc = 0;

//  init
    m.f_subMenu("ihxGenerate:init", __LINE__);
    fp = fopen(p_sFileTxt, "w");

//  max 44 chars incl 0
//  :10A1D802799B65415C9E7BAED50709D685C97FAC64

//  CalcCrc
    if (p_bSelfTest) {
        m.f_subMenu("ihxCrcCalculation", __LINE__);
        strcpy(s, sRec);
        uCrc = f__ihx_crcCalculate(s, true);
        m.f_text(z, "uCrc<hex> => '%2.2x'(0x)",uCrc);
    }

//  Generate
    m.f_subMenu("ihxGenerate:perform", __LINE__);
    memset(sBuffer, 0, sizeof(sBuffer));
    for(int i=1; i<= nRec; i++) {
        iDataLen = 1 + rand() % 16;     // 1..16
        s = f__ihx_recGenerate(s, uAddress, iDataLen);
        uAddress += (iDataLen*2);
        m.f_text(z, "rec[%2.2d] : '%s'",i,s);
        strcat(s,"\n");
//  =:= m:  fputs
        fputs(s, fp);
        iRc += 1;
    }

//  finish
    m.f_subMenu("ihxGenerate:finish", __LINE__);
    fclose(fp);
    return(iRc);

} // F~~ihxGenerator


bool F__ihxValidator(CTutor &m, const char* p_sFileTxt) {
    FILE* fp;
    char            z = m.E_COLOR_GRAY;
    char            sIhxRecord[C_IHX__REC_SIZE];
    char    *   s = sIhxRecord;
    int             i=0;
    char            sCrc[C_IHX__CRC_SIZE+1];
    char            sNum[C_IHX__NUM_SIZE+1];
    bool            bCrc, bRc=true;
    bool            bIgnoreEndingCrc=true;
    unsigned int    uLen,
                    uNum;
    unsigned int    uCrc_get,
                    uCrc_clc=0;

 //  init
    fp  = fopen(p_sFileTxt, "r");     assert(fp != NULL);
    memset(sIhxRecord, 0, sizeof(sIhxRecord));

    m.f_subMenu("while validate", __LINE__);

//  =:= m:  fgets
    while ( fgets(s,sizeof(sIhxRecord),fp) != NULL ) {

        i += 1;

        //  chop ending NL
        s[strcspn(s,"\n")] = 0;     // chop ending "\n"

        //  startByte?
        if (*s != C_IHX__STARTER) {
            continue;
        }

        //  ihxRecordSize
        uLen = strlen(s);

        //  fetch uNum size==2 bytes
        strncpy(sNum, s+1,C_IHX__NUM_SIZE);
        sNum[C_IHX__NUM_SIZE] = 0;
        uNum = f_sHex2Int(sNum);

        //  check uLen<>uNum
        /*  ":04A1A00273FBD50274"  : len=19, num=04,crc=74,
            strlen(x)== 19
                == startSize<1> + numSize<2> + typeSize<2> + addrSize<4> + numVal*2<8> +  crcSize<2>
                == 11 + numVal*2<8>
            strlen(x)-11 == numVal ?
        */
        if (uLen != 2*uNum+11) {
            continue;
        }

        //  fetch ending CRC, size==2 bytes
        strcpy(sCrc,s+uLen-C_IHX__CRC_SIZE);
        uCrc_get    =   f_sHex2Int(sCrc);

        //  is the CRC ok?
        uCrc_clc    =   f__ihx_crcCalculate(s,bIgnoreEndingCrc);
        bCrc        =   false;
        if (uCrc_get == uCrc_clc) {
            bCrc = true;
        } else {
            if (bRc) {
                bRc = false;
            }
        }

        //  show
        m.f_text(z, "rec[%2.2d] : '%s' *** LEN|NUM|CRC: %d|%d|%x => :%x => %d",
            i,s,
            uLen,
            uNum,
            uCrc_get, uCrc_clc,
            bCrc
            );
    }

    m.f_subMenu("validate:return", __LINE__);
    fclose(fp);
    return bRc;

} // F~~ihxValidator


int F__ihxCopy(CTutor &m, const char *p_sFileTxt, const char * p_sFileBin) {

    FILE* fpTxt;
    FILE* fpBin;

    char            z = m.E_COLOR_GRAY;
    char            sIhxRecord[C_IHX__REC_SIZE];
    char    *   s = sIhxRecord;
    int             iRec = 0;
    int             iDataOffset = 1 + C_IHX__NUM_SIZE + C_IHX__ADR_SIZE + C_IHX__TYP_SIZE;
    char            sCrc[C_IHX__CRC_SIZE+1];
    char            sNum[C_IHX__NUM_SIZE+1];
    char            sDat[C_IHX__DAT_SIZE+1];
    T_TUTOR__UINT8 uMaskBuffer[] = { 0x21 , 0xCC , 0xCC, 0xCC };
//  unsigned char   c;
    unsigned int    uLen,
                    uNum, uNumSum,
                    uCrc;
    unsigned int    uDat;

//  init
    memset(sIhxRecord, 0, sizeof(sIhxRecord));
    fpTxt = fopen(p_sFileTxt, "r");     assert(fpTxt != NULL);
    fpBin = fopen(p_sFileBin, "wb+");   assert(fpTxt != NULL);

    m.f_subMenu("ihxCopy:while(fp)", __LINE__);

//  =:= m:  fgets
    while ( fgets(sIhxRecord,sizeof(sIhxRecord),fpTxt) != NULL ) {

        iRec += 1;
        s = sIhxRecord;

        //  chop ending NL
        s[strcspn(s,"\n")] = 0;     // chop ending "\n"

        //  startByte?
        if (*s != C_IHX__STARTER) {
            m.f_puts(z,"start(%d) ?",iRec);
            continue;
        }

        //  fetch ending CRC, size==2 bytes
        uLen = strlen(s);

        //  fetch uNum size==2 bytes
        strncpy(sNum, s+1,C_IHX__NUM_SIZE);
        sNum[C_IHX__NUM_SIZE] = 0;
        uNum = f_sHex2Int(sNum);

        //  check
        if (uLen != (2*uNum)+11) {
            m.f_puts(z,"continue %d != %d",uLen,uNum);
            continue;
        }

        //  fetch Crc
        strcpy(sCrc, s + uLen - C_IHX__CRC_SIZE);
        sCrc[C_IHX__CRC_SIZE] = 0;
        uCrc  = f_sHex2Int(sCrc);

        //  fetch Data
        memset(sDat, 0, sizeof(sDat));
        uNumSum = 2 * uNum;
        strncpy(sDat, s+iDataOffset, uNumSum);
        sDat[uNumSum] = 0;

        //  convert
        s = sDat;
        uMaskBuffer[1] = iRec & 0xFF;
        fwrite(uMaskBuffer, 1, sizeof(uMaskBuffer), fpBin);
        for (unsigned int i = 0; i < strlen(sDat); i +=2 , s+= 2) {
            uDat = f_sHex2Int(s);   // m.f_text(z, "sDat[%d]=:%2.2x", uDat);
            fputc(uDat, fpBin);
        }

        //  show
        m.f_text(z, "rec[%2.2d] : '%s' *** NUM:'%u' CRC:'%2.2x' DAT:'%s'",
            iRec,sIhxRecord,
                uNum, uCrc, sDat);


    }

    m.f_subMenu("ihxCopy:return", __LINE__);
    fclose(fpBin);
    fclose(fpTxt);

    return iRec;

} // F~~ihxCopy


int F__ihxParser(CTutor &m, const char *pFile, char p_cByte) {
    int iPos = -1;
    char c;
    FILE* fp;
    int   i;
    char            z = m.E_COLOR_RED;

    m.f_subMenu("openParse", __LINE__);
    fp = fopen(pFile, "rb");
    fseek(fp, 1, SEEK_SET); // not Pos 0

    m.f_subMenu("seek", __LINE__);
    i = 0;
    while ( true ) {
        c = fgetc(fp);
        if (c == 0) {
            break;
        }
        if (c == p_cByte) {
            break;
        }
        if (++i > 10000) {
            m.f_text(z, "?MaxSeek reached [%2.2d]", i);  //!CRQ-230306:avoid endless loop
            break;
        }
    }

    m.f_subMenu("return", __LINE__);
    iPos = ftell(fp);
    fclose(fp);
    return iPos;
}


//  ===========================================================================
//  main
//  ===========================================================================

int F18_file(CTutor &m) {

    int             iEc;
    const char *    sHdr = "FileHandling";
    char            z = m.E_COLOR_GRAY;
    char    sFileTxt[128];
    char    sFileBin[128];
    char*   s;
    const char      sText[] = "ThisMusicIsElectronic";
    char            cBuffer[1024];
//  T_TUTOR__INT8          y;
    bool            bRc,
                    bSelfTest = true;
    int             i,
                    iRc,
                    nRecNumber;
    FILE            *fp;

//  =:= b:  body
    m.f_header(sHdr,__FILE__,__LINE__);
    iEc = m.f_iEc();

//  &&& fileName(TXT,BIN) &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

    m.f_menu("fileName", __LINE__);

//  =:= s: show scratchDir
    m.f_subMenu("scratchDir", __LINE__);
    m.f_text(z, "scratchDir => '%s'", m.f_sScratchDirectory());

//  =:= s:  getFileName TXT
    m.f_subMenu("fileName.TXT", __LINE__);

    s = F__getFileName(m,sFileTxt);
    m.f_text(z, "IHX.txt.File => '%s'", s);
    strcpy(sFileTxt,s);

    //  =:= s:  getFileName BIN
    m.f_subMenu("fileName.BIN", __LINE__);
    s = F__getFileName(m, sFileBin, ".bin");
    m.f_text(z, "FILE ihx.bin => '%s'", s);
    strcpy(sFileBin,s);

//  &&& write stuff &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    m.f_menu("write Stuff", __LINE__);

//  =:= s:  open+create

//  =:= m:  fopen
    m.f_subMenu("performOpen", __LINE__);
    fp = fopen(sFileTxt, "w+");
    assert (fp != 0);

//  =:= m:  fwrite
    m.f_subMenu("fwrite",__LINE__);
    size_t iBufferSize;
    iBufferSize = fwrite (sText , sizeof(char), sizeof(sText), fp);
    m.f_text(z, "fwrite.size => '%d'",iBufferSize );

//  =:= m:  fclose
    m.f_subMenu("fclose",__LINE__);
    fclose(fp);

//  =:= m:  fread
    m.f_subMenu("fread",__LINE__);
    fp = fopen(sFileTxt, "r");
    assert(fp != 0);
    memset(cBuffer,0,sizeof(cBuffer));
    iBufferSize = fread (cBuffer , sizeof(char), sizeof(cBuffer), fp);
    m.f_text(z, "read.size   => '%d'",iBufferSize );
    m.f_text(z, "read.Buffer => '%s'",cBuffer );
    fclose(fp);

//  &&& ihx generate &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

    m.f_menu("ihxGeneration", __LINE__);

    m.f_subMenu("selfTest", __LINE__);
    i  = rand() % 2;
    bSelfTest = (i == 0) ? true : false;
    m.f_text(z, "selfTest => '%d'",bSelfTest);

#define C_IHX_REC_GENERATE_MAX 20
    m.f_subMenu("records to generate", __LINE__);
    nRecNumber  = 1 + rand() % C_IHX_REC_GENERATE_MAX;

    m.f_subMenu("perform generate", __LINE__);
    F__ihxGenerator(m,sFileTxt,nRecNumber,bSelfTest);

    m.f_subMenu("result of generation", __LINE__);
    m.f_text(z, "ihxFile generated => '%s' with %d Records",
            sFileTxt, nRecNumber);

//  &&& ihx validate &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

    m.f_menu("ihxValidation...", __LINE__);
    bRc = F__ihxValidator(m, sFileTxt);
    m.f_subMenu("result of validation", __LINE__);
    m.f_text(z, "ihxFile isValid? => '%d'",bRc);

 //  &&& ihxCopy:TXT=>BIN &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

    m.f_menu("ihxCopy...", __LINE__);
    iRc = F__ihxCopy(m, sFileTxt, sFileBin);
    m.f_subMenu("result", __LINE__);
    m.f_text(z, "records copied =: %d", iRc);

 //  &&& ihxParser &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

    m.f_menu("ihxParser...", __LINE__);
    iRc = F__ihxParser(m, sFileTxt,':');
    m.f_subMenu("result", __LINE__);
    m.f_text(z, "parsed position =: %d", iRc);

//  =:= b:  body
    m.f_footer(sHdr,__FILE__,__LINE__);
    return(iEc);
};

#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor  m;
    if (p_iArgs >= 2) {
        m.f_mode_color(true);
    }
    return F18_file(m);
}
#endif
