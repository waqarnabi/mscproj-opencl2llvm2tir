# Strip .cl from filename
filename="${1%.*}"

# Copy the original file to llvm_tmp_.cl
cp $1 llvm_tmp_.cl
# llvm_tmp_.cl is #included in llvm_tmp.c
# llvm_tmp.c has macros to undef OpenCL type attributes etc

# Run LLVM
# Make sure the LLVM version is 3.8
clang -O0 -S -Wunknown-attributes -emit-llvm -c  llvm_tmp.c -o llvm_tmp.unopt.ll
opt -mem2reg -S llvm_tmp.unopt.ll -o llvm_tmp.opt1.ll
clang  -O1 -S -emit-llvm llvm_tmp.opt1.ll -o $1.ll

# Rename the final file
mv $1.ll $filename.ll
