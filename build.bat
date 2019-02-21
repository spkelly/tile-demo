call rgbasm -E -o main.o main.asm
call rgblink -o main.gb -m main.map -n main.sym main.o
call rgbfix main.gb