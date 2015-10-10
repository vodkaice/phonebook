CC ?= gcc
CFLAGS_common ?= -O0 -Wall -std=gnu99

EXEC = phonebook_orig phonebook_opt
all: $(EXEC)

SRCS_common = main.c

phonebook_orig: $(SRCS_common) phonebook_orig.c phonebook_orig.h
	$(CC) $(CFLAGS_common) -DIMPL="\"$@.h\"" -o $@ \
		$(SRCS_common) $@.c

phonebook_opt: $(SRCS_common) phonebook_opt.c phonebook_opt.h
	$(CC) $(CFLAGS_common) -DIMPL="\"$@.h\"" -o $@ \
		$(SRCS_common) $@.c

#watch -d -t ./phonebook_orig
run: $(EXEC)
	@sudo sh -c "echo 1 > /proc/sys/vm/drop_caches"
	./phonebook_orig

perf:
	sudo sh -c "echo 0 > /proc/sys/kernel/kptr_restrict"

clean:
	$(RM) $(EXEC) *.o perf.*
