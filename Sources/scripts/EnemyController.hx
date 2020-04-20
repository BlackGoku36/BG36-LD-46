package scripts;

import kha.math.Random;
import rice2d.Label;
import kha.math.Vector2;
import rice2d.system.Tween;
import rice2d.Scene;
import rice2d.tools.Util;
import kha.System;
import kha.Color;

class EnemyController extends rice2d.Script{

	var a = Scene.getObject("player");
	var b = Scene.getObject("heart");

	
	var jumpscareTargetX = 0.0;
	var jumpscareTargetY = 0.0;
	
	public function new() {
		super();

		notifyOnInit(function (){

			if(Label.hasLabel(object.props, "js")){
				jumpscareTargetX = Util.randomRangeF(0, System.windowWidth());
				jumpscareTargetY = Util.randomRangeF(0, System.windowHeight());
			}
		});

		notifyOnUpdate(function (){

			if(Label.hasLabel(object.props, "norm")){

				var speed = 0.02;
				if(StageController.stage == 1) speed = 0.02;
				else if(StageController.stage == 2) speed = 0.03;
				else if(StageController.stage == 3) speed = 0.035;
				else if(StageController.stage == 4) speed = 0.04;

				var dirx = System.windowWidth()/2 - object.props.x;
				var diry = System.windowHeight()/2 - object.props.y;
	
				object.props.rotation = Math.atan2(diry, dirx);
				object.props.x += dirx * speed;
				object.props.y += diry * speed;

			}else if(Label.hasLabel(object.props, "js")){
				var speed = 0.03;
				if(StageController.stage == 2) speed = 0.03;
				if(StageController.stage == 3) speed = 0.035;
				if(StageController.stage == 4) speed = 0.04;

				var dirx = jumpscareTargetX - object.props.x;
				var diry = jumpscareTargetY - object.props.y;
	
				object.props.rotation = Math.atan2(diry, dirx);
				object.props.x += dirx * speed;
				object.props.y += diry * speed;

				var jumpEarlier = 200;
				if(StageController.stage == 3) jumpEarlier = 250;
				if(StageController.stage == 4) jumpEarlier = 300;

				if(Math.round(distance(object.props.x, object.props.y, jumpscareTargetX, jumpscareTargetY)) <= jumpEarlier){
					jumpscareTargetX = Util.randomRangeF(0, System.windowWidth());
					jumpscareTargetY = Util.randomRangeF(0, System.windowHeight());
				}
			}

			if(CollisionDetection.AABBCD(b, object)){
				HeartController.gettingDamage = true;
				if(Label.hasLabel(object.props, "js"))
					HeartController.health -= HeartController.health <= 0 ? 0.0 : 1.0;
				else
					HeartController.health -= HeartController.health <= 0 ? 0.0 : 0.5;
			}

			if(CollisionDetection.AABBCD(a, object)){
				StageController.virusDefeated += 1;
				StageController.totalVirusDefeated += 1;
				object.remove();
			}
		});

	}

	static function distance(x:Float, y:Float, x1:Float, y1:Float) {
		return Math.sqrt(Math.pow(x1-x, 2)+Math.pow(y1-y, 2));
	}
}
