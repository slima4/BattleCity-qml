import QtQuick 2.0

import "logic.js" as Logic

Rectangle {

    property point pos: Qt.point(10,0);
    property int size: 4;
    property bool isEnabled: false;
    property int direction: Logic.directionType.Right;

    function update()
    {
        if(!isEnabled)
            return;

        switch(direction)
        {
        case Logic.directionType.Left:
            move(-1, 0);
            break;
        case Logic.directionType.Right:
            move(1, 0);
            break;
        case Logic.directionType.Up:
            move(0, -1);
            break;
        case Logic.directionType.Down:
            move(0, 1);
            break;
        default:
            break;
        }
    }

    function clean()
    {
        for(var i = 0; i < size; ++i)
        {
            switch(direction)
            {
            case Logic.directionType.Left:
            case Logic.directionType.Right:
                Logic.board[pos.y+i][pos.x] = 0;
                break;
            case Logic.directionType.Up:
            case Logic.directionType.Down:
                Logic.board[pos.y][pos.x+i] = 0;
                break;
            }
        }
    }

    function stop()
    {
        clean();
//        pos = Qt.point(10,0);
        isEnabled = false;
    }

    function move(x, y)
    {
        var mX = pos.x + x;
        var mY = pos.y + y;
        if (mX < 0 || mY < 0 || mX >= Logic.board[0].length || mY >= Logic.board.length){
            stop();
            return;
        }

        clean();

        pos.x += x;
        pos.y += y;

        if (direction === Logic.directionType.Up || direction === Logic.directionType.Down){
            if( Logic.board[pos.y][pos.x] === 1 || Logic.board[pos.y][pos.x+2] === 1) // destroy block
            {
                stop();
                return;
            }
        }
        else if (direction === Logic.directionType.Left || direction === Logic.directionType.Right) {
            if( Logic.board[pos.y][pos.x] === 1 || Logic.board[pos.y+2][pos.x] === 1) // destroy block
            {
                stop();
                return;
            }
        }

        // move
        for(var i = 0; i < size; ++i)
        {
            switch(direction)
            {
            case Logic.directionType.Left:
            case Logic.directionType.Right:
                Logic.board[pos.y+i][pos.x] = 3;
                break;
            case Logic.directionType.Up:
            case Logic.directionType.Down:
                Logic.board[pos.y][pos.x+i] = 3;
                break;
            }
        }

    }
}

