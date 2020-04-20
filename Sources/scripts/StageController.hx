package scripts;

import rice2d.system.Input;
import rice2d.data.ObjectData;
import rice2d.object.Object;
import kha.System;
import rice2d.tools.Util;
import rice2d.Scene;
import kha.Scheduler;

class StageController extends rice2d.Script{

    public static var enemies:Array<Object> = [];

    public static var stage = 1;
    public static var virusDefeated = 0;

    static var timetask:Int;
    static var spawnRate = 3.0;
    var kb = Input.getKeyboard();

    public function new() {
        super();

        notifyOnInit(function (){
            timetask = Scheduler.addTimeTask(createVirus, 1.0, 0.8);
        });

        notifyOnUpdate(function (){
            if(virusDefeated == 20 && stage == 1){
                stage = 2;
                CanvasController.state = Stage;
                CanvasController.alpha = 255;
                virusDefeated = 0;
                for(i in Scene.objects) if(i.name == "enemy") i.remove();
            }
            if(virusDefeated == 25 && stage == 2){
                stage = 3;
                CanvasController.state = Stage;
                CanvasController.alpha = 255;
                virusDefeated = 0;
                for(i in Scene.objects) if(i.name == "enemy") i.remove();
                changeSpawnRate(0.75);
            }
            if(virusDefeated == 30 && stage == 3){
                stage = 4;
                CanvasController.state = Stage;
                CanvasController.alpha = 255;
                virusDefeated = 0;
                for(i in Scene.objects) if(i.name == "enemy") i.remove();
                changeSpawnRate(0.7);
            }
            if(virusDefeated == 35 && stage == 4){
                CanvasController.state = Win;
                CanvasController.alpha = 255;
            }
        });

    }

    function changeSpawnRate(rate:Float) {
        Scheduler.removeTimeTask(timetask);
        timetask = Scheduler.addTimeTask(createVirus, 1.0, rate);
    }

    function createVirus() {
        var rand = Math.random();
        if(CanvasController.state == None) Scene.addObject({
            name: "enemy",
            x: 0, y: 0,
            height: 40, width: 40,
            animate: false,
            spriteRef: getSprite(rand),
            scripts: [{
                name: "EnemyController",
                scriptRef: "EnemyController"
            }],
            labels: [getLabel(rand)]
        }, function (obj){
            initVirusPosition(obj);
            enemies.push(obj);
        });
    }

    function getSprite(?random:Float) {
        var sprite = "";
        if(stage == 1) sprite = "virus1";
        if(stage == 2) sprite = random < 0.2 ? "virus2" : "virus1";
        if(stage == 3) sprite = random < 0.3 ? "virus2" : "virus1";
        if(stage == 4) sprite = "virus1";
        return sprite;
    }

    function getLabel(?random:Float) {
        var label = "";
        if(stage == 1) label = "norm";
        if(stage == 2) label = random < 0.2 ? "js" : "norm";
        if(stage == 3) label = random < 0.3 ? "js" : "norm";
        if(stage == 4) label = random < 0.4 ? "js" : "norm";
        return label;
    }

    function initVirusPosition(obj:Object) {
        var rand = Math.random();
        if(rand >= 0.0 && rand < 0.25){
            obj.props.x = Util.randomRangeF(0, System.windowWidth());
            obj.props.y = 0;
        }else if(rand > 0.25 && rand < 0.5){
            obj.props.x = 0;
            obj.props.y = Util.randomRangeF(0, System.windowHeight());
        }else if (rand > 0.5 && rand < 0.75){
            obj.props.x = Util.randomRangeF(0, System.windowWidth());
            obj.props.y = System.windowHeight();
        }else{
            obj.props.x = System.windowWidth();
            obj.props.y = Util.randomRangeF(0, System.windowHeight());
        }
    }
}
