import QtQuick 2.0

import "logic.js" as Logic

Rectangle {
    property int col: Logic.board[0].length;
    property int row: Logic.board.length;

    anchors {
        right: parent.right; rightMargin: 1
        left: parent.left; leftMargin: 1
        bottom: parent.bottom; bottomMargin: 1
        top: parent.top; topMargin: 1
    }
    color: "#bbada0"

    Grid {
        id: grid
        anchors.fill: parent;
        columns: col;
        rows: row;
        Repeater {
            model: grid.columns * grid.rows;

            Rectangle {
                width: grid.width / grid.columns;
                height: grid.height / grid.rows;
                radius: 5;
            }
        }
    }

    Component.onCompleted:
    {
        update();
    }

    function update()
    {
        for (var i = 0; i < Logic.board.length; ++i)
            for (var j = 0; j < Logic.board[i].length; ++j)
            {
                var code = Logic.board[i][j];
                var color = "white";
                switch(code)
                {
                case 0:
                    color = "#ccc0b2";
                    break;
                case 1:
                    color = "black";
                    break;
                case 2:
                    color = "green";
                    break;
                case 3:
                    color = "red";
                    break;
                case 4:
                    color = "blue"
                    break;
                default:
                    break;
                }
                grid.children[i*Logic.board[i].length + j].color = color;
            }
    }
}

