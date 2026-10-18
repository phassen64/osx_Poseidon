//  ****************************************************************************
//  TUTORIAL:   C++     :   STL
//  ****************************************************************************
//  !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿß-------$
/*
    content:
        •   C:  TheStandardTemplateLibrary
            •   m:  vector
            •   m:  vector.square
            •   m:  stack
            •   m:  list
            •   m:  set
            •   m:  map
            •   m:  valarray
    url:
        •   https://de.wikipedia.org/wiki/Standard_Template_Library
        •   https://cplusplus.com/reference/vector/vector/
    run:
        •   $psh>_c .\c29_STL.cpp; .\run.exe
 */


#include "Tutor.h"
using namespace std;

#include <algorithm>        //  std::random_shuffle

#include <vector>           //  STL:Vector
#include <stack>            //  STL:Stack
#include <list>             //  STL:List
#include <set>              //  STL:Set
#include <map>              //  STL:Map
#include <valarray>         //  STL:valArray


int F__vector(CTutor &m) {
    int             iEc = m.f_iEc();
    const char*     sHdr =  "STL.vector";
    const int       C_iMaxNumberOfPlaycards = 32;
    const int       C_iMaxPlay = 9;
    string          STmp;
    int             i;
    int             iIdx;
    char            z = m.E_COLOR_GRAY;
//  my cards
    int             aiShuffle[C_iMaxPlay];
    string  asColor[4]      = {
            "Kreuz", "Pik", "Herz", "Caro" };
    string  asNumber[8]     = {
            "As", "Koenig", "Dame", "Bube", "10", "9", "8", "7"  };
    string  asPlayCard[C_iMaxNumberOfPlaycards];

//  =:= b:  body
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);

//  =:= m:  vector
    m.f_menu(sHdr, __LINE__);
    m.f_subMenu("using STL algorithm", __LINE__);

//  =:= s:  STL.define
    vector<int>     STL_i;
    vector<string>  STL_S;

//  =:= s:  init playCards
    m.f_subMenu("playCards init", __LINE__);
    iIdx = 0;
    for(int i=0; i<4; i++) {
        for(int j=0; j<8; j++) {
            asPlayCard[iIdx] = asColor[i] + ":" + asNumber[j];
            iIdx += 1;
        }
    }

//  =:= s:  init numbers
    for (int i=0; i<C_iMaxNumberOfPlaycards; ++i) {
        STL_i.push_back(i);
    }
    m.f_subMenu("init my values", __LINE__);
    m.f_text(z,"myvector contains ...");
    cout << "\t";
    for (vector<int>::iterator p=STL_i.begin(); p!=STL_i.end(); ++p) {
        std::cout << ' ' << *p;
    }
    cout << endl;

//  =:= s:  shuffle
    m.f_subMenu("shuffle", __LINE__);
    random_shuffle( STL_i.begin(), STL_i.end() );
    m.f_text(z,"after shuffling ...");
    cout << "\t";
    i=0;
    for (vector<int>::iterator p=STL_i.begin(); p!=STL_i.end(); ++p, ++i) {
        std::cout << ' ' << *p;
        if (i<C_iMaxPlay) {
            aiShuffle[i] = *p;    // save shuffle value
        }
    }
    cout << endl;

//  =:= s:  push<card>
    m.f_subMenu("put onto stack", __LINE__);
    for (int i=0; i<C_iMaxNumberOfPlaycards; i++) {
        if (i >= C_iMaxPlay) break;
        iIdx    =   aiShuffle[i];
        STmp    =   asPlayCard[iIdx];
        STL_S.push_back(STmp);
        m.f_text(z,"playCard.show[%d]:<%s>",i+1,STmp.c_str());
    }

//  =:= s:  reversePop<card>
    m.f_subMenu("reverse output", __LINE__);
    cout << "\t";
    cout << "und in umgekehrter Reihenfolge wieder aufdecken..." << endl;
    vector<string>::iterator p=STL_S.end();
    i = 0;
    while(p != STL_S.begin())
    {
        p--;
        STmp = *p;
        m.f_text(z,"playCard[%d]:<%s>",i+1,STmp.c_str());
        i++;
    }

    m.f_subMenu("finish", __LINE__);
    m.f_text(z,"iEc =: %d",iEc);
    return(iEc);
}


//  chapter::13.10
template <class T> T minneu(T a, T b)
{
    T minimum = a;
        if(a != b)
            while(++a != b)
                if(*a < *minimum)
                    minimum = a;
    return(minimum);
}

int F__vector_Square(CTutor &m) {
    int             iEc = m.f_iEc();
    const char*     sHdr =  "STL.vector.square";
    const int       C_iMaxSize = 6;
    char            z = m.E_COLOR_GRAY;

//  =:= b:  body
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);

//  =:= m:  vector.square
    m.f_menu(sHdr, __LINE__);

//  =:= s:  STL.define
    vector<int>     STL_vector(C_iMaxSize);

//  =:= s: vector init
    for(int i = 0; i < C_iMaxSize; ++i)
        STL_vector[i] = i * i;

    cout << "\t";
    cout << "Das Minimum der Quadratzahlen von 3 bis 4 ist: " << endl;

    cout << "\t";
    cout << *(minneu(STL_vector.begin() + 3, STL_vector.end()));
    cout << endl;

    m.f_subMenu("finish", __LINE__);
    m.f_text(z,"iEc =: %d",iEc);
    return(iEc);
}


int F__stack(CTutor &m) {
    int             iEc = m.f_iEc();
    const char*     sHdr =  "STL.stack";
    const int       C_iMaxSize = 5;
    char            z = m.E_COLOR_GRAY;
    int             n;
    string          S;

//  =:= b:  body
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);

//  =:= m:  stack
    m.f_menu(sHdr, __LINE__);

//  =:= s:  STL.define
    stack<int>      STL_stack;

//  =:= s:  fill the stack with: push
    m.f_subMenu("push", __LINE__);
    for(int i = 0; i < C_iMaxSize; ++i) {
        n = i+100;
        STL_stack.push(n);
        m.f_text(z,"Stack.push[%d] =:%d",i,n);
    }

//  =:= s:  show the stack
    m.f_subMenu("top", __LINE__);
    n = STL_stack.top();
    m.f_text(z,"Stack.top =: %d", n);

//  =:= s:  pop
    m.f_subMenu("pop", __LINE__);
    for(int i = 0; i < C_iMaxSize; ++i) {
        n = STL_stack.top();
        STL_stack.pop();
        m.f_text(z,"Stack.popped[%d] =:%d",C_iMaxSize-i-1,n);
    }

    m.f_subMenu("finish", __LINE__);
    m.f_text(z,"iEc =: %d",iEc);
    return(iEc);
}


int F__list(CTutor &m) {
    int             iEc = m.f_iEc();
    const char*     sHdr =  "STL.list";
    const int       C_iMaxSize = 8;
    char            z = m.E_COLOR_GRAY;
    int             i,p,q,n;
    string          S;

//  =:= b:  body
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);

//  =:= m:  list
    m.f_menu(sHdr, __LINE__);

//  =:= s:  STL.define
    list<int>   STL_list;

//  =:= s:  fill the LIST with: push at BACK and FRONT
    m.f_subMenu("push back&front", __LINE__);
    for(int i = 0; i < C_iMaxSize/2; ++i) {
        p = m.f_iRandom(C_iMaxSize,1);
        q = m.f_iRandom(C_iMaxSize,1);
        STL_list.push_back(p);
        STL_list.push_front(q);
        m.f_text(z,"List.push[%d]  back:<%d> front:<%d>",i,p,q);
    }

//  =:= s:  show the list
    m.f_subMenu("show", __LINE__);
    i = 0;
    for (list<int>::iterator p = STL_list.begin(); p != STL_list.end(); ++p) {
        n = *p;
        m.f_text(z,"List[%d] =:%d",i++,n);
    }

//  =:= s:  list::sort
    m.f_subMenu("sort", __LINE__);
    STL_list.sort();
    i = 0;
    for (list<int>::iterator p = STL_list.begin(); p != STL_list.end(); ++p) {
        n = *p;
        m.f_text(z,"List.sorted[%d] =:%d",i++,n);
    }

//  =:= s:  list::reverse
    m.f_subMenu("reverse", __LINE__);
    STL_list.reverse();
    i = 0;
    for (list<int>::iterator p = STL_list.begin(); p != STL_list.end(); ++p) {
        n = *p;
        m.f_text(z,"List.reversed[%d] =:%d",i++,n);
    }

//  =:= s:  list::uniq
    m.f_subMenu("uniq", __LINE__);
    STL_list.unique();
    i = 0;
    for (list<int>::iterator p = STL_list.begin(); p != STL_list.end(); ++p) {
        n = *p;
        m.f_text(z,"List.uniq[%d] =:%d",i++,n);
    }

//  =:= s:  list::sort2
    m.f_subMenu("sort2", __LINE__);
    STL_list.sort();
    i = 0;
    for (list<int>::iterator p = STL_list.begin(); p != STL_list.end(); ++p) {
        n = *p;
        m.f_text(z,"List.sort&uniq[%d] =:%d",i++,n);
    }

//  =:= s:  erase at front
    m.f_subMenu("pop", __LINE__);
    i = 0;
    while (!STL_list.empty()) {
        n = STL_list.front();
        STL_list.pop_front();
        m.f_text(z,"List.frontPopped[%d] =:%d",i++,n);
    }

    m.f_subMenu("finish", __LINE__);
    m.f_text(z,"iEc =: %d",iEc);
    return(iEc);
}


int F__set(CTutor &m) {
    int             iEc = m.f_iEc();
    const char*     sHdr =  "STL.set";
    const int       C_iMaxSize = 10;
    char            z = m.E_COLOR_GRAY;
    int             i, n;
    size_t          tSize;
    string          S;

//  =:= b:  body
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);

//  =:= m:  set
    m.f_menu(sHdr, __LINE__);

//  =:= s:  STL.define
    set<int>    STL_set;

//  =:= s:  size
    m.f_subMenu("maxSize", __LINE__);
    tSize   = STL_set.max_size();
    m.f_text(z,"'STL'.max_size() =: '%llu'",tSize);  // 461168601842738790

//  =:= s:  fill
    m.f_subMenu("fill", __LINE__);
    for(int i=0; i <C_iMaxSize; i++) {
        n = m.f_iRandom(C_iMaxSize/2,1);
        STL_set.insert(n);
        m.f_text(z,"filled SET[%d] =:%d",i,n);
    }

//  =:= s:  show
    m.f_subMenu("show", __LINE__);
    i = 0;
    for (set<int>::iterator p = STL_set.begin(); p != STL_set.end(); ++p) {
        n = *p;
        m.f_text(z,"SET.show[%d] =:%d",i++,n);
    }

//  =:= s:  check
    m.f_subMenu("check a number", __LINE__);
    n = m.f_iRandom(C_iMaxSize/2,1);  m.f_text(z,"check =: %d",n);
    i = STL_set.count(n);
    m.f_text(z,"found<%d> in SET timesX =: %d",n,i);

//  =:= s:  current size
    m.f_subMenu("current size", __LINE__);
    n = STL_set.size();
    m.f_text(z,"current SET size =: %d",n);

//  =:= s:  finish
    m.f_subMenu("finish", __LINE__);
    m.f_text(z,"iEc =: %d",iEc);
    return(iEc);
}



int F__map(CTutor &m) {
    int             iEc = m.f_iEc();
    const char*     sHdr =  "STL.map";
    char            z = m.E_COLOR_GRAY;
    char            cKey,cVal;
    int             i, iKey, iVal;
    string          SVal;
    //  * using STL pair
    typedef         pair<int, string> T_STL_pair;
    T_STL_pair      tPair;
    size_t          tSize;
    bool            bEmpty;


//  =:= b:  body
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);

//  =:= m:  map
    m.f_menu(sHdr, __LINE__);

//  =:= s:  STL.define

//  *
//  *   &&& map:STL.map.letter
//  *

//  =:= s:  init.map.letter
    map<char,int>    STL_map;
    m.f_subMenu("map.Letter", __LINE__);

//  =:= s:  map.empty
    bEmpty = STL_map.empty();
    m.f_text(z,"MAP.letter.empty =: <%d>",bEmpty);

//  =:= s:  map.addData
    STL_map['a']    = 1 + rand() % 100;
    STL_map['b']    = 1 + rand() % 100; ;
    STL_map['c']    = 1 + rand() % 100;;

//  =:= s:  show.LETTER
    m.f_subMenu("show map.letter", __LINE__);
    i = 0;
    for (map<char,int>::iterator p = STL_map.begin(); p != STL_map.end(); ++p) {
        cVal = p->first;
        iKey = p->second;
        m.f_text(z,"MAP.letter[%d] =: <%c,%d>",i++,cVal,iKey);
    }

//  =:= s:  map.methods...
    m.f_subMenu("map.letter.methods", __LINE__);
    tSize = STL_map.size();
    m.f_text(z,"MAP.letter.size =: <%d>",tSize);
    tSize = STL_map.max_size();
    m.f_text(z,"MAP.letter.max_size =: <%llu>",tSize);
    cKey = 'c';
    iVal = STL_map.at(cKey);
    m.f_text(z,"MAP.letter('%c') =: <%d>",cKey,iVal);

//  =:= s:  map.empty
    bEmpty = STL_map.empty();
    m.f_text(z,"MAP.letter.empty =: <%d>",bEmpty);

//  =:= s:  map.clear&&empty
    STL_map.clear();
    bEmpty = STL_map.empty();
    m.f_text(z,"MAP.clear");
    m.f_text(z,"MAP.letter.empty after clear =: <%d>",bEmpty);

//  *
//  *   &&& map:STL.map.planet
//  *

//  =:= s:  init.map.planet - using:make_pair()
    m.f_subMenu("map.planet", __LINE__);
    map<string,int>    STL_map__planet;
    STL_map__planet.insert(make_pair("merkur",1));
    STL_map__planet.insert(make_pair("venus",2));
    STL_map__planet.insert(make_pair("earth",3));
    STL_map__planet.insert(make_pair("mars",4));
    STL_map__planet.insert(make_pair("jupiter",5));
    STL_map__planet.insert(make_pair("saturn",6));

//  =:= s:  show.map.PLANET
    m.f_subMenu("show map.planet", __LINE__);
    i = 0;
    map<string,int>::iterator p;
    for ( p = STL_map__planet.begin(); p !=STL_map__planet.end(); ++p ) {
        SVal    = p->first;
        iKey    = p->second;
        m.f_text(z,"MAP.planet[%d] =: <%s,%d>",i++,SVal.c_str(),iKey);
    }

//  =:= s:  map.size
    m.f_subMenu("map.planet.size", __LINE__);
    tSize = STL_map__planet.size();
    m.f_text(z,"MAP.planet.size =: <%d>",tSize);
    tSize = STL_map__planet.max_size();
    m.f_text(z,"MAP.planet.max_size =: <%llu>",tSize);

//  =:= s:  map.[]
    m.f_subMenu("map.planet[x]", __LINE__);
    SVal = "venus";
    iKey = STL_map__planet[SVal];
    m.f_text(z,"MAP.planet['%s'] =: <%d>",SVal.c_str(),iKey);

//  =:= s:  map.at      * usually [] and bounds check
    m.f_subMenu("map.planet.at", __LINE__);
    SVal = "jupiter";
    iKey = STL_map__planet.at(SVal);
    m.f_text(z,"MAP.planet.at('%s') =: <%d>",SVal.c_str(),iKey);

//  *
//  *   &&& map:STL.map.vehicle
//  *

//  =:= s:  init.map.vehicle - using STL.pair
    map<int,string>    STL_map__vehicle;
    m.f_subMenu("map.Vehicle", __LINE__);

    tPair.first     = 1;
    tPair.second    = "bike";
    STL_map__vehicle.insert(tPair);
    tPair.first     = 5;
    tPair.second    = "car";
    STL_map__vehicle.insert(tPair);
    tPair.first     = 11;
    tPair.second    = "train";
    STL_map__vehicle.insert(tPair);
    tPair.first     = 31;
    tPair.second    = "ship";
    STL_map__vehicle.insert(tPair);

//  =:= s:  show.VEHICLE
    m.f_subMenu("show map.vehicle", __LINE__);
    i = 0;
    map<int,string>::iterator pVehicle;
    for (   pVehicle = STL_map__vehicle.begin();
            pVehicle !=STL_map__vehicle.end();
            ++pVehicle )
    {
        iKey    = pVehicle->first;
        SVal    = pVehicle->second;
        m.f_text(z,"MAP.vehicle[%d] =: <%d,%s>",i++,iKey,SVal.c_str());
    }

//  =:= s:  map.size
    m.f_subMenu("map.vehicle.size", __LINE__);
    tSize = STL_map__vehicle.size();
    m.f_text(z,"MAP.vehicle.size =: <%llu>",tSize);
    tSize = STL_map__vehicle.max_size();
    m.f_text(z,"MAP.vehicle.max_size =: <%llu>",tSize);

//  =:= s:  finish
    m.f_subMenu("finish", __LINE__);
    m.f_text(z,"iEc =: %d",iEc);
    return(iEc);
}


int F__valArray__inc(int x) {return ++x;}

int F__valArray(CTutor &m) {
    int             iEc = m.f_iEc();
    const char*     sHdr =  "STL.valArray";
    char            z = m.E_COLOR_GRAY;
    size_t          tSize;

//  =:= b:  body
    m.f_chapter(sHdr, __FUNCTION__, __LINE__);

//  =:= m:  valarray
    m.f_menu(sHdr, __LINE__);

//  =:= s:  init STL<int>
#ifdef __USE_TUTOR__STD_C11
    valarray<int> STL_valarray_i = { 1, 2, 3, 4, 10 }; // 1+2+..+10=20
#else
    int aiVal[]={ 1, 2, 3, 4, 10 };
    valarray<int> STL_valarray_i(aiVal,5);
#endif

//  =:= s:  STL.i{size|sum|max|min}
    m.f_subMenu("STL.f{size|sum|max|min}", __LINE__);
    m.f_text(z,"STL.i.size()    =: '%llu'", STL_valarray_i.size());
    m.f_text(z,"STL.i.sum()     =: '%d'",   STL_valarray_i.sum());
#ifdef _MSC_VER
    #undef max
    #undef min
#endif
    m.f_text(z,"STL.i.max()     =: '%d'",   STL_valarray_i.max());
    m.f_text(z,"STL.i.min()     =: '%d'",   STL_valarray_i.min());

//  =:= s:  init STL<float>
#ifdef __USE_TUTOR__STD_C11
    valarray<double> STL_valarray_f = { -3.5, 10.2, -5.1 };  // sum=1.6
#else
    double afVal[]={ -3.5, 10.2, -5.1 };
    valarray<double> STL_valarray_f(afVal,3);
#endif

//  =:= s:  STL.f{size|sum|max|min}
    m.f_subMenu("STL.f{size|sum|max|min}", __LINE__);
    m.f_text(z,"STL.f.size()    =: '%llu'", STL_valarray_f.size());
    m.f_text(z,"STL.f.sum()     =: '%f'",   STL_valarray_f.sum());
#ifdef _MSC_VER
    #undef max
    #undef min
#endif
    m.f_text(z,"STL.f.max()     =: '%f'",   STL_valarray_f.max());
    m.f_text(z,"STL.f.min()     =: '%f'",   STL_valarray_f.min());

//  =:= s:  STL.i.apply
    m.f_subMenu("STL.i.apply", __LINE__);

    //  * define
    //  * url:  https://cplusplus.com/reference/valarray/valarray/max/
    int aiNumber[]={10,20,30,40,50};
    std::valarray<int> STL_valarray_a(aiNumber,5);

    //  *   foeach in ai { run F() }
    std::valarray<int> STL_valarray_tmp = STL_valarray_a.apply(F__valArray__inc);

    //  *   show loop
    m.f_subMenu("STL.a foreach", __LINE__);
    for(size_t i=0; i<STL_valarray_tmp.size(); i++) {
        tSize = i;
        m.f_text(z,"STL.a.tmp[%d] =\t'%d'=>'%d'",
            tSize,
            aiNumber[i],
            STL_valarray_tmp[i]);
    }

//  =:= s:  finish
    m.f_subMenu("finish", __LINE__);
    m.f_text(z,"iEc =: %d",iEc);
    return(iEc);
}


int F29_STL(CTutor &m) {
    int             iRc,iEc;
    const char*     sHdr =  "STL";
    iEc = m.f_header(sHdr, __FILE__, __LINE__);
    iRc = F__vector(m);             if (iRc != iEc) { return iRc; }
    iRc = F__vector_Square(m);      if (iRc != iEc) { return iRc; }
    iRc = F__stack(m);              if (iRc != iEc) { return iRc; }
    iRc = F__list(m);               if (iRc != iEc) { return iRc; }
    iRc = F__set(m);                if (iRc != iEc) { return iRc; }
    iRc = F__map(m);                if (iRc != iEc) { return iRc; }
    iRc = F__valArray(m);           if (iRc != iEc) { return iRc; }
    m.f_footer(sHdr, __FILE__, __LINE__);
    return(iEc);
};

#ifndef __USE_TUTOR__MAIN
int main(int p_iArgs, char *p_sArgv[]) {
    CTutor  m;
    if (p_iArgs >= 2) {
        m.f_mode_color(true);
    }
    return F29_STL(m);
}
#endif
