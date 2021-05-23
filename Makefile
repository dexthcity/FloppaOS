kernel_source_files := $(shell find src/kernel -name *.c)
kernel_object_files := $(patsubst src/kernel/%.c, artefacts/kernel/%.o, $(kernel_source_files))

x86_64_c_source_files := $(shell find src/impl -name *.c)
x86_64_c_object_files := $(patsubst src/impl/%.c, artefacts/impl/%.o, $(x86_64_c_source_files))

x86_64_asm_source_files := $(shell find src/boot -name *.asm)
x86_64_asm_object_files := $(patsubst src/boot/%.asm, artefacts/boot/%.o, $(x86_64_asm_source_files))

x86_64_object_files := $(x86_64_c_object_files) $(x86_64_asm_object_files)

$(kernel_object_files): artefacts/kernel/%.o : src/kernel/%.c
	mkdir -p $(dir $@) && \
	x86_64-elf-gcc -c -I src/intf -ffreestanding $(patsubst artefacts/kernel/%.o, src/kernel/%.c, $@) -o $@

$(x86_64_c_object_files): artefacts/impl/%.o : src/impl/%.c
	mkdir -p $(dir $@) && \
	x86_64-elf-gcc -c -I src/intf -ffreestanding $(patsubst artefacts/impl/%.o, src/impl/%.c, $@) -o $@

$(x86_64_asm_object_files): artefacts/boot/%.o : src/boot/%.asm
	mkdir -p $(dir $@) && \
	nasm -f elf64 $(patsubst artefacts/boot/%.o, src/boot/%.asm, $@) -o $@

.PHONY: build

build: $(kernel_object_files) $(x86_64_object_files)
	mkdir -p iso_content && \
	x86_64-elf-ld -n -o artefacts/binary/kernel.bin -T src/linker.ld $(kernel_object_files) $(x86_64_object_files) && \
	cp artefacts/binary/kernel.bin iso_content/boot/kernel.bin && \
	grub-mkrescue -o build/FloppaOS.iso iso_content

clean:
	rm $(shell find artefacts -name *.o)
	rm $(shell find artefacts -name *.bin)
	rm $(shell find iso_content -name *.bin)
	rm $(shell find build -name *.iso)