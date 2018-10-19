//-----------------
//Problem Size
//-----------------
//Make sure it matches size in main.cpp
#define SIZE      10

//----------------------
//Compute kernel
//----------------------
__kernel void kernelCompute ( global int * restrict aIn0
                            , global int * restrict aIn1
                            , global int * restrict aOut
                            ) {

  for(int i=0; i<SIZE; i++) {
      aOut[i] = aIn0[i] + aIn1[i];      
  }                          
}//()