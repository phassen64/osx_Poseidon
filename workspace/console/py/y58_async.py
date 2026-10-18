#   ***************************************************************************
#   My Python Tutorial  ::  async
#   ***************************************************************************
#   url:
#   https://docs.python.org/3/library/asyncio.html
#   coding:UTF8
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$


#   === :header
import asyncio
import LIB_inc as m;  g = m.CLib();   sTc = 'TcAsync'

#   === :content
'''
        b:  helper
        b:  body
'''

#
#   b:  helper
#

async def F(p_sName: str) -> None:
    await asyncio.sleep(2)
    g.f_text(f"Task {p_sName}")


async def F_ernie() -> None:
    g.f_menu("Ernie")
    await F("A")
    await F("B")
    await F("C")


async def F_bert() -> None:
    g.f_menu("Bert")
    L = await asyncio.gather(F("A"), F("B"), F("C"))
    pTaskList = [F("A"), F("B"), F("C")]
    L = await asyncio.gather(*pTaskList)
    g.f_text(L)

#
#   b:  body
#

if __name__ == "__main__":
    g.f_header(sTc)
    iRnd = g.f_iRandom(1,0)
    if (iRnd == 1):
        asyncio.run(F_ernie())
    else:
        asyncio.run(F_bert())
    g.f_footer(sTc)
