#ifndef CELLULARAUTOMATA_H
#define CELLULARAUTOMATA_H

#include <QObject>
#include <QVector>
#include <QtQml>
#include <QQuickPaintedItem>

typedef QVector<QVector<bool>> matrix;

class cellularAutomata : public QQuickPaintedItem
{
    Q_OBJECT
public:
    cellularAutomata();

    void paint(QPainter* painter) override;


public slots:
    void launch();

    void handleMouseClick(double x, double y);
    void resizeField(QString x, QString y);

    void clear();
    void randomFill();

    void editRule(QString newRule);

private:
    matrix field;

    int sizex;
    int sizey;

    int rule;

    matrix calculate();
    int calcNextCell(int x, int y);
};

#endif // CELLULARAUTOMATA_H
