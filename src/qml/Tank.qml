import QtQuick 2.0

import "logic.js" as Logic;

Rectangle {
    property point pos: Qt.point(4,0);
    property size size: Qt.size(4,4);
    property int id: 2;
    color: "red";

    function move( m )
    {
        if ( (m.x + size.width) > Logic.board[0].length || (m.y + size.height) > Logic.board.length)
            return;
        console.log(m.x + size.width + ":" + (m.y + size.height));
        console.log(Logic.board[0].length + "x" + Logic.board.length);
        var widht = pos.x + size.width;
        var height = pos.y + size.height;
        for (var i = pos.x; i < widht; ++i) {
            for (var j = pos.y; j < height; ++j) {
                Logic.board[i][j] = 0;
            }
        }

        pos = m;
        //set tank
        for (var i = pos.x; i < pos.x + size.width; ++i) {
            for (var j = pos.y; j < pos.y + size.height; ++j) {
                Logic.board[i][j] = id;
            }
        }
    }
}

