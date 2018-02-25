# CoCalcTM = CoCalc + Libs

This is Docker container build on top of CoCalc image (https://github.com/sagemathinc/cocalc-docker) with some useful packages missing from CoCalc Docker, such as Anaconda.

Prerequisites:
+ Docker

To build image, type

    sudo make build
    
To run container, type

    sudo make run
    
To stop container, type

    sudo make stop
    
To start again, type

    sudo make start
    
