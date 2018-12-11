//-----------------
//Problem Size
//-----------------
//Make sure it matches size in main.cpp
#define SIZE 1//  should really be very large

//comment if you don't want to see debug messages
//#define DEBUG

// This file should containt the macros and definitions to make the kernel file work with LLVM
// OpenCL specific keywords and types should be removed or changed
// Macros
// ... your code here ...
#define __kernel
#define __global
#define pipe
#define read_only
#define write_only



// OpenCL API functions should be defined with a stub
// Stubs
// ... your code here ...
void write_pipe (char ch00, int *data0){}
void read_pipe (char ch00, int *dataInt0){}
int get_pipe_num_packets(int a){return a;}



//------------------------------------------
// Read memory kernel (scalar version)
//------------------------------------------
__kernel void kernelInput ( int aIn0
                          , int aIn1
                          , write_only pipe int     ch00a
                          , write_only pipe int     ch01a
                          ) {
  int data0, data1;
  //for(int i=0; i<SIZE; i++) {
    //read from global memory
    data0 = aIn0;
    data1 = aIn1;
    
    //write to channel
    write_pipe(ch00a, &data0);
    write_pipe(ch01a, &data1);
  //}
}//() 


//----------------------
//Compute kernel
//----------------------
__kernel void kernelComputeA ( 
                         read_only  pipe int ch00a
                        ,read_only  pipe int ch01a
                        ,write_only pipe int ch1a
                            ) {

  //locals
  int dataIn0, dataIn1, dataOut;
  int i; 


  //for(i=0; i < SIZE; i++) {
    //read from channels
    read_pipe(ch00a, &dataIn0);
    read_pipe(ch01a, &dataIn1);
    
    //the computation
    //dataOut = dataIn0 + dataIn1;
    dataOut = dataIn0 * dataIn1;
  
    //write to channel
    write_pipe(ch1a, &dataOut);
  //}
}//()

//----------------------
//Compute kernel
//----------------------
__kernel void kernelComputeB ( 
                         read_only  pipe int ch1a
                        ,write_only pipe int ch1b
                            ) {

  //locals
  int dataIn0, dataOut;
  int i; 


  //for(i=0; i < SIZE; i++) {
    //read from channels
    read_pipe(ch1a, &dataIn0);
    
    //the computation
    dataOut = dataIn0 + dataIn0;
  
    //write to channel
    write_pipe(ch1b, &dataOut);
}//()


//------------------------------------------
// Write memory kernel
//------------------------------------------
__kernel void kernelOutput( int *aOut
                          , read_only pipe int ch1b
                          ) {
  int data;
  //for (int i=0; i < SIZE; i++) {
    //read from channel
    //while(get_pipe_num_packets(ch1)==0); //busy-wait until packet available in the pipe
    read_pipe(ch1b, &data);
    
    //write to global mem
    *aOut = data;
  //}
}//()
