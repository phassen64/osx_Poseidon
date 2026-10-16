#   ***************************************************************************
#   My Python Tutorial  :: thread
#   ***************************************************************************
#   !$@€ƒ„…†‡‰ŠŒŽ“”•—™šœžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖØÜÞßäæçîðñôö÷üýþÿ

#   url:
#   https://www.geeksforgeeks.org/multithreading-python-set-1/

'''
    !content:
        m:  define.function
        m:  define.argumentTuple
        m:  create.thread
            s:  check.create
        m:  run.thread
            s:  check.run
        m:  join.thread
            s:  check.join
'''

#   === :header
import threading
import LIB_inc as m;  g = m.CLib();   sTc = 'TcThread'
g.f_header(sTc)

#   m:  define.function
def f_print_cube(p_fNum):
    g.f_sleep(1)
    g.f_text("<<< volume.Cube: {}\n" .format(p_fNum * p_fNum * p_fNum))

def f_print_square(p_fNum):
    g.f_sleep(1)
    g.f_text("<<< area.Square: {}\n" .format(p_fNum * p_fNum))

if __name__ != "__main__":
    quit()

#   m:  define.argumentTuple
g.f_menu("define argument tuple")
tArg = (10.1,)    # a tuple with 1 element
g.f_text("t    : %s" % (str(tArg)))
g.f_text("type : %s" % (type(tArg)))
g.f_text("len  : %d" % (len(tArg)))

#   m:  create.thead
n1,n2 = 'tSqr','tCub'
t1 = threading.Thread(target=f_print_square, name=n1, args=tArg)
t2 = threading.Thread(target=f_print_cube, name=n2, args=tArg)

#   s:  check.create
g.f_menuS1("check.created")
b1 = t1.is_alive()
b2 = t2.is_alive()
g.f_text(f"Ident: {t1.ident}")         # None
g.f_text(f"Alive: {t1.is_alive()}")    # False
g.f_text(f"Name: {t1.name}")           # tSqr
assert (b1 is False)
assert (b2 is False)
assert (t1.name == n1)
assert (t2.name == n2)

#   m:  run.thread
g.f_menu("run thread")
t1.start()
t2.start()

#   s:  check.run
g.f_menuS1("check.run")
b1 = t1.is_alive()
b2 = t2.is_alive()
g.f_text(f"Ident: {t1.ident}")         # != None
g.f_text(f"Ident: {t2.ident}")         # != None
g.f_text(f"Alive: {t1.is_alive()}")    # False
g.f_text(f"Name: {t2.name}")           # tCub
assert (b1 is True)
assert (b2 is True)
assert (t2.name == n2)

#   m:  join.thread
g.f_menu("joind threads")
t1.join()
t2.join()

#   s:  check.join
g.f_menuS1("check.join")
b1 = t1.is_alive()
b2 = t2.is_alive()
g.f_text(f"Alive: {t1.is_alive()}")    # False
g.f_text(f"Name: {t1.name}")           # tSqr
assert (b1 is False)
assert (b2 is False)

#   m:  join.ready
g.f_print("Done !\n",g.C_COLOR_CYAN)

#   === :footer
g.f_footer(sTc)
