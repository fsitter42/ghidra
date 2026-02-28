#include <stdio.h>
#include <string.h>

int main() {
    char input[64];
    printf("Enter Vault Key: ");
    scanf("%s", input);

    if (strcmp(input, "GhidraIsMagic2026") == 0) {
        printf("Access Granted!\n");
    } else {
        printf("Keep dreaming.\n");
    }
    return 0;
}
