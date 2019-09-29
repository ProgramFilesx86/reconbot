FROM debian:10 


#------------------------------------------------------------------
# System requirements
#------------------------------------------------------------------

RUN apt update && \
    apt install -y \
    python3 \
    python3-pip \
    git

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
# 
#------------------------------------------------------------------

