#*******************************  VARIABLES  **********************************#

NAME			=	hello_world

# ------------- MK INCLUDES ------------ #

-include src.mk
-include $(DEP)

# ------------ DIRECTORIES ------------ #

BUILD_DIR		=	.build
BIN_DIR			=	$(BUILD_DIR)/bin
INCLUDES_DIR 	=	$(INCLUDE) $(SDK_INCLUDE)

# ------------- SHORTCUTS ------------- #

SDK_SRC			=	$(SDK_SRC_C) $(SDK_SRC_S)
SDK_OBJ			=	$(patsubst %.c, $(BUILD_DIR)/%.o, $(SDK_SRC_C)) $(patsubst %.S, $(BUILD_DIR)/%.o, $(SDK_SRC_S))
SDK_DEP			=	$(patsubst %.c, $(BUILD_DIR)/%.d, $(SDK_SRC_C)) $(patsubst %.S, $(BUILD_DIR)/%.d, $(SDK_SRC_S))

SRC				=	$(SRC_C) $(SRC_S) $(SDK_SRC)
OBJ				=	$(patsubst %.c, $(BUILD_DIR)/%.o, $(SRC_C)) $(patsubst %.S, $(BUILD_DIR)/%.o, $(SRC_S)) $(SDK_OBJ)
DEP				=	$(patsubst %.c, $(BUILD_DIR)/%.d, $(SRC_C)) $(patsubst %.S, $(BUILD_DIR)/%.d, $(SRC_S)) $(SDK_DEP)
INCLUDES		=	$(addprefix -I , $(INCLUDES_DIR))

BIN_ELF			=	$(BIN_DIR)/$(NAME).elf
BIN 			=	$(BIN_DIR)/$(NAME).bin
BIN_HEX			=	$(BIN_DIR)/$(NAME).hex

# ------------ COMPILATION ------------ #

CC				=	arm-none-eabi-gcc
LD				=	arm-none-eabi-gcc
AS				=	arm-none-eabi-gcc
OBJCOPY			=	arm-none-eabi-objcopy
SIZE			=	arm-none-eabi-size

NEWLIB_DIR		=	/opt/arm-gnu-toolchain/arm-none-eabi/lib
MAP_DIR			=	$(BUILD_DIR)

SDK_CFLAGS		=  -mcpu=cortex-m4 -c -Os -g3 -mthumb -Wall -Wextra -fmessage-length=0 -ffunction-sections -fdata-sections \
                   -specs=nano.specs -specs=nosys.specs --sysroot=$(NEWLIB_DIR) \
				   -DCPU_S32K144HFT0VLLT -DDEV_ERROR_DETECT

CFLAGS			=  -Werror $(SDK_CFLAGS)

LINKER_FILE		=	$(SDK_DIR)/platform/devices/S32K144/linker/gcc/S32K144_64_flash.ld

LDFLAGS			=  -Wall -Wextra -T $(LINKER_FILE) -Wl,-Map,$(MAP_DIR)/$(NAME).map -Xlinker --gc-sections \
                   -n -mcpu=cortex-m4 -ffunction-sections -fdata-sections  -specs=nano.specs \
				   -specs=nosys.specs --sysroot=$(NEWLIB_DIR) \
				   -DSTART_FROM_FLASH

DEP_FLAGS		=	-MMD -MP

# -------------  COMMANDS ------------- #

RM				=	rm -rf
MKDIR			=	mkdir -p
OS				=	$(shell uname -s)

#***********************************  RULES  **********************************#

.PHONY: all
all:
				$(MAKE) $(BIN_ELF)
				$(OBJCOPY) -O binary $(BIN_ELF) $(BIN)
				$(OBJCOPY) -O ihex $(BIN_ELF) $(BIN_HEX)
				$(MAKE) size
				@echo "Build finished"
				@echo "See $(BIN_DIR) for output files"


# ---------- VARIABLES RULES ---------- #

$(BIN_ELF): $(OBJ) $(LINDKER_FILE)
				mkdir -p $(shell dirname $@)
				$(CC) $(LDFLAGS) $(INCLUDES) -o $(BIN_ELF) $(OBJ)

# ---------- COMPILED RULES ----------- #

$(BUILD_DIR)/$(SDK_DIR)/%.o: $(SDK_DIR)/%.c
				mkdir -p $(shell dirname $@)
				$(CC) $(SDK_CFLAGS) $(DEP_FLAGS) $(INCLUDES) -c $< -o $@

$(BUILD_DIR)/$(SDK_DIR)/%.o: $(SDK_DIR)/%.S
				mkdir -p $(shell dirname $@)
				$(CC) $(SDK_CFLAGS) $(DEP_FLAGS) $(INCLUDES) -c $< -o $@

$(BUILD_DIR)/%.o: %.c
				mkdir -p $(shell dirname $@)
				$(CC) $(CFLAGS) $(DEP_FLAGS) $(INCLUDES) -c $< -o $@

$(BUILD_DIR)/%.o: %.S
				mkdir -p $(shell dirname $@)
				$(CC) $(CFLAGS) $(DEP_FLAGS) $(INCLUDES) -c $< -o $@

.PHONY: size
size:
				$(SIZE) $(BIN_ELF)

.PHONY: clean
clean:
				$(RM) $(BUILD_DIR)

.PHONY: fclean
fclean: clean
				$(RM) $(BIN_ELF)

.PHONY: re
re:				fclean
				$(MAKE) all
