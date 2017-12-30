#define _POSIX_C_SOURCE 200809L
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <search.h>

#ifndef HASH_TABLE_SIZE
# define HASH_TABLE_SIZE 50000
#endif

#define msg(...)     fprintf(stderr, __VA_ARGS__)
#define msgstr(x)    fputs((x), stderr)

static char *index_lines[HASH_TABLE_SIZE];
static size_t index_count = 0;

static void write_maps (const char* list_file) {
	FILE* fp = fopen (list_file, "r");
	if (fp == NULL) {
		msg ("Cannot open list file %s\n", list_file);
		perror ("fopen");
		exit (3);
	}

	char* line = NULL;
	size_t len = 0;
	unsigned n;

	for (n = 0; getline (&line, &len, fp) >= 0; n++) {
		strtok (line, "\n");

		ENTRY hfind = {
			.key = line,
			.data = NULL
		};
		ENTRY* hresult = hsearch (hfind, FIND);
		if (hresult == NULL) {
			msg ("Cannot find origin for %s\n", line);
			exit (4);
		}

		printf ("%-32s %s\n", line, hresult->data);
	}

	free (line);

	if (!feof (fp)) {
		msgstr ("Fail to read the whole list file\n");
		perror ("getline");
		exit (6);
	}

	msg ("=> %u packages entries processed\n", n);
	fclose (fp);
}

static void read_entries (const char* index_file) {
	FILE* fp = fopen (index_file, "r");
	if (fp == NULL) {
		msg ("Cannot open index file %s\n", index_file);
		perror ("fopen");
		exit (3);
	}

	char* line = NULL;
	size_t len = 0;
	unsigned n;

	for (n = 0; getline (&line, &len, fp) >= 0; n++) {
		strtok (line, "\n");

		char* pkgname = strtok (line, "|");
		if (pkgname == NULL) {
			msgstr ("Malformed index file - no package name\n");
			exit (4);
		}

		char* pkgname_end = strrchr (line, '-');
		if (pkgname_end != NULL) {
			*pkgname_end = '\0';
		}

		char* fullpath = strtok (NULL, "|");
		if (fullpath == NULL) {
			msgstr ("Malformed index file - no path\n");
			exit (4);
		}

		bool dir_sp_got = false;
		for (char* p = fullpath + strlen (fullpath); p >= fullpath; p--) {
			if (*p == '/') {
				if (dir_sp_got) {
					fullpath = p + 1;
					break;
				} else {
					dir_sp_got = true;
				}
			}
		}

		ENTRY hentry = {
			.key = pkgname,
			.data = fullpath
		};
		if (hsearch (hentry, ENTER) == NULL || index_count >= HASH_TABLE_SIZE) {
			msgstr ("The hash table is full!\n");
			exit (5);
		}

		index_lines[index_count++] = line;
		line = NULL;
		len = 0;
	}

	free (line);

	if (!feof (fp)) {
		msgstr ("Fail to read the whole index file\n");
		perror ("getline");
		exit (6);
	}

	msg ("=> %u ports entries read\n", n);
	fclose (fp);
}

int main (int argc, char* argv[]) {
	if (argc < 3) {
		msg ("Usage: %s list_file index_file\n", argv[0]);
		return 1;
	}

	if (!hcreate (HASH_TABLE_SIZE)) {
		msg ("Cannot create a hash table with size %d\n", HASH_TABLE_SIZE);
		perror ("hcreate");
		return 2;
	}

	read_entries (argv[2]);
	write_maps (argv[1]);

	for (size_t i = 0; i < index_count; i++) {
		free (index_lines[i]);
	}

	hdestroy ();

	return 0;
}
