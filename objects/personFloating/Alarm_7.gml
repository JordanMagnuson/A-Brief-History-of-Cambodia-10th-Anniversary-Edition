/// @description floating Angle alarm

angleDur = FLOAT_DURATION + floatX / 50;

startAngle = image_angle;
angleChange = MIN_ANGLE_CHANGE + random(1) * (MAX_ANGLE_CHANGE - MIN_ANGLE_CHANGE);
angleDir = floatXDir;

alarm_set(6, angleDur * room_speed);
