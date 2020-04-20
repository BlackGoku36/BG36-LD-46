package scripts;

import rice2d.Scene;
import rice2d.system.Input;
import kha.Color;

class PlayerController extends rice2d.Script{

	var mouse = Input.getMouse();
	var speed = 2;

	public function new() {
		super();

		notifyOnUpdate(function (){
			if(CanvasController.state == None){
				var center = object.transform.getCenter();
				var dirx = mouse.x - center.x;
				var diry = mouse.y - center.y;

				object.props.rotation = Math.atan2(diry, dirx);
				object.props.x += dirx * 0.09;
				object.props.y += diry * 0.09;
			}

		});

	}
}
