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
                grid.children[i*Logic.board[i].length + j].color = Logic.board[i][j] === 0 ? "#ccc0b2" :  Logic.board[i][j] === 1 ?"black" : "red";
            }
    }
}

