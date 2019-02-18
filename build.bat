call rgbasm -o main.o main.asm
call rgblink -o main.gb main.o
call rgbfix main.gb