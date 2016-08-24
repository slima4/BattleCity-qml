import QtQuick 2.0

import "logic.js" as Logic

Rectangle {
    property int id: 3;
    color: "green";

    Tank {
        id: tank;
    }

    function setId(id)
    {
        tank.id = id;
    }

    function position(pos)
    {
        tank.pos = pos;
        tank.move(Logic.directionType.None);
    }

    function update()
    {
        tank.update();
    }


    function hitTheTarget(bullet, dir)
    {
        switch(dir)
        {
        case Logic.directionType.Up:
        case Logic.directionType.Down:
            if(bullet.x + 3 >= tank.pos.x && bullet.x <= tank.pos.x + 3 && bullet.y >= tank.pos.y && bullet.y <= tank.pos.y + 3){
                return true;
            }
            break;
        case Logic.directionType.Left:
        case Logic.directionType.Right:
            if(bullet.x >= tank.pos.x && bullet.x <= tank.pos.x + 3 && bullet.y + 3 >= tank.pos.y && bullet.y <= tank.pos.y + 3){
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
        tank.clean();
    }

    Timer {
        id: tankMove;
        repeat: true;
        interval: 500; running: true;
        onTriggered: {
            rndMove();
            rndShoot();
        }
    }

    property int repitCount: 0;
    function rndMove()
    {
        if(repitCount === 0)
        {
            repitCount = Math.floor(Math.random() * (6-1)) + 1;
            tank.direction = Math.floor(Math.random() * 5);
        }
        --repitCount;
        tank.move(tank.direction);
    }

    function rndShoot()
    {
        if(Math.floor(Math.random() * 3) === 1)
            tank.shoot();
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
