#ifndef VIGENERE_CRYPT_H
#define VIGENERE_CRYPT_H

#include <QObject>
#include <QString>

class VigenereCrypt : public QObject
{
    Q_OBJECT
public:
    explicit VigenereCrypt(QObject *parent = nullptr);

private:
    QString _alphabet = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюяABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,!?;:()\"'—–-";

signals:
    void cryptFinished(const QString& result);

public slots:
    void encrypt(const QString& text,
                 const QString& key);

    void decrypt(const QString& text,
                 const QString& key);

};

#endif // VIGENERE_CRYPT_H
