FROM debian:10 

#-----------------------
#System requirements
#-----------------------

RUN apt update && \
    apt install -y \
    python3 \
    python3-pip \
    git
    
#-----------------------
#Install pwned or not
#-----------------------

RUN git clone https://github.com/thewhiteh4t/pwnedOrNot.git && \
    cd pwnedOrNot && \
    ln -s $PWD/pwnedornot.py /usr/bin/pwnedornot



