fadeDuration = room_speed * 3;
image_speed = 0;

//select a wave
image_index = choose(0, 1, 2);
image_alpha = 0;

//Set fade in alarm
dir = 1;
alarm_set(0, fadeDuration);