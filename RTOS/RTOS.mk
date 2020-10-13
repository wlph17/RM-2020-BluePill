#####################################
# Add FreeRTOS sources
#####################################
FREERTOS_C_SOURCES = \
$(RTOS_PATH)/FreeRTOS/croutine.c \
$(RTOS_PATH)/FreeRTOS/event_groups.c \
$(RTOS_PATH)/FreeRTOS/list.c \
$(RTOS_PATH)/FreeRTOS/queue.c \
$(RTOS_PATH)/FreeRTOS/stream_buffer.c \
$(RTOS_PATH)/FreeRTOS/tasks.c \
$(RTOS_PATH)/FreeRTOS/timers.c \
$(RTOS_PATH)/FreeRTOS/portable/GCC/ARM_CM3/port.c  

#####################################
# Include FreeRTOS headers
#####################################
FREERTOS_C_INCLUDES = \
-I$(RTOS_PATH)/FreeRTOS/include \
-I$(RTOS_PATH)/FreeRTOS/portable/GCC/ARM_CM3 \
-I$(RTOS_PATH)/systemView

#####################################
# Compile FreeRTOS sources
#####################################
C_SRC += $(FREERTOS_C_SOURCES)
INC += $(FREERTOS_C_INCLUDES)

#####################################
# Add systemView sources
#####################################
SYSVIEW_C_SOURCES = \
$(RTOS_PATH)/systemView/Config/SEGGER_SYSVIEW_Config_FreeRTOS.c \
$(RTOS_PATH)/systemView/OS/SEGGER_SYSVIEW_FreeRTOS.c \
$(RTOS_PATH)/systemView/SEGGER/SEGGER_RTT.c \
$(RTOS_PATH)/systemView/SEGGER/SEGGER_SYSVIEW.c

SYSVIEW_ASM_SOURCES = \
$(RTOS_PATH)/systemView/SEGGER/SEGGER_RTT_ASM_ARMv7M.s

#####################################
# Include systemView headers
#####################################
SYSVIEW_C_INCLUDES = \
-I$(RTOS_PATH)/systemView/Config \
-I$(RTOS_PATH)/systemView/OS \
-I$(RTOS_PATH)/systemView/SEGGER

SYSVIEW_ASM_INCLUDES = \
-I$(RTOS_PATH)/systemView/Config

#####################################
# Compile systemView sources
#####################################
C_SRC += $(SYSVIEW_C_SOURCES)
INC += $(SYSVIEW_C_INCLUDES)
AS_SRC += $(SYSVIEW_ASM_SOURCES)
AS_INC += $(SYSVIEW_ASM_INCLUDES)
