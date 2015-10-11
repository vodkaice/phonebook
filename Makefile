CC ?= gcc
CFLAGS_common ?= -O0 -Wall -std=gnu99 -g

EXEC = phonebook_orig phonebook_opt
all: $(EXEC)

SRCS_common = main.c
PERF_stat = cache-misses,cache-references,L1-dcache-load-misses,L1-dcache-store-misses,L1-dcache-prefetch-misses,L1-icache-load-misses

phonebook_orig: $(SRCS_common) phonebook_orig.c phonebook_orig.h
	$(CC) $(CFLAGS_common) -DORIG -DIMPL="\"$@.h\"" -o $@ \
		$(SRCS_common) $@.c

phonebook_opt: $(SRCS_common) phonebook_opt.c phonebook_opt.h
	$(CC) $(CFLAGS_common) -DOPT -DIMPL="\"$@.h\"" -o $@ \
		$(SRCS_common) $@.c

run: $(EXEC)
	#watch -d -t ./phonebook_orig
	@sudo sh -c "echo 1 > /proc/sys/vm/drop_caches"
	./phonebook_orig
	./phonebook_opt

perf-stat:
	@sudo sh -c "echo 0 > /proc/sys/kernel/kptr_restrict"
	perf stat -r 10 -e $(PERF_stat) ./phonebook_orig
	perf stat -r 10 -e $(PERF_stat) ./phonebook_opt
	
perf-record:
	@sudo sh -c "echo 0 > /proc/sys/kernel/kptr_restrict"	
	perf record -F 12500 -e cache-misses ./phonebook_orig && perf report
	perf record -F 12500 -e cache-misses ./phonebook_opt && perf report
clean:
	$(RM) $(EXEC) *.o perf.*
