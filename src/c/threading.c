// 5️⃣ Multithreaded Synchronization and Memory Safety
// 
// Compile: gcc -O2 -S src/c/threading.c -o target/threading.s -lpthread
// Assembly file: target/threading.s
//
// Key assembly differences to observe:
// - Explicit pthread_mutex_lock/unlock function calls
// - Manual thread creation and destruction management
// - No compile-time thread safety guarantees
// - Direct access to global variables
// - Programmer must manually ensure thread safety
// - May show similar atomic operation instructions as Rust
// - Risk of data races if synchronization is incorrect
// - Manual resource management prone to errors

#include <stdio.h>
#include <pthread.h>

int counter = 0;
pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;

void* worker(void* arg) {
    pthread_mutex_lock(&lock);
    counter++;
    pthread_mutex_unlock(&lock);
    return NULL;
}

int main() {
    pthread_t threads[10];
    
    for(int i = 0; i < 10; i++) {
        pthread_create(&threads[i], NULL, worker, NULL);
    }
    
    for(int i = 0; i < 10; i++) {
        pthread_join(threads[i], NULL);
    }
    
    printf("Result: %d\n", counter);
    return 0;
} 