#include<stdio.h>

int main(void) {
    int arr[10];

    for(int i = 1; i <= 20; i++){
      if((i % 2) == 0) arr[(i / 2 - 1)] = i;
    }

    for(int n = 0;n < 10; n++)
      printf("%d ",arr[n]);

    printf("\n");

}
