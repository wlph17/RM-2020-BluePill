######################################
# source
######################################
# C sources
C_SOURCES =  \
Core/Src/main.c \
Core/Src/stm32f1xx_it.c \
Core/Src/stm32f1xx_hal_msp.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio_ex.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_tim.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_tim_ex.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc_ex.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_dma.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_cortex.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_pwr.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash_ex.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_exti.c \
Core/Src/system_stm32f1xx.c \
Core/Src/os.c \
Drivers/CMSIS/DSP/Source/FilteringFunctions/arm_fir_f32.c \
Drivers/CMSIS/DSP/Source/FilteringFunctions/arm_fir_init_f32.c \
Drivers/CMSIS/DSP/Source/MatrixFunctions/arm_mat_inverse_f32.c \
Drivers/CMSIS/DSP/Source/MatrixFunctions/arm_mat_mult_f32.c \
Drivers/CMSIS/DSP/Source/MatrixFunctions/arm_mat_trans_f32.c \
Drivers/CMSIS/DSP/Source/MatrixFunctions/arm_mat_add_f32.c \
Drivers/CMSIS/DSP/Source/StatisticsFunctions/arm_var_f32.c \
Core/Src/gpio.c \
Hook.c \
Core/Src/stm32f1xx_hal_timebase_tim.c


# Others
DEFS = \
-DTRUE=1 \
-DNULL=0


CPP_SRC = \
Core/Src/UserTasks.cpp \
WorkPlace/*.cpp 


# ASM sources
ASM_SOURCES =  \
startup_stm32f103xb.s

# macros for gcc
# AS defines
AS_DEFS = 

# C defines
C_DEFS =  \
-DUSE_HAL_DRIVER \
-DSTM32F103xB \
-DARM_MATH_CM3 \
-DUSE_APP_CONFIG 


# AS includes
AS_INCLUDES = 

# C includes
C_INCLUDES =  \
-ICore/Inc \
-IDrivers/STM32F1xx_HAL_Driver/Inc \
-IDrivers/STM32F1xx_HAL_Driver/Inc/Legacy \
-IDrivers/CMSIS/Device/ST/STM32F1xx/Include \
-IDrivers/CMSIS/Include \
-IDrivers/CMSIS/DSP/Include \
-IWorkPlace/

include core.mk
