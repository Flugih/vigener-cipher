#include "vigenere_crypt.h"
#include <qdebug.h>

VigenereCrypt::VigenereCrypt(QObject *parent)
    : QObject{parent}
{}

void VigenereCrypt::baseCrypt(const QString &text, const QString &key, CryptAction action)
{
    QString result = "";

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
            int index = 0;

            if (action == VigenereCrypt::ENCRYPTION)
            {
                index = (textPos + keyPos) % length;
            }
            if (action == VigenereCrypt::DECRYPTION)
            {
                 index = (textPos - keyPos + length) % length;
            }

            result += _alphabet[index];
        }
    }

    emit cryptFinished(result);
}

void VigenereCrypt::encrypt(const QString &text, const QString &key)
{
    baseCrypt(text, key, VigenereCrypt::ENCRYPTION);
}

void VigenereCrypt::decrypt(const QString &text, const QString &key)
{
    baseCrypt(text, key, VigenereCrypt::DECRYPTION);
}
