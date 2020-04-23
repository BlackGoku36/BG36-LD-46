package scripts;

import rice2d.object.Object;
import rice2d.tools.Util;
import kha.Scheduler;
import kha.System;
import kha.Color;
import rice2d.Assets;
import rice2d.Scene;

class WorldController extends rice2d.Script{

	var font:kha.Font;

	public function new() {
		super();


		notifyOnAdd(function (){
			font = Assets.getAsset("OpenSans_Regular", Font);
		});

		notifyOnRender(function (canvas){
			var g = canvas.g2;
			var col = g.color;
			g.font = font;
			g.fontSize = 25;
			g.color = Color.fromBytes(50, 50, 50);
			g.fillRect(0, 0, System.windowWidth(), 80);
			g.color = Color.fromBytes(255, 90, 90);
			g.fillRect(20, 20, 200 / HeartController.totalHealth * HeartController.health, 30);
			g.color = Color.fromBytes(200, 200, 200);
			g.drawRect(20, 20, 200, 30, 2.0);
			g.color = Color.White;
			g.drawString('Health: ${Math.round(HeartController.health)}/${HeartController.totalHealth}', 20, 50);
			g.fontSize = 30;
			g.drawString('Stage: ${StageController.stage}', 250, 20);
			g.drawString('Virus defeated: ${StageController.totalVirusDefeated}', 350, 20);
			g.color = col;
		});

	}
}
