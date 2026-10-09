CC ?= gcc
AARCH64_CC ?= aarch64-linux-gnu-gcc
CFLAGS ?= -O3 -flto -fomit-frame-pointer -Wall
AARCH64_CFLAGS ?= -O3 -flto -fomit-frame-pointer -march=armv8-a+crypto+crc -Wall
LDFLAGS ?= -static -lssl -lcrypto -latomic -lz -lzstd -lpthread -ldl

TARGET_X86 = bb-fast-x86_64
TARGET_ARM = bb-fast-aarch64
TARGET_DEFAULT = bb-fast
SRC = fast.c

all: $(TARGET_DEFAULT) $(TARGET_X86) $(TARGET_ARM)

$(TARGET_DEFAULT): $(SRC)
	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
	strip $@

$(TARGET_X86): $(SRC)
	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
	strip $@

$(TARGET_ARM): $(SRC)
	$(AARCH64_CC) $(AARCH64_CFLAGS) $< -o $@ $(LDFLAGS)
	aarch64-linux-gnu-strip $@

clean:
	rm -f $(TARGET_DEFAULT) $(TARGET_X86) $(TARGET_ARM) bb-fast-*

.PHONY: all clean
