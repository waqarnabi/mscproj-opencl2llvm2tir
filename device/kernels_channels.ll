; ModuleID = 'llvm_tmp.opt1.ll'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define void @write_pipe(i8 signext %ch00, i32* %data0) #0 {
entry:
  ret void
}

; Function Attrs: nounwind uwtable
define void @read_pipe(i8 signext %ch00, i32* %dataInt0) #0 {
entry:
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @get_pipe_num_packets(i32 %a) #0 {
entry:
  ret i32 %a
}

; Function Attrs: nounwind uwtable
define void @kernelInput(i32 %aIn0, i32 %aIn1, i32 %ch00, i32 %ch01) #0 {
entry:
  %data0 = alloca i32, align 4
  %data1 = alloca i32, align 4
  store i32 %aIn0, i32* %data0, align 4
  store i32 %aIn1, i32* %data1, align 4
  %conv = trunc i32 %ch00 to i8
  call void @write_pipe(i8 signext %conv, i32* %data0)
  %conv1 = trunc i32 %ch01 to i8
  call void @write_pipe(i8 signext %conv1, i32* %data1)
  ret void
}

; Function Attrs: nounwind uwtable
define void @kernelCompute(i32 %ch00, i32 %ch01, i32 %ch1) #0 {
entry:
  %dataIn0 = alloca i32, align 4
  %dataIn1 = alloca i32, align 4
  %dataOut = alloca i32, align 4
  %conv = trunc i32 %ch00 to i8
  call void @read_pipe(i8 signext %conv, i32* %dataIn0)
  %conv1 = trunc i32 %ch01 to i8
  call void @read_pipe(i8 signext %conv1, i32* %dataIn1)
  %0 = load i32, i32* %dataIn0, align 4
  %1 = load i32, i32* %dataIn1, align 4
  %add = add nsw i32 %0, %1
  store i32 %add, i32* %dataOut, align 4
  %conv2 = trunc i32 %ch1 to i8
  call void @write_pipe(i8 signext %conv2, i32* %dataOut)
  ret void
}

; Function Attrs: nounwind uwtable
define void @kernelOutput(i32* %aOut, i32 %ch1) #0 {
entry:
  %data = alloca i32, align 4
  %conv = trunc i32 %ch1 to i8
  call void @read_pipe(i8 signext %conv, i32* %data)
  %0 = load i32, i32* %data, align 4
  store i32 %0, i32* %aOut, align 4
  ret void
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.1 (tags/RELEASE_381/final)"}
