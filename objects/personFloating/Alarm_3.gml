/// @description Floating Y alarm
floatYDir = -floatYDir;
floatYcalc();
alarm_set(3, FLOAT_DURATION * room_speed);
