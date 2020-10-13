/**
 * @file UserTasks.cpp
 * @author Will (phliuab@connect.ust.hk)
 * @brief File storing all user tasks
 * @version 0.1
 * @date 2020-09-08
 *
 * @copyright Copyright (c) 2020
 *
 */

#include "FreeRTOS.h"
#include "main.h"
#include "task.h"
StaticTask_t xBlinkTaskTCB;
StackType_t uxBlinkTaskStack[64];
void blinky(void *param)
{
    while (true)
    {
        HAL_GPIO_TogglePin(LED_GPIO_Port, LED_Pin);
        vTaskDelay(200);
    }
}

extern "C"
{
    void startUserTasks()
    {
        xTaskCreateStatic(
            blinky, "blink", 64, NULL, 0, uxBlinkTaskStack, &xBlinkTaskTCB);
    }
}