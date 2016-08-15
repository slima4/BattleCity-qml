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

    Rectangle{
        focus: true
        Keys.onPressed: {
            var pos = Qt.point(0,0);
            pos.x = player.pos.x;
            pos.y = player.pos.y;
            switch(event.key)
            {
            case Qt.Key_Left:
                pos.x -= 1;
                console.log("left");
                break;
            case Qt.Key_Right:
                pos.x += 1;
                console.log("right");
                break;
            case Qt.Key_Up:
                pos.y -= 1;
                console.log("up");
                break;
            case Qt.Key_Down:
                pos.y += 1;
                console.log("down");
            }
            player.move(pos);
            board.update();
            event.accepted = true;
        }
    }
}

