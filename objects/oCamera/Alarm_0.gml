/// @description Resize screen
// For some reason some mobile devices show a black screen on game start.
// To counter this, we immediately fullscreen the canvas, which 
// seems to fix the issue.
last_browser_width = browser_width;
last_browser_height = browser_height;	
canvas_fullscreen(browser_width, browser_height);