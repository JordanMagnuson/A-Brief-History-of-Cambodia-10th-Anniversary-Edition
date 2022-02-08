/// @description floating Angle alarm
startAngle = image_angle;
angleChange = -2 * angleChange;

alarm_set(7, angleDur * room_speed);
