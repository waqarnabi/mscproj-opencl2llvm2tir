LDLIBS      = -l OpenCL
CXXFLAGS    = -std=c++11 -O2 -g -DIntel -lpthread -DLINUX -DTARGET=CPU
HOST_SRCS   = ../host/main.cpp
CXX         = /usr/bin/g++
HOST_EXE		= host.exe
OUTPUTFILES = error.log out.dat

#Opencl 2.0 for pipes
#CXXFLAGS += -cl-std=CL2.0

ifdef CHANNELS
CXXFLAGS += -DCHANNELS
endif


host: $(HOST_EXE)

$(HOST_EXE): $(HOST_SRCS)
	$(CXX) $(CXXFLAGS) $< -o $@ $(LDLIBS)
	
clean: 
	rm -f $(HOST_EXE) $(OUTPUTFILES)
