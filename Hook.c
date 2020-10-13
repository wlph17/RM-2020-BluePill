/**
 * @file Hook.c
 * @author John Lam, RM2020 (john.lck40@gmail.com)
 * @brief Error hook
 * @version 0.1
 * @date 2019-11-20
 *
 * @copyright Copyright (c) 2019
 *
 */

#include "FreeRTOS.h"
#include "stm32f103xb.h"
#include "task.h"

__WEAK void vApplicationStackOverflowHook(TaskHandle_t xTask,
                                          signed char *pcTaskName)
{
    __BKPT(0);
}

__WEAK void __cxa_pure_virtual(void) { __BKPT(0); }

__WEAK void assertFailed(void) { __BKPT(0); }
