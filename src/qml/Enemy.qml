import QtQuick 2.0

import "logic.js" as Logic

Rectangle {
    property int id: 3;
    color: "green";

    Tank {
        id: enemy;
    }

    function position(pos)
    {
        enemy.pos = pos;
        enemy.move(Logic.directionType.None);
    }

    function update()
    {
        enemy.update();
    }


    function hitTheTarget(bullet, dir)
    {
        console.log(bullet.x + ":" + (enemy.pos.x + 3));

        switch(dir)
        {
        case Logic.directionType.Up:
        case Logic.directionType.Down:
            if(bullet.x + 3 >= enemy.pos.x && bullet.x <= enemy.pos.x + 3 && bullet.y >= enemy.pos.y && bullet.y <= enemy.pos.y + 3){
                return true;
            }
            break;
        case Logic.directionType.Left:
        case Logic.directionType.Right:
            if(bullet.x >= enemy.pos.x && bullet.x <= enemy.pos.x + 3 && bullet.y + 3 >= enemy.pos.y && bullet.y <= enemy.pos.y + 3){
                return true;
            }
            break;
        default:
            break;
        }

        return false;
    }

    function clean()
    {
        enemy.clean();
    }

    Component.onCompleted:
    {
        console.log("onCompleted - " + id);
    }

    Component.onDestruction:
    {
        console.log("onDestroyed - " + id);
    }
}
