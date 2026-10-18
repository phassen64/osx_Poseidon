#   ***************************************************************************
#   My Python Tutorial  ::  advanced pyVersion 3.10
#   ***************************************************************************
#   coding:UTF8
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

import sys
assert sys.version_info >= (3,10)
import LIB_inc as m;  g = m.CLib();   sTc = 'TcV3.10'

'''
    !content:
        •   m:  match
        •   m:  dataClass
            •   s:  @decoDC.slot
        •   m:  list
            •   s:  mixed.annotated
        •   m:  any
        •   m:  NoReturn
        •   m:  args and kwargs
        •   m:  newType
        •   m:  protocol
        •   m:  typeGuard

'''

#   === :header
g.f_header(sTc)


#   ---------------------------------------------------------------------------
#   m:  match    <since Python v10+>
#   ---------------------------------------------------------------------------

g.f_menu("match")

def f_guess(p_iGuess: int) -> None:

    x = p_iGuess
    match x:            # !CRQ-240422:vPy<(3,10)
        case x if x < 0:
            g.f_text(f"{x} is not valid!")
        case 2:
            g.f_text(f"{x} very close!")
        case 4:
            g.f_text(f"{x} you won!")
        case 7 | 8 | 9:
            g.f_text(f"{x} close!")
        case _:
            g.f_text(f"{x} not the correct value!")

#   --- eof

i = -1; f_guess(i)      # notValid
i = 0;  f_guess(i)      # notCorrect
i = 2;  f_guess(i)      # veryClose
i = 3;  f_guess(i)      # notCorrect
i = 4;  f_guess(i)      # won
i = 5;  f_guess(i)      # notCorrect
i = 8;  f_guess(i)      # close


#   ---------------------------------------------------------------------------
#   m:  list
#   ---------------------------------------------------------------------------

#
#   s:  mixed.annotated
#
g.f_menu("mixed List annotation")

def f_append_list(
    p_List: list[float] | list[int], p_tValue: float | int) -> None:
    #   append using method
    p_List.append(p_tValue)     # type: ignore
#   --- eof

#   use any list
Lval: list[int | float] = [1, -2.9, 3]
g.f_text("L : %s" % str(Lval))

#   run
i = 815; f_append_list(Lval,i); g.f_text(f"L_after_f add{i} => {Lval}")
f = 47.11; f_append_list(Lval,f); g.f_text(f"L_after_f add{f} => {Lval}")
assert (Lval[3] == i)
assert (Lval[4] == f)

#   ---------------------------------------------------------------------------
#   m:  dataClass
#   ---------------------------------------------------------------------------

#   Slots in Python is a special mechanism that is used to reduce
#       memory of the objects.
#   In Python, all the objects use a dynamic dictionary for
#   adding an attribute.
#   Slots is a static type method in this no dynamic dictionary
#   are required for allocating attribute.22.06.2020

#   ---------------------------------------------------------------------------
#   m:  any
#   ---------------------------------------------------------------------------

g.f_menu("any")

from typing import Any

def F_any(a: Any) -> Any:
    return 2 * a

def F_test_any() -> None:
    F_any(2)
    F_any(2.0)
    F_any([])

if __name__ == "__main__":
    F_test_any()


#   ---------------------------------------------------------------------------
#   m:  NoReturn
#   ---------------------------------------------------------------------------

import sys
from typing import NoReturn
g.f_menu("noReturn")

def F_helloNone() -> None:
    g.f_text("Hello None")
    #   returns object None


def F_helloNoReturn() -> NoReturn:
    g.f_text("Hello NoReturn")
    sys.exit(0)

def F_test_noReturn() -> None:
    F_helloNone()
    #   noCall - else : noFooter
    #   F_helloNoReturn()

if __name__ == "__main__":
    F_test_noReturn()


#   ---------------------------------------------------------------------------
#   m:  args and kwargs
#   ---------------------------------------------------------------------------

from typing import Callable
g.f_menu("args && kwargs")

def F_args_kwargs(
        *p_args: int,
        **p_kwargs: int | float) -> None:
    g.f_text(f"{p_args}, {p_kwargs}")


def F_call_args_kwargs(
        p_fct: Callable[..., None],
        *p_args: int,
        **p_kwargs: int) -> None:
    return p_fct(*p_args, **p_kwargs)

def F_test_args_kwargs() -> None:
    F_call_args_kwargs(
        F_args_kwargs,
        1,
        2,
        3,
        a=1,
        b=2,
        c=3,
    )

if __name__ == "__main__":
    F_test_args_kwargs()

#   ---------------------------------------------------------------------------
#   m:  newType
#   ---------------------------------------------------------------------------

from typing import NewType
g.f_menu("newType")

TUserId1 = NewType("TUserId1", int)
TUserId2 = int

def F_name_by_id1(user_id: TUserId1) -> None:
    g.f_text("userId.1:<%s>" % user_id)

def F_name_by_id2(user_id: TUserId2) -> None:
    g.f_text("userId.2:<%s>" % user_id)

def F_test_newType() -> None:
    F_name_by_id1(TUserId1(42))
    F_name_by_id2(TUserId1(42))  # int => NewType
    F_name_by_id2(TUserId2(42))

if __name__ == "__main__":
    F_test_newType()


#   ---------------------------------------------------------------------------
#   m:  protocol    : stub define
#   ---------------------------------------------------------------------------
#   url: https://docs.python.org/3/library/collections.abc.html

g.f_menu("protocol")

from copy import deepcopy
from typing import Protocol

class SizedMutableIterable(Protocol):
    def __len__(self) -> Any:
        ...
    def __getitem__(self,idx: int) -> Any:
        ...
    def __setitem__(self,idx: int,val: Any) -> None:
        ...

def F_iterate_over_length(p_src: SizedMutableIterable) -> None:
    y: SizedMutableIterable = []
    y = deepcopy(p_src)     # only linkCopy is y = p_src
    g.f_text("pSrc = %s" % p_src)
    for i in range(len(p_src)):
        y[i] = i**2  # 1**0 == 0
        g.f_text("[%d] : src:'%s' => obj:'%s'" % (i,p_src[i],y[i]))

def F_test_protocol() -> None:
    L: list[Any] = [1, 2, 3]
    F_iterate_over_length(L)  # pyright: ignore

if __name__ == "__main__":
    F_test_protocol()


#   ---------------------------------------------------------------------------
#   m:  typeGuard
#   ---------------------------------------------------------------------------

#   Code ausführen in Abhängigkeit vom verwendeten Datentyp

g.f_menu("typeGuard")

from typing import TypeGuard

def F_is_str_list(lst: list[object]) -> TypeGuard[list[str]]:
    return all(isinstance(s, str) for s in lst)

def F_is_int_list(lst: list[object]) -> TypeGuard[list[int]]:
    return all(isinstance(s, int) for s in lst)

def F_test_typeGuard(lst: list[object]) -> None:
    if F_is_str_list(lst):
        g.f_text(f"lst str: {lst}")
    elif F_is_int_list(lst):
        g.f_text(f"lst int: {lst}")

if __name__ == "__main__":
    F_test_typeGuard(["1", "2"])
    F_test_typeGuard(["peter", "harvey"])


#   === :footer
g.f_footer(sTc)
