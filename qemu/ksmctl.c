/* Start/stop KSM, for systemd.
 * Copyright (C) 2009, 2011 Red Hat, Inc.
 * Written by Paolo Bonzini <pbonzini@redhat.com>.
 * Based on the original sysvinit script by Dan Kenigsberg <danken@redhat.com>
 * This file is distributed under the GNU General Public License, version 2
 * or later.  */

#include <unistd.h>
#include <stdio.h>
#include <limits.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#define KSM_MAX_KERNEL_PAGES_FILE "/sys/kernel/mm/ksm/max_kernel_pages"
#define KSM_RUN_FILE		  "/sys/kernel/mm/ksm/run"

char *program_name;

int usage(void)
{
	fprintf(stderr, "Usage: %s {start|stop}\n", program_name);
	return 1;
}

int write_value(uint64_t value, char *filename)
{
	FILE *fp;
	if (!(fp = fopen(filename, "w")) ||
	    fprintf(fp, "%llu\n", (unsigned long long) value) == EOF ||
	    fflush(fp) == EOF ||
	    fclose(fp) == EOF)
		return 1;

	return 0;
}

uint64_t ksm_max_kernel_pages()
{
	char *var = getenv("KSM_MAX_KERNEL_PAGES");
	char *endptr;
	uint64_t value;
	if (var && *var) {
		value = strtoll(var, &endptr, 0);
		if (value < LLONG_MAX && !*endptr)
			return value;
	}
	/* Unless KSM_MAX_KERNEL_PAGES is set, let KSM munch up to half of
	 * total memory.  */
	return sysconf(_SC_PHYS_PAGES) / 2;
}

int start(void)
{
	if (access(KSM_MAX_KERNEL_PAGES_FILE, R_OK) >= 0)
		write_value(ksm_max_kernel_pages(), KSM_MAX_KERNEL_PAGES_FILE);
	return write_value(1, KSM_RUN_FILE);
}

int stop(void)
{
	return write_value(0, KSM_RUN_FILE);
}

int main(int argc, char **argv)
{
	program_name = argv[0];
	if (argc < 2) {
		return usage();
	} else if (!strcmp(argv[1], "start")) {
		return start();
	} else if (!strcmp(argv[1], "stop")) {
		return stop();
	} else {
		return usage();
	}
}
