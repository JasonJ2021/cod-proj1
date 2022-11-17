.PHONY:all , clean

all:
	PATH=$PATH:/opt/riscv/bin/
	riscv32-unknown-elf-gcc -c sha256opt.s -o sha256opt.o
	riscv32-unknown-elf-gcc sha256opt.o -o sha256opt
	rm sha256opt.o
	cp ./sha256opt ../whisper/build-Linux
clean:
	rm sha256opt