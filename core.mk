include config.mk
include scripts/$(ARCH).mk

#####################################
# Gather sources from cube makefile
#####################################
C_SRC += $(C_SOURCES)
AS_SRC += $(ASM_SOURCES)
INC += $(C_INCLUDES)
AS_INC += $(AS_INCLUDES)
DEFS += $(C_DEFS)

#####################################
# Compiler configurations
#####################################
CC = $(PREFIX)clang
CPPC = $(PREFIX)clang++
LD = $(PREFIX)clang
SIZE = $(PREFIX)llvm-size
COPY = $(PREFIX)llvm-objcopy
DUMP = $(PREFIX)llvm-objdump

COMPILER_FLAGS += $(ARCH_FLAGS)
COMPILER_FLAGS += -ffreestanding
COMPILER_FLAGS += -O$(OPT_LEVEL)
COMPILER_FLAGS += -Wall
COMPILER_FLAGS += -Wextra
COMPILER_FLAGS += -Wshadow
COMPILER_FLAGS += -Wdouble-promotion
COMPILER_FLAGS += -Wno-unused-parameter
COMPILER_FLAGS += -Wno-unused-const-variable
COMPILER_FLAGS += -g$(DBG_LEVEL)
COMPILER_FLAGS += -MMD
COMPILER_FLAGS += -MP
COMPILER_FLAGS += -I"$(SYSROOT)/include"
COMPILER_FLAGS += -I"$(LIBGCC)$(LIB_SUBPATH)"
COMPILER_FLAGS += -fdata-sections
COMPILER_FLAGS += -ffunction-sections
COMPILER_FLAGS += -fstack-size-section
COMPILER_FLAGS += -Wno-parentheses-equality
COMPILER_FLAGS += -pipe

C_FLAGS += $(COMPILER_FLAGS)
C_FLAGS += -std=$(C_STD)
C_FLAGS += $(INC)
C_FLAGS += $(DEFS)

CPP_FLAGS += $(COMPILER_FLAGS)
CPP_FLAGS += -std=$(CPP_STD)
CPP_FLAGS += -fno-exceptions
CPP_FLAGS += -fno-rtti
CPP_FLAGS += -fno-threadsafe-statics
CPP_FLAGS += $(INC)
CPP_FLAGS += $(DEFS)
CPP_FLAGS += -flto

LD_FLAGS += $(ARCH_FLAGS)
LD_FLAGS += -ffreestanding  -nodefaultlibs -nostdlib -nostdlib++
LD_FLAGS += --for-linker=--Bstatic
LD_FLAGS += --for-linker=--gc-sections
LD_FLAGS += --for-linker="--Map=$(BUILD_DIR)/$(TARGET).map"
LD_FLAGS += --for-linker="--script=$(LDSCRIPT)"
LD_FLAGS += --for-linker=-L="$(SYSROOT)/lib/$(LIB_SUBPATH)"
LD_FLAGS += --for-linker=-L="$(LIBGCC)$(LIB_SUBPATH)"
LD_FLAGS += --for-linker=-lc_nano
LD_FLAGS += --for-linker=-lm
LD_FLAGS += --for-linker=-lnosys
LD_FLAGS += --for-linker=-lgcc
LD_FLAGS += --for-linker="$(LIBGCC)$(LIB_SUBPATH)crti.o"
LD_FLAGS += --for-linker="$(LIBGCC)$(LIB_SUBPATH)crtbegin.o"
LD_FLAGS += --for-linker="$(LIBGCC)$(LIB_SUBPATH)crtend.o"
LD_FLAGS += --for-linker="$(LIBGCC)$(LIB_SUBPATH)crtn.o"
# LD_FLAGS += --for-linker="$(LIBGCC)$(LIB_SUBPATH)crtfastmath.o"
LD_FLAGS += -fuse-ld=lld
ifeq ($(VERBOSE),y)
Q:=
else
Q:=@
endif


#####################################
# Build
#####################################
# list of objects
# C
OBJECTS = $(addprefix $(BUILD_DIR)/,$(C_SRC:.c=.o))
vpath %.c $(sort $(dir $(C_SRC)))
# CPP
OBJECTS += $(addprefix $(BUILD_DIR)/,$(CPP_SRC:.cpp=.o))
vpath %.cpp $(sort $(dir $(CPP_SRC)))

OBJECTS += $(addprefix $(BUILD_DIR)/,$(AS_SRC:.s=.o))
vpath %.s $(sort $(dir $(AS_SRC)))

DEP = $(OBJECTS:%.o=%.d)

$(info C sources: $(C_SRC))
$(info CPP sources: $(CPP_SRC))
$(info ASM sources: $(ASM_SRC))

all: size $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).lst $(BUILD_DIR)/$(TARGET).bin

-include $(DEP)

$(BUILD_DIR)/%.o: %.c Makefile core.mk| $(BUILD_DIR)
	@mkdir -p $(dir $@)
	$(Q)$(CC) $(C_FLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: %.cpp Makefile core.mk | $(BUILD_DIR)
	@mkdir -p $(dir $@)
	$(Q)$(CPPC) $(CPP_FLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: %.s Makefile core.mk | $(BUILD_DIR)
	@mkdir -p $(dir $@)
	$(Q)$(CC) $(COMPILER_FLAGS) $(AS_INC) $(AS_DEFS) -x assembler-with-cpp -c $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS)
	$(Q)$(LD) $(LD_FLAGS) $(OBJECTS) -o $@

$(BUILD_DIR)/$(TARGET).lst: $(BUILD_DIR)/$(TARGET).elf | $(BUILD_DIR)
	$(Q)$(DUMP) -x -s -S $< > $@

$(BUILD_DIR)/$(TARGET).bin: $(BUILD_DIR)/$(TARGET).elf | $(BUILD_DIR)
	$(Q)$(COPY) -O binary $< $@

$(BUILD_DIR):
	@mkdir -p $@

size: $(BUILD_DIR)/$(TARGET).elf
	$(Q)$(SIZE) $<

#####################################

clean:
	@echo CLEAN
	@rm -fR $(BUILD_DIR)

rebuild: clean all

.PHONY: all clean list size rebuild
