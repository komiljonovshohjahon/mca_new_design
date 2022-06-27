import 'dart:async';
import 'dart:developer';
import 'dart:developer';

import 'package:mca_new_design/template/base/template.dart';

// class PeriodicTaskAdmin {
//   static int timesTokenDone = 0;
//   static int timesAvailableDone = 0;
//   static DateTime? breakTimer;
//
//   static NeatPeriodicTaskScheduler refreshTokenMCA = NeatPeriodicTaskScheduler(
//       interval: 8.minutes,
//       name: 'refreshTokenMCA',
//       timeout: 8.minutes,
//       minCycle: 3.minutes,
//       task: () async {
//         print('Refresh Token MCA => START');
//         if (timesTokenDone > 0) {
//           await appStore.dispatch(GetRenewAccessTokenAction());
//         }
//         timesTokenDone++;
//         print('Refresh Token MCA => END');
//       });
//
//   static NeatPeriodicTaskScheduler refreshAvailableAndCurrentStatusMCA =
//       NeatPeriodicTaskScheduler(
//     interval: 15.seconds,
//     name: 'refreshAvailableAndCurrentStatusMCA',
//     timeout: 15.seconds,
//     minCycle: 5.seconds,
//     task: () async {
//       print('Refresh Available And Current Status MCA => START');
//       if (timesAvailableDone > 0) {
//         await appStore.dispatch(GetCurrentStatusAction());
//         await appStore.dispatch(GetAvailableAction());
//       }
//       timesAvailableDone++;
//       print('Refresh Available And Current Status MCA => END');
//     },
//   );
//
//   static NeatPeriodicTaskScheduler refreshBreakTimerMCA =
//       NeatPeriodicTaskScheduler(
//     interval: 1.seconds,
//     name: 'refreshBreakTimerMCA',
//     timeout: 1.seconds,
//     minCycle: 400.milliseconds,
//     task: () async {
//       print('Refresh Break Timer MCA => START');
//       await Future.delayed(2.seconds);
//       print('Refresh Break Timer MCA => END');
//     },
//   );
// }
//
class TimerController extends GetxController {
  RxString timerText = "".obs;
  RxBool isTimerRunning = false.obs;

  startTimer(time) {
    timerText.value = time;
    isTimerRunning.value = true;
  }

  stopTimer() {
    timerText.value = "";
    isTimerRunning.value = false;
  }
}
