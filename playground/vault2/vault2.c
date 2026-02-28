#include <stdio.h>
#include <string.h>

int main() {
    char input[64];
    printf("Gib das Passwort ein: ");
    scanf("%63s", input);

    // Ein extrem simpler "Cipher"
    // Das Passwort ist "s3cur3", aber wir prüfen es Zeichen für Zeichen
    if (input[0] == 's' && input[1] == '3' && input[2] == 'c' && 
        input[3] == 'u' && input[4] == 'r' && input[5] == '3') {
        printf("Zugriff gewährt! Heilige Scheiße, du bist drin.\n");
    } else {
        printf("Falsch. Versuch's nochmal, Rookie.\n");
    }
    return 0;
}
