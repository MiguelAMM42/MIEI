break getbuf
run
print /x *((int*)$ebp+1)
print /x *(int*)$ebp
print /x ($ebp - 12)
quit
