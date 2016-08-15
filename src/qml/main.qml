import QtQuick 2.3
import QtQuick.Window 2.2

import "logic.js" as Logic

Window {
    visible: true
    width: 480;
    height: 360;
    color: "black";

    minimumHeight: height;
    minimumWidth: width;
    maximumHeight: height;
    maximumWidth: width;
    title: qsTr("Battle city");

    property var bulletArr: [];
    property int direrct: Logic.directionType.Up;

    Board {
        id: board;
    }

    Tank {
        id: player;
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }

    Component.onCompleted:
    {
        player.move(Qt.point(0,4));
    }

    Bullet {
        id: bullet;
    }

    Timer {
        id: gameLoop;
        repeat: true;
        interval: 300; running: true;
        onTriggered: {
            for(var i = 0; i < bulletArr.length; ++i)
            {
//                if(!bulletArr[i].isEnabled){
//                    bulletArr[i].destroy();
//                    bulletArr.splice(i, 1);
//                }
                bulletArr[i].update();
            }
            board.update();
        }
    }

    Rectangle {
        focus: true
        Keys.onPressed: {
            var pos = Qt.point(0,0);
            pos.x = player.pos.x;
            pos.y = player.pos.y;
            switch(event.key)
            {
            case Qt.Key_Left:
                pos.x -= 1;
                direrct = Logic.directionType.Left;
                console.log("left");
                break;
            case Qt.Key_Right:
                direrct = Logic.directionType.Right;
                pos.x += 1;
                console.log("right");
                break;
            case Qt.Key_Up:
                direrct = Logic.directionType.Up;
                pos.y -= 1;
                console.log("up");
                break;
            case Qt.Key_Down:
                direrct = Logic.directionType.Down;
                pos.y += 1;
                console.log("down");
                break;
            case Qt.Key_Space:
                var component = Qt.createComponent("Bullet.qml");
                var obj = component.createObject(parent);
                obj.pos = pos;
                obj.direction = direrct;
                bulletArr.push(obj);
                break;
            }
            player.move(pos);
            board.update();
            event.accepted = true;
        }
    }
}

