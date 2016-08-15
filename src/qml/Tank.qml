import QtQuick 2.0

import "logic.js" as Logic;

Rectangle {
    property point pos: Qt.point(0,0);
    property size size: Qt.size(4,4);
    property int id: 2;
    color: "red";

    function move( m )
    {
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
//        console.log("old: " + widht + ":" + height);
        // clean old tank position
        for (i = pos.y; i < height; ++i) {
            for (j = pos.x; j < widht; ++j) {
                Logic.board[i][j] = 0;
            }
        }

        pos = m;
        widht = pos.x + size.width;
        height = pos.y + size.height;
//        console.log("new: " + widht + ":" + height);
        //set tank
        for (i = pos.y; i < height; ++i) {
            for (j = pos.x; j < widht; ++j) {
                Logic.board[i][j] = id;
            }
        }
    }
}

