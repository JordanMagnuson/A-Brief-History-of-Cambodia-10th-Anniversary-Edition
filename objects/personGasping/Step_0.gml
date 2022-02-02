var ty = ((FLOAT_DURATION*room_speed) - alarm_get(0)) / (FLOAT_DURATION * room_speed);
y = quadInOut(ty, initY, GASP_FLOAT_DISTANCE, upDown);