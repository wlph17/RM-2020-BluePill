#pragma once
#ifdef USE_APP_CONFIG
#include "appConfig.h"
#endif
#ifndef USE_MG996R
#define USE_MG996R TRUE
#endif
#if USE_MG996R
#include "FreeRTOS.h"
namespace Drivers
{
namespace MG996R
{
class MG996R
{
   public:
    MG996R() {}
    void init();
    void setTargetAngle(uint8_t);

   private:
};
}  // namespace MG996R
}  // namespace Drivers
#endif