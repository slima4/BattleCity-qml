import QtQuick 2.0

import "logic.js" as Logic

Rectangle {
    property int id: 4;
    property point pos: Qt.point(0,0);
    property int size: 4;
    property bool isEnabled: true;
    property int direction: Logic.directionType.Down;

    Component.onDestruction: console.log("Destruction")

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
                if(pos.x < Logic.board[0].length && pos.x >= 0)
                    Logic.board[pos.y+i][pos.x] = 0;
                break;
            case Logic.directionType.Up:
            case Logic.directionType.Down:
                console.log(pos.y + ":" + (pos.x + i));
                if(pos.y < Logic.board.length && pos.y >= 0)
                    Logic.board[pos.y][pos.x+i] = 0;
                break;
            }
        }
    }

    function destroyTank()
    {
        for(var i = 0; i < Logic.enemyList.length; ++i)
        {
            if( Logic.enemyList[i].hitTheTarget(pos, direction) )
            {
                Logic.enemyList[i].clean();
                Logic.enemyList[i].destroy();
                Logic.enemyList.splice(i, 1);
                stop();
                break;
            }
        }
    }

    function stop()
    {
        clean();
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
            if( Logic.board[pos.y][pos.x] === 1 || Logic.board[pos.y][pos.x+3] === 1) // destroy block
            {
                stop();
                return;
            }
            else if( Logic.board[pos.y][pos.x] === 2 || Logic.board[pos.y][pos.x+3] === 2) // destroy tank
            {
                destroyTank();
                return;
            }
        }
        else if (direction === Logic.directionType.Left || direction === Logic.directionType.Right) {
            if( Logic.board[pos.y][pos.x] === 1 || Logic.board[pos.y+3][pos.x] === 1) // destroy block
            {
                stop();
                return;
            }
            else if( Logic.board[pos.y][pos.x] === 2 || Logic.board[pos.y+3][pos.x] === 2) // destroy tank
            {
                destroyTank();
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
                Logic.board[pos.y+i][pos.x] = id;
                break;
            case Logic.directionType.Up:
            case Logic.directionType.Down:
                Logic.board[pos.y][pos.x+i] = id;
                break;
            }
        }

    }
}

