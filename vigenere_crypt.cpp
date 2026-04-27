#include "vigenere_crypt.h"
#include <qdebug.h>

VigenereCrypt::VigenereCrypt(QObject *parent)
    : QObject{parent}
{}

void VigenereCrypt::encrypt(const QString &text, const QString &key)
{
    QString result = "";
    int length = _alphabet.length();

    for (int i = 0; i < text.length(); ++i)
    {
        int textPos = _alphabet.indexOf(text[i]);
        int keyPos = _alphabet.indexOf(key[i % key.length()]);

        if (textPos == -1 || keyPos == -1)
        {
            result += text[i];
        }
        else
        {
            int encryptedIdx = (textPos + keyPos) % length;
            result += _alphabet[encryptedIdx];
        }
    }

    emit cryptFinished(result);
}

void VigenereCrypt::decrypt(const QString &text, const QString &key)
{
    QString result = "";
    int length = _alphabet.length();

    for (int i = 0; i < text.length(); ++i)
    {
        int textPos = _alphabet.indexOf(text[i]);
        int keyPos = _alphabet.indexOf(key[i % key.length()]);

        if (textPos == -1 || keyPos == -1)
        {
            result += text[i];
        }
        else
        {
            int decryptedIdx = (textPos - keyPos + length) % length;
            result += _alphabet[decryptedIdx];
        }
    }

    emit cryptFinished(result);
}
