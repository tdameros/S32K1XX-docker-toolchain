SRC_C	=	\
			src/main.c				\
			board/clock_config.c	\
			board/pin_mux.c
SRC_S	=

INCLUDE =	\
			src	\
			board

SDK_DIR	=	/sdk

SDK_INCLUDE_LIST = \
			platform/devices/					\
			platform/devices/common				\
			platform/devices/S32K144			\
			platform/devices/S32K144/include	\
			platform/devices/S32K144/startup	\
			platform/drivers/inc				\
			platform/drivers/src/clock/S32K1xx

SDK_INCLUDE = $(addprefix $(SDK_DIR)/, $(SDK_INCLUDE_LIST))


SDK_SRC_C_LIST = \
			platform/devices/startup.c							\
			platform/devices/S32K144/startup/system_S32K144.c	\
			platform/drivers/src/clock/S32K1xx/clock_S32K1xx.c	\
			platform/drivers/src/interrupt/interrupt_manager.c	\
			platform/drivers/src/pins/pins_driver.c				\
			platform/drivers/src/pins/pins_port_hw_access.c

SDK_SRC_C = $(addprefix $(SDK_DIR)/, $(SDK_SRC_C_LIST))

SDK_SRC_S_LIST = \
			platform/devices/S32K144/startup/gcc/startup_S32K144.S

SDK_SRC_S =	$(addprefix $(SDK_DIR)/, $(SDK_SRC_S_LIST))
