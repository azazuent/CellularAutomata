#include "cellularautomata.h"

#include <QPainter>

cellularAutomata::cellularAutomata()
{
    sizex = 10;
    sizey = 10;
    rule = 594594;
    field = matrix(sizey, QVector<bool>(sizex, 0));
}

void cellularAutomata::paint(QPainter *painter)
{
    qreal oneCellHeight = size().height() / sizey;
    qreal oneCellWidth = size().width() / sizex;

    painter->setRenderHint(QPainter::Antialiasing);

    QBrush brush(QColor("black"));

    painter->setPen(QPen(brush, 0.7));

    for (int y = 0; y < sizey; y++)
    {
        for (int x = 0; x < sizex; x++)
        {
            if (field[y][x])
                brush.setColor("black");
            else
                brush.setColor("white");

            painter->setBrush(brush);
            painter->drawRect(QRectF(x*oneCellWidth, y*oneCellHeight, oneCellWidth, oneCellHeight));
        }
    }
}

void cellularAutomata::launch()
{
    field = calculate();
    update();
}

void cellularAutomata::handleMouseClick(double x, double y)
{
    field[(int)(y / (size().height() / sizey))][(int)(x / (size().width() / sizex))] ^= 1;
    update();
}

void cellularAutomata::resizeField(QString x, QString y)
{
    sizex = x.toInt();
    sizey = y.toInt();

    field = matrix(sizey, QVector<bool>(sizex, 0));

    update();
}

void cellularAutomata::clear()
{
    field = matrix(sizey, QVector<bool>(sizex, 0));

    update();
}

void cellularAutomata::randomFill()
{
    field = matrix(sizey, QVector<bool>(sizex, 0));

    for (int y = 0; y<sizey; y++)
        for (int x = 0; x<sizex; x++)
            field[y][x] = QRandomGenerator::global()->generate() % 2;

    update();
}

void cellularAutomata::editRule(QString newRule)
{
    rule = newRule.toInt();
}


matrix cellularAutomata::calculate()
{
    matrix newField(sizey,QVector<bool>(sizex, 0));

    for (int y = 0; y < sizey; y++)
        for (int x = 0; x < sizex; x++)
        {
            newField[y][x] = (rule >> calcNextCell(x, y)) & 1;
        }

    return newField;
}

int cellularAutomata::calcNextCell(int x, int y)
{
    int result = 0;

    int nextX = x;
    int nextY = y-1;

    if (nextY < 0)
        nextY += sizey;
    result |= field[nextY][nextX]<<4;

    nextX = x-1;
    nextY = y;
    if (nextX < 0)
        nextX += sizex;
    result|= field[nextY][nextX]<<3;

    result|= field[y][x]<<2;

    nextX = x+1;
    nextY = y;
    if (nextX > sizex - 1)
        nextX -= sizey;
    result |= field[nextY][nextX]<<1;

    nextX = x;
    nextY = y+1;
    if (nextY > sizey - 1)
        nextY -=  sizey;
    result |= field[nextY][nextX]<<0;

    return result;
}
