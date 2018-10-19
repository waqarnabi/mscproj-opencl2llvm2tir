//-----------------
//Problem Size
//-----------------
//Make sure it matches size in main.cpp
#define SIZE      1 //  should really be very large

//comment if you don't want to see debug messages
//#define DEBUG


//------------------------------------------
// Read memory kernel
//------------------------------------------
__kernel void kernelInput ( __global int * restrict aIn0
                          , __global int * restrict aIn1
                          , write_only pipe int     ch00
                          , write_only pipe int     ch01
                          ) {
  int data0, data1;
  for(int i=0; i<SIZE; i++) {
    //read from global memory
    data0 = aIn0[i];
    data1 = aIn1[i];
    
    //write to channel
    write_pipe(ch00, &data0);
    write_pipe(ch01, &data1);
    #ifdef DEBUG    
      printf("DEV::kernelInput: i = %d, written to ch0: %d\n", i, data);
    #endif
  }
}//() 

//----------------------
//Compute kernel
//----------------------
__kernel void kernelCompute ( 
                         read_only  pipe int ch00
                        ,read_only  pipe int ch01
                        ,write_only pipe int ch1
                            ) {

  //locals
  int dataIn0, dataIn1, dataOut;
  int i; 


  for(i=0; i < SIZE; i++) {
    //read from channels
    read_pipe(ch00, &dataIn0);
    read_pipe(ch01, &dataIn1);
    #ifdef DEBUG    
      printf("DEV::kernelCompute: i = %d, read from ch0 = %d :: ch1 = %d\n", i, dataIn0, dataIn1);
    #endif
    
    //the computation
    dataOut = dataIn0 + dataIn1;
  
    //write to channel
    write_pipe(ch1, &dataOut);
    #ifdef DEBUG    
      printf("DEV::kernelCompute: i = %d, written to ch1: %d\n", i, dataOut);
    #endif
  }
}//()


//------------------------------------------
// Write memory kernel
//------------------------------------------
__kernel void kernelOutput( __global int * restrict aOut
                          , read_only pipe int      ch1
                          ) {
  int data;
  for (int i=0; i < SIZE; i++) {
    //read from channel
    while(get_pipe_num_packets(ch1)==0); //busy-wait until packet available in the pipe
    read_pipe(ch1, &data);
    #ifdef DEBUG    
      printf("DEV::kernelOutput: i = %d, read from ch1: %d\n", i, data);
    #endif  
    
    //write to global mem
    aOut[i] = data;
  }
}//()
