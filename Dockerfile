FROM debian:10 


#------------------------------------------------------------------
# System requirements
#------------------------------------------------------------------

RUN apt update && \
    apt install -y \
    python3 \
    python3-pip \
    git \
    tor \
    nmap \
    nikto \


#------------------------------------------------------------------
# Python requirements
#------------------------------------------------------------------

COPY python-requirements.txt .
RUN pip3 install -r python-requirements.txt

#------------------------------------------------------------------
# Install pwned or not
#------------------------------------------------------------------

RUN git clone https://github.com/thewhiteh4t/pwnedOrNot.git && \
    cd pwnedOrNot && \
    ln -s $PWD/pwnedornot.py /usr/bin/pwnedornot

#------------------------------------------------------------------
# Install Karma
#------------------------------------------------------------------

RUN git clone https://github.com/decoxviii/karma && \
    cd karma && \
    python3 setup.py build && \
    python3 setup.py install

#------------------------------------------------------------------
# Install Sherlock 
#------------------------------------------------------------------

RUN git clone https://github.com/sherlock-project/sherlock.git && \
    cd sherlock && \
    ln -s $PWD/sherlock.py /usr/bin/sherlock

