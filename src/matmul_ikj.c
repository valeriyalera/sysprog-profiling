#include <stdio.h>
#include <stdlib.h>
#ifndef N
#define N 1000
#endif

__attribute__((noinline))
void init(double *a, double *b) {
    for (int i = 0; i < N*N; i++) { a[i] = i % 7; b[i] = i % 5; }
}

__attribute__((noinline))
void multiply(double *a, double *b, double *c) {
    for (int i = 0; i < N; i++)
        for (int k = 0; k < N; k++) {
            double aik = a[i*N+k];
            for (int j = 0; j < N; j++)
                c[i*N+j] += aik * b[k*N+j];
        }
}

int main() {
    double *a = malloc(N*N*sizeof(double));
    double *b = malloc(N*N*sizeof(double));
    double *c = calloc(N*N, sizeof(double));
    init(a, b);
    multiply(a, b, c);
    printf("%f\n", c[N+1]);
    return 0;
}
