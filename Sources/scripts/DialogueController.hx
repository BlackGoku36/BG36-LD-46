package scripts;

import kha.Color;
import kha.Font;
import rice2d.Assets;
import kha.Image;
import kha.System;

class DialogueController extends rice2d.Script{

    var mask:Image;
    var veins:Image;
    var font:Font;

    public function new() {
        super();

        notifyOnAdd(function (){
            mask = Assets.getAsset("mask", Image);
            veins = Assets.getAsset("veins", Image);
            font = Assets.getAsset("pix_pixelfjverdana12pt_regular", Font);
        });

        // notifyOnUpdate(function (){
        // });

        notifyOnRender(function (canvas){
            var g = canvas.g2;
            var col = g.color;
            if(CanvasController.state == Dialogue){
                g.color = Color.fromBytes(70, 70, 70);
                g.fillRect(0, System.windowHeight()-300, System.windowWidth(), 300);
                g.color = col;
                // g.drawScaledImage(veins, 0, 0, System.windowWidth(), System.windowHeight()-300);
                g.drawScaledImage(mask, 50, System.windowHeight()-250, 300, 200);
                g.font = font;
                g.fontSize = 45;
                g.drawString("Oh no! Mr.Virus and his minions are co *cough* ming in!", 400, System.windowHeight()-230);
                g.drawString("Drag me *cough* around to defeat them!", 400, System.windowHeight()-170);
                g.drawString("Make sure to not let them get to *cough* heart!", 400, System.windowHeight()-110);
                g.fontSize = 35;
                g.drawString("(Press space to continue)", 600, System.windowHeight()-50);
            }
            g.color = col;
        });

        // notifyOnRemove(function (){
        // });
    }
}