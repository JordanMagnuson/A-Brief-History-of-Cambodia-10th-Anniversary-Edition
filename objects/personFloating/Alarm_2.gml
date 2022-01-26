/// @description Breathe alarm
//switch breathe direction
bDir = -bDir;
show_debug_message(bDir)

alarm_set(2, bDuration * room_speed);
