import QtQuick 2.3
import QtQuick.Window 2.2

import "logic.js" as Logic

Window {
    id: window;
    visible: true
    width: 480;
    height: 360;
    color: "black";

    minimumHeight: height;
    minimumWidth: width;
    maximumHeight: height;
    maximumWidth: width;
    title: qsTr("Battle city");

    property int direct: Logic.directionType.Up;

    Board {
        id: board;
    }

    Player {
        id: player;
    }

    Component.onCompleted:
    {
        Logic.createEnemy(Qt.point(8,8), window);
        Logic.createEnemy(Qt.point(0,5), window);
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }

    Timer {
        id: gameLoop;
        repeat: true;
        interval: 300; running: true;
        onTriggered: {
            for(var i = 0; i < Logic.enemyList.length; ++i)
            {
                Logic.enemyList[i].update();
            }
            board.update();
            player.update();
        }
    }

    Rectangle {
        focus: true
        Keys.onPressed: {
            switch(event.key)
            {
            case Qt.Key_Left:
            case Qt.Key_Right:
            case Qt.Key_Up:
            case Qt.Key_Down:
            case Qt.Key_Space:
                player.move(event.key);
                break;
            }
            board.update();
            event.accepted = true;
        }
    }
}

