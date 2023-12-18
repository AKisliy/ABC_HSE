#include <iostream>
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include <queue>
#include <random>
#include <functional>

std::random_device dev;
std::default_random_engine generator(dev());
std::uniform_int_distribution<int> distribution(0, 10000);
auto dice = std::bind(distribution, generator);
std::queue<int> queue; // buffer
std::vector<pthread_t> sum_threads; // vector with adders
static int counter; // current size of queue
static int sum_index; // Adder index
pthread_cond_t condCounter;
pthread_mutex_t mutex;

// Producer's function
void *Producer(void* param) {
    int pNum = *((int*)param);
    int time = 1 + dice()%7; // random time to produce
    sleep(time);
    int data;
    data = 1 +  dice()% 20; // random data
    pthread_mutex_lock(&mutex);
    queue.push(data); // push data to queue
    counter++;
    if (counter > 1) // signal
        pthread_cond_signal(&condCounter);
    printf("Producer %d: created value = %d\n", pNum, data) ;
    pthread_mutex_unlock(&mutex);

    return nullptr;
}
// function for adders
void *Adder(void* param) {
    int count = *((int*)param);
    int current_index = sum_index++;
    printf("Adder %d created!\n", current_index) ;
    int time_sum = 3 +  dice() % 4; // random time to sum
    int sum = 0;
    sleep(time_sum);
    pthread_mutex_lock(&mutex) ;
    while (count > 0) { // count sum
        sum += queue.front();
        queue.pop();
        --count;
    }
    queue.push(sum); // push sum to queue
    counter++;
    if (counter > 1)
        pthread_cond_signal(&condCounter);
    printf("Adder %d count sum of values = %d\n", current_index, sum);
    pthread_mutex_unlock(&mutex);
    return nullptr;
}

// Handler's function
void *Handler(void* args) {
    int now_count;
    while (true) {
        pthread_t newAdder;
        pthread_mutex_lock(&mutex) ;
        while (counter < 2) { // wait till there are less than 2 items
            pthread_cond_wait(&condCounter, &mutex);
        }
        sum_threads.push_back(newAdder);
        now_count = 2; // how many items to sum
        pthread_create(&newAdder, nullptr, Adder, (void *) (&now_count));
        counter -= now_count;
        pthread_mutex_unlock(&mutex);
    }
}

int main() {
    int i;
    // create mutex and conditional variable
    pthread_mutex_init(&mutex, nullptr);
    pthread_cond_init(&condCounter, nullptr);
    // Handler thread
    pthread_t handlerThread;
    pthread_create(&handlerThread, nullptr, Handler, nullptr);

    //start producers
    pthread_t producersThreads[20];
    int producers[20];
    for (i = 0 ; i < 20; ++i) {
        producers[i] = i + 1;
        pthread_create(&producersThreads[i], nullptr, Producer, (void *) (producers + i)) ;
    }

    for (i = 0 ; i < 20; ++i) {
        pthread_join(producersThreads[i], nullptr);
    }


    for(i = 0; i < sum_threads.size(); ++i) {
        pthread_join(sum_threads[i], nullptr);
    }

    sleep(15); // some sleep
    std::cout << "Result = " << queue.front();
    // destroy mutex and conditional var
    pthread_mutex_destroy(&mutex);
    pthread_cond_destroy(&condCounter);
    return 0;
}
