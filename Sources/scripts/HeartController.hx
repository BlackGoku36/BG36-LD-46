package scripts;

import rice2d.Scene;
import kha.Color;
import kha.System;

class HeartController extends rice2d.Script{

	public static var health = 200.0;

	public static var totalHealth = 200.0;

	public static var gettingDamage = false;

	public var width = 0.0;
	public var height = 0.0;

	public function new() {
		super();

		notifyOnAdd(function (){
			object.props.x = System.windowWidth()/2 - object.props.width/2;
			object.props.y = System.windowHeight()/2 - object.props.height/2;
			width = object.props.width;
			height = object.props.height;
		});

		notifyOnUpdate(function (){
			object.props.x = System.windowWidth()/2 - object.props.width/2;
			object.props.y = System.windowHeight()/2 - object.props.height/2;

			if(health <= 0){
				CanvasController.state = Lose;
				CanvasController.alpha = 255;
				for(i in Scene.objects) if(i.name == "enemy") i.remove();
			}
		});

		notifyOnRender(function (canvas){
			if(gettingDamage && Math.random() > 0.5){
				object.props.width += 2;
				object.props.height += 2;
			}else{
				object.props.width = width;
				object.props.height = height;
			}
			gettingDamage = false;
		});

	}
}
