// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function FadeTo(){
	
	
var _dur = argument[0];
var _color = argument[1];

var _inst = instance_create_depth(0,0,0,fade);

with(_inst)
{
	duration = _dur;
	color = _color;
}

}