#!/bin/sh

echo 'print("Hello, World!")' > test1.lua
lua luaex.lua test1.lua
luv=$(lua test1.lua)
cv=$(./test1)
if [ $luv -eq $cv]; then
	echo "Passed Test 1"
else
	echo "Error"
	exit(-1)
fi