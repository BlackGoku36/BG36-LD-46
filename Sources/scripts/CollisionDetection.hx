package scripts;

import rice2d.object.Object;
import rice2d.data.ObjectData;

class CollisionDetection {
    public static function AABBCD(objA:Object, objB:Object):Bool {
        var a = objA.props;
        var b = objB.props;
        if(a.x < b.x + b.width && a.x + a.width > b.x && a.y < b.y + b.height && a.y + a.height > b.y){
           return true;
        }
        return false;
    }
}