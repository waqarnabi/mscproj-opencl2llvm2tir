
lines_in = [ 
        "define void @kernelOutput(i32* noalias nocapture %aOut, i32 %ch1) #0 {"
        '%1 = add nsw i32 %ch01, %ch00',
        'store i32 %1, i32* %ch1, align 4',
        'ret void'
        ]

lines_out = []


for str_in in lines_in:
    str_out = ""

    chunks = str_in.split()
    for chunk in chunks:
        if (chunk != "define" and chunk != "void"):
            for ch in chunk:
                if (ch != '@' and ch != '%' and ch != '#' and ch != '(' and ch != ')'):
                    str_out += ch
        str_out+=' '            

#    print(str_out)        
    lines_out.append(str_out)

for line in lines_out:
    print(line)
