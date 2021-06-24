SDKDIR=./sdk

default: 
	@echo "Building Kernel"
	make -C ./kernel
#	@echo "Building SDK"
#	make -C ./sdk
#	@echo "Building Userland"
#	make -C ./userland

help:
	@echo "Makefile for Building Dev Operating System."
	@echo "Usage: make [ clean | help | zip | run] " 
	@echo ""
	@echo
	

zip:
	zip -r devos-$(VERSION).zip ./


run:
	@echo "Running Dev Operating System."
	cd ./sdk && sudo bash ./diskimage.sh
	cd ./sdk && ./qemu.sh

clean:
	make -C ./kernel clean
	make -C ./userland clean
