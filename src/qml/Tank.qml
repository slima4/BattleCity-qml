import QtQuick 2.0

import "logic.js" as Logic;

Rectangle {
    property point pos: Qt.point(0,0);
    property size size: Qt.size(4,4);
    property int direction: Logic.directionType.Up;
    property int id: 2;
    property var bulletArr: [];
    color: "red";

    function shoot()
    {
        var component = Qt.createComponent("Bullet.qml");
        var obj = component.createObject(parent);
        obj.pos = pos;
        obj.direction = direction;
        bulletArr.push(obj);
        switch(direction)
        {
        case Logic.directionType.Left:
            obj.pos.x -= 1;
            break;
        case Logic.directionType.Right:
           obj.pos.x += size.width;
            break;
        case Logic.directionType.Up:
            obj.pos.y -= 1;
            break;
        case Logic.directionType.Down:
            obj.pos.y += size.height;
            break;
        }
    }

    function update()
    {
        for(var i = 0; i < bulletArr.length; ++i)
        {
            if(!bulletArr[i].isEnabled){
                bulletArr[i].destroy();
                bulletArr.splice(i, 1);
                continue;
            }
            bulletArr[i].update();
        }
    }

    function move( direct )
    {
        direction = direct;
        var m = Qt.point(0,0);
        m.x = pos.x;
        m.y = pos.y;

        switch(direction)
        {
        case Logic.directionType.Left:
            m.x -= 1;
            break;
        case Logic.directionType.Right:
            m.x += 1;
            break;
        case Logic.directionType.Up:
            m.y -= 1;
            break;
        case Logic.directionType.Down:
            m.y += 1;
            break;
        }

        if ( m.x < 0 || m.y < 0 || (m.x  + size.width) > Logic.board[0].length || (m.y + size.height) > Logic.board.length)
            return;

        var i = 0;
        var j = 0;
        var widht = m.x + size.width;
        var height = m.y + size.height;
        // check block
        for (i = m.y; i < height; ++i) {
            for (j = m.x; j < widht; ++j) {
                if (Logic.board[i][j] === 1)
                    return;
            }
        }

        widht = pos.x + size.width;
        height = pos.y + size.height;
        // clean old tank position
        for (i = pos.y; i < height; ++i) {
            for (j = pos.x; j < widht; ++j) {
                Logic.board[i][j] = 0;
            }
        }


        pos = m;
        widht = pos.x + size.width;
        height = pos.y + size.height;
        //set tank
        for (i = pos.y; i < height; ++i) {
            for (j = pos.x; j < widht; ++j) {
                Logic.board[i][j] = id;
            }
        }
    }
}

