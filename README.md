# PGUP attempts, notes, ect

My progress through the book [Programming From the Group Up](savannah.nongnu.org/projects/pgubook/).
Putting it up here so I can share/discuss with friends. Maybe it'll even help others who get stuck.

---

### For x86_64

Because the world has moved on and man can be a bit annoying at times

````
as --32 myprogram.s -o myprogram.o
ld -m elf_i386 myprogram.o -o myprogram
````
