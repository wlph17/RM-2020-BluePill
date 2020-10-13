/**
 * @file    os.c
 * @author	Alex Wong Tat Hang (thwongaz@connect.ust.hk)
 * @brief   freeRTOS init and required support code
 * @version 0.1
 * @date	2019-10-12
 *
 * @copyright Copyright (c) 2019
 */
#include "os.h"
#include "FreeRTOS.h"
#include "main.h"
#include "task.h"

/**
 * @brief       Provides implementation of vApplicationGetIdleTaskMemory for static freeRTOS operation
 * @note        non-API
 * @param[out]  ppxIdleTaskTCBBuffer    Pointer to pointer of idle task thread control block
 * @param[out]  ppxIdleTaskStackBuffer  Pointer to pointer of idle task stack
 * @param[out]  pulIdleTaskStackSize    Pointer to idle task stack size variable
 * @return      void
 */
void vApplicationGetIdleTaskMemory(StaticTask_t **ppxIdleTaskTCBBuffer, StackType_t **ppxIdleTaskStackBuffer, uint32_t *pulIdleTaskStackSize) {
    static StaticTask_t xIdleTaskTCB;
    static StackType_t  uxIdleTaskStack[configMINIMAL_STACK_SIZE];

    *ppxIdleTaskTCBBuffer   = &xIdleTaskTCB;
    *ppxIdleTaskStackBuffer = uxIdleTaskStack;
    *pulIdleTaskStackSize   = configMINIMAL_STACK_SIZE;
}

/**
 * @brief       Provides implementation of vApplicationGetTimerTaskMemory for static freeRTOS operation
 * @note        non-API
 * @param[out]  ppxTimerTaskTCBBuffer   Pointer to pointer of timer task thread control block
 * @param[out]  ppxTimerTaskStackBuffer Pointer to pointer of timer task stack
 * @param[out]  pulTimerTaskStackSize   Pointer to timer task stack size variable
 * @return      void
 */
void vApplicationGetTimerTaskMemory(StaticTask_t **ppxTimerTaskTCBBuffer, StackType_t **ppxTimerTaskStackBuffer, uint32_t *pulTimerTaskStackSize) {
    static StaticTask_t xTimerTaskTCB;
    static StackType_t  uxTimerTaskStack[configTIMER_TASK_STACK_DEPTH];

    *ppxTimerTaskTCBBuffer   = &xTimerTaskTCB;
    *ppxTimerTaskStackBuffer = uxTimerTaskStack;
    *pulTimerTaskStackSize   = configTIMER_TASK_STACK_DEPTH;
}


// forward declaration of function in UserTasks.cpp
void startUserTasks();
/**
 * @brief   Starts scheduler, can optionally create tasks here
 * @return  void
 */
void startRTOS(void) {
    startUserTasks();
    vTaskStartScheduler();
}
