#include <iostream>
#include <unistd.h>
#include <random>
#include <functional>
#include <pthread.h>
#include <fstream>


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
pthread_mutex_t fileMutex;

std::ofstream fileWriter;

// simulate flower's "work"
void* flowerRoutine(void* arg) {
    std::random_device dev;
    std::default_random_engine generator(dev());
    std::uniform_int_distribution<int> distribution(0, 10000);
    auto dice = std::bind(distribution, generator);
    int flowerId = *(int *) arg;

    while (true) {
        // random action
        int action = dice() % 2;
        // lock the mutex to change flower's condition
        pthread_mutex_lock(&flowerMutex[flowerId]);
        // if flower dead - break the work
        if (flowerStates[flowerId] == FlowerState::DEAD || flowerStates[flowerId] == FlowerState::WITHERED) {
            break;
        }
        bool writeToFile = fileWriter.is_open();
        if(writeToFile)
            pthread_mutex_lock(&fileMutex);
        pthread_mutex_lock(&coutMutex);
        if(flowerStates[flowerId] == FlowerState::FRESH){
            switch (action) {
                case 0:
                    std::cout << "Flower " << flowerId << " is really fresh" << std::endl;
                    if(writeToFile)
                        fileWriter << "Flower " << flowerId << " is really fresh\n";
                    break;
                case 1:
                    std::cout << "Flower " << flowerId << " needs watering" << std::endl;
                    if(writeToFile)
                        fileWriter <<"Flower " << flowerId << " needs watering\n";
                    flowerStates[flowerId] = NEEDS_WATERING;
                    break;
            }
        }
        // simulate flower's action
        else {
            switch (action) {
                case 0:
                    std::cout << "Flower " << flowerId << " withered" << std::endl;
                    if(fileWriter.is_open())
                        fileWriter << "Flower " << flowerId << " withered\n";
                    flowerStates[flowerId] = WITHERED;
                    break;
                case 1:
                    std::cout << "Flower " << flowerId << " dead" << std::endl;
                    if(fileWriter.is_open())
                        fileWriter <<"Flower " << flowerId << " dead\n";
                    flowerStates[flowerId] = DEAD;
                    break;
            }

        }
        pthread_mutex_unlock(&coutMutex);
        if(writeToFile)
            pthread_mutex_unlock(&fileMutex);
        // unlock mutex
        pthread_mutex_unlock(&flowerMutex[flowerId]);
        // sleep for a while
        usleep(650000);
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
        if(fileWriter.is_open())
            pthread_mutex_lock(&fileMutex);
        // water the flower if it's needed
        if (flowerStates[index] == NEEDS_WATERING) {
            std::cout <<"Gardener "<<gardenerId<<" waters flower "<<index<<std::endl;
            if(fileWriter.is_open())
                fileWriter<< "Gardener "<<gardenerId<<" waters flower\n";
            flowerStates[index] = FRESH;
        }
        else if(flowerStates[index] == DEAD || flowerStates[index] == WITHERED){
            if(fileWriter.is_open())
                fileWriter<<"Gardener "<<gardenerId<<" tried to water flower "<<index<<", but it's too late :(\n";
            std::cout<<"Gardener "<<gardenerId<<" tried to water flower "<<index<<", but it's too late :("<<std::endl;
        }
        else{
            if(fileWriter.is_open())
                fileWriter<<"OOPS, Gardener "<<gardenerId<<" watered fresh flower "<<index<<" by accident! \n";
            std::cout<<"OOPS, Gardener "<<gardenerId<<" watered fresh flower "<<index<<" by accident! \n";
            flowerStates[index] = WITHERED;
        }
        // unlock the mutex
        if(fileWriter.is_open())
            pthread_mutex_unlock(&fileMutex);
        pthread_mutex_unlock(&coutMutex);
        pthread_mutex_unlock(&flowerMutex[index]);
        // gardener rests
        usleep(300000);
    }

    return nullptr;
}

std::ofstream getFile(int argc, char *argv[]){
    std::ofstream fout;
    if(argc == 1)
        return fout;
    fout.open(argv[1]);
    return fout;
}

int main(int argc, char *argv[]) {
    fileWriter = getFile(argc, argv);
    // initially all flowers are fresh
    for (int i = 0; i < NUM_FLOWERS; ++i) {
        flowerStates[i] = FRESH;
        pthread_mutex_init(&flowerMutex[i], nullptr);
    }
    pthread_mutex_init(&coutMutex, nullptr);
    pthread_mutex_init(&fileMutex, nullptr);
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
    pthread_mutex_destroy(&fileMutex);

    if(fileWriter.is_open())
        fileWriter.close();

    return 0;
}
