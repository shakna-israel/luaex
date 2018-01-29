# luaex

This software is currently *alpha* quality, and unsuitable for any purpose.

---

## LICENSE

See the [LICENSE](LICENSE) file.

---

# Issues

---

Currently, we're just utilising luaL_dostring to handle everything.

However, that leaves a lot of edge cases, as embedded Lua doesn't seem to have access to everything interpreted Lua does.

For example, though luaex can compile some simple programs, it can't compile itself yet...

luaex compiles, but argc doesn't seem to get passed on to the inner Lua interpreter.

There's probably more edge cases.

---

Currently we link only to Lua 5.3, and luaex itself is only 5.3 compatible.

Some compatibility to Lua 5.1, 5.2 and Luajit would be appreciated.

---

We just trust cc exists, and works.

It would be nice if we could detect the system C compiler better.

Long-term, it would be much nicer if we could link to a static compiler lib, like libtcc, and include that in the distribution.

Then, a system compiler wouldn't be necessary.

(I don't want to link to LLVM - it's huge. I want to keep luaex small.)
