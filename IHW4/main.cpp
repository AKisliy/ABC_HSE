#include <iostream>
#include <unistd.h>
#include <random>
#include <functional>
#include <pthread.h>


const int NUM_FLOWERS = 40;
// possible flower's conditions
enum FlowerState {
    FRESH,
    NEEDS_WATERING,
    WITHERED,
    DEAD
};

// flowerbed
FlowerState flowerStates[NUM_FLOWERS];

// mutexes
pthread_mutex_t flowerMutex[NUM_FLOWERS];
pthread_mutex_t coutMutex;

// simulate flower's "work"
void* flowerRoutine(void* arg) {
    std::random_device dev;
    std::default_random_engine generator(dev());
    std::uniform_int_distribution<int> distribution(0, 10000);
    auto dice = std::bind(distribution, generator);
    int flowerId = *(int *) arg;

    while (true) {
        // random action
        int action = dice() % 3;
        // lock the mutex to change flower's condition
        pthread_mutex_lock(&flowerMutex[flowerId]);
        if (flowerStates[flowerId] == FlowerState::DEAD || flowerStates[flowerId] == FlowerState::WITHERED) {
            break;
        }
            // simulate flower's action
        else {
            pthread_mutex_lock(&coutMutex);
            switch (action) {
                case 0:
                    std::cout << "Flower " << flowerId << " withered" << std::endl;
                    flowerStates[flowerId] = WITHERED;
                    break;
                case 1:
                    std::cout << "Flower " << flowerId << " needs watering" << std::endl;
                    flowerStates[flowerId] = NEEDS_WATERING;
                    break;
                case 2:
                    std::cout << "Flower " << flowerId << " dead" << std::endl;
                    flowerStates[flowerId] = DEAD;
                    break;
            }
            pthread_mutex_unlock(&coutMutex);
        }
        // unlock mutex
        pthread_mutex_unlock(&flowerMutex[flowerId]);
        usleep(300000);
    }
    pthread_mutex_unlock(&flowerMutex[flowerId]);
    return nullptr;
}

// Function to simulate gardener's work
void* gardenerRoutine(void* arg) {
    std::random_device dev;
    std::default_random_engine generator(dev());
    std::uniform_int_distribution<int> distribution(0, 10000);
    auto dice = std::bind(distribution, generator);
    int gardenerId = *(int*)arg;

    while (true) {
        // if all dead
        if(!std::any_of(flowerStates, flowerStates + 40, [](FlowerState x){return x == FlowerState::NEEDS_WATERING
                                                                                  || x == FlowerState::FRESH;})){
            break;
        }
        // choose flower to water
        FlowerState* flowerToWater = std::find_if(flowerStates, flowerStates + 40, [](FlowerState x){return x == FlowerState::NEEDS_WATERING;});
        int index = flowerToWater - flowerStates;
        // if there are no flowers to water - choose random
        if(index == NUM_FLOWERS)
            index = dice() % NUM_FLOWERS;
        // lock the mutex
        pthread_mutex_lock(&flowerMutex[index]);
        pthread_mutex_lock(&coutMutex);
        // water the flower if it's needed
        if (flowerStates[index] == NEEDS_WATERING) {
            std::cout <<"Gardener "<<gardenerId<<" waters flower "<<index<<std::endl;
            flowerStates[index] = FRESH;
        }
        else if(flowerStates[index] == DEAD || flowerStates[index] == WITHERED){
            std::cout<<"Gardener "<<gardenerId<<" tried to water flower "<<index<<", but it's too late :("<<std::endl;
        }
        // unlock the mutex
        pthread_mutex_unlock(&coutMutex);
        pthread_mutex_unlock(&flowerMutex[index]);
        // gardener rests
        usleep(100000);
    }

    return nullptr;
}



int main(int argc, char *argv[]) {
    // initially all flowers are fresh
    for (int i = 0; i < NUM_FLOWERS; ++i) {
        flowerStates[i] = FRESH;
        pthread_mutex_init(&flowerMutex[i], nullptr);
    }
    pthread_mutex_init(&coutMutex, nullptr);
    // create gardeners' threads
    pthread_t gardenerThread1, gardenerThread2;
    int gardenerId1 = 1, gardenerId2 = 2;
    pthread_create(&gardenerThread1, nullptr, gardenerRoutine, &gardenerId1);
    pthread_create(&gardenerThread2, nullptr, gardenerRoutine, &gardenerId2);

    // create flowers' threads
    pthread_t flowerThreads[NUM_FLOWERS];
    int flowerIds[NUM_FLOWERS];
    for (int i = 0; i < NUM_FLOWERS; ++i) {
        flowerIds[i] = i;
        pthread_create(&flowerThreads[i], nullptr, flowerRoutine, &flowerIds[i]);
    }

    pthread_join(gardenerThread1, nullptr);
    pthread_join(gardenerThread2, nullptr);
    for (int i = 0; i < NUM_FLOWERS; ++i) {
        pthread_join(flowerThreads[i], nullptr);
        pthread_mutex_destroy(&flowerMutex[i]);
    }

    pthread_mutex_destroy(&coutMutex);

    return 0;
}
