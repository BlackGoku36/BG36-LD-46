package scripts;

import rice2d.Scene;
import haxe.Timer;
import kha.Scheduler;
import rice2d.system.Input;
import rice2d.Assets;
import kha.Color;
import kha.System;

enum CanvasState {
    Menu;
    Stage;
    None;
    Lose;
    Win;
    Dialogue;
}

class CanvasController extends rice2d.Script{
    var font:kha.Font;

    var kb = Input.getKeyboard();
    var mouse = Input.getMouse();
    public static var state:CanvasState = Menu;
    public static var alpha = 255;
    
    public function new() {
        super();

        notifyOnUpdate(function (){
            font = Assets.getAsset("pixelfont", Font);

            if(state != None && state != Stage){

                if(kb.started(Space) && (state == Dialogue || state == Win || state == Lose) ){
                    StageController.stage = 1;
                    StageController.virusDefeated = 0;
                    StageController.totalVirusDefeated = 0;
                    HeartController.health = 200.0;
                    alpha = 255;
                    state = Stage;
                }
                if(kb.started(Space) && state == Menu){
                    state = Dialogue;
                }
    
            }
        });

        notifyOnRender(function (canvas){
            var g = canvas.g2;
            var col = g.color;
            g.font = font;
            if(state == Menu){
                g.fontSize = 80;
                g.color = Color.fromBytes(50, 50, 50, 255);
                g.fillRect(0, 0, System.windowWidth(), System.windowHeight());
                g.color = Color.White;
                g.drawScaledImage(Assets.getAsset("virus1", Image), (System.windowWidth()/2)-(200/2), (System.windowHeight()/2)-(200/2)-200, 200, 200);
                g.drawString("Mr.Virus", (System.windowWidth()/2)-(g.font.width(g.fontSize, "Mr.Virus")/2), (System.windowHeight()/2)-(g.font.height(g.fontSize)/2));
                g.drawString("Press space to start", (System.windowWidth()/2)-(g.font.width(g.fontSize, "Press space to start")/2), (System.windowHeight()/2)-(g.font.height(g.fontSize)/2)+g.font.height(g.fontSize)+150);
            }
            else if(state == Stage){
                g.color = Color.fromBytes(50, 50, 50, alpha);
                g.fillRect(0, 0, System.windowWidth(), System.windowHeight());
                g.color = Color.fromBytes(255, 255, 255, alpha);
                g.fontSize = 100;
                g.drawString('Stage ${StageController.stage} begins!', (System.windowWidth()/2)-(g.font.width(g.fontSize, 'Stage ${StageController.stage} begins!')/2), (System.windowHeight()/2)-(g.font.height(g.fontSize)/2));
                if(alpha == 0) state = None;
                Scheduler.addTimeTask(function (){
                    alpha -= 5;
                }, 2.0, 2.0, 2.0);
            }else if(state == Win){
                g.color = Color.fromBytes(50, 50, 50, alpha);
                g.fillRect(0, 0, System.windowWidth(), System.windowHeight());
                g.color = Color.fromBytes(255, 255, 255, alpha);
                g.fontSize = 100;
                g.drawString('You defeated Mr.Virus!', (System.windowWidth()/2)-(g.font.width(g.fontSize, 'You defeated Mr.Virus!')/2), (System.windowHeight()/2)-(g.font.height(g.fontSize)/2));
                g.fontSize = 70;
                g.drawString('Press space to play again', (System.windowWidth()/2)-(g.font.width(g.fontSize, 'Press space to play again')/2), (System.windowHeight()/2)-(g.font.height(g.fontSize)/2)+150);
            }else if(state == Lose){
                g.color = Color.fromBytes(50, 50, 50, alpha);
                g.fillRect(0, 0, System.windowWidth(), System.windowHeight());
                g.color = Color.fromBytes(255, 255, 255, alpha);
                g.fontSize = 100;
                g.drawString('Mr.Virus defeated you!', (System.windowWidth()/2)-(g.font.width(g.fontSize, 'Mr.Virus defeated you!')/2), (System.windowHeight()/2)-(g.font.height(g.fontSize)/2)-150);
                g.fontSize = 70;
                g.drawString('Viruses defeated: ${StageController.totalVirusDefeated}', (System.windowWidth()/2)-(g.font.width(g.fontSize, 'Viruses defeated: ${StageController.virusDefeated}')/2), (System.windowHeight()/2)-(g.font.height(g.fontSize)/2));
                g.drawString('Press space to retry', (System.windowWidth()/2)-(g.font.width(g.fontSize, 'Press space to retry')/2), (System.windowHeight()/2)-(g.font.height(g.fontSize)/2)+150);
            }
            g.color = col;
        });

        // notifyOnRemove(function (){
        // });
    }
}