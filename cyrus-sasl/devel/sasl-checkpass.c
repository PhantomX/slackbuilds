#include <errno.h>
#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>

#include "sasl.h"
#ifdef SASL2
static int main_requested_sasl_version = 2;
#else
static int main_requested_sasl_version = 1;
#endif

static int main_verbose = 0;

static int
my_getopt(void *context, const char *plugin_name,
	  const char *option, const char **result, unsigned *len)
{
	if (result) {
		*result = NULL;
		if (strcmp(option, "pwcheck_method") == 0) {
			*result = "saslauthd";
		}
		if (strcmp(option, "saslauthd_version") == 0) {
			switch (main_requested_sasl_version) {
			case 1:
				*result = "1";
				break;
			case 2:
				*result = "2";
				break;
			default:
#ifdef SASL2
				*result = "2";
#else
				*result = "1";
#endif
				break;
			}
		}
		if (main_verbose) {
			fprintf(stderr, "Getopt plugin=%s%s%s/option=%s%s%s -> ",
				plugin_name ? "\"" : "",
				plugin_name ? plugin_name : "(null)",
				plugin_name ? "\"" : "",
				option ? "\"" : "",
				option ? option : "(null)",
				option ? "\"" : "");
			fprintf(stderr, "'%s'.\n", *result ? *result : "");
		}
	}
	if (len) {
		*len = 0;
	}
	return 0;
}

int
main(int argc, char **argv)
{
	const char *user, *realm, *passwd, *service, *mechs, **globals, *err;
	int c, ret;
	sasl_callback_t callbacks[] = {
		{SASL_CB_GETOPT, my_getopt, NULL},
		{SASL_CB_LIST_END},
	};
	sasl_conn_t *connection;
	char hostname[512];
	char fulluser[512]; /* XXX: may overflow */

	user = realm = passwd = service = "";
	strcpy(hostname, "localhost");
	gethostname(hostname, sizeof(hostname));

	while ((c = getopt(argc, argv, "u:r:p:s:h:12v")) != -1) {
		switch (c) {
		case 'u':
			user = optarg;
			break;
		case 'r':
			realm = optarg;
			break;
		case 'p':
			passwd = optarg;
			break;
		case 's':
			service = optarg;
			break;
		case 'h':
			strncpy(hostname, optarg, sizeof(hostname) - 1);
			hostname[sizeof(hostname) - 1] = '\0';
			break;
		case '1':
			main_requested_sasl_version = 1;
			break;
		case '2':
			main_requested_sasl_version = 2;
			break;
		case 'v':
			main_verbose++;
			break;
		default:
			printf("Usage: %s [-v] [-1] [-2] "
			       "[-h hostname] "
			       "[-u user] "
			       "[-r realm] "
			       "[-p password] "
			       "[-s service] "
			       "\n", argv[0]);
			return 2;
			break;
		}
	}
	if ((strlen(user) == 0) || (strlen(passwd) == 0)) {
		printf("Usage: %s [-v] [-1] [-2] "
		       "[-h hostname] "
		       "[-u user] "
		       "[-r realm] "
		       "[-p password] "
		       "[-s service] "
		       "\n", argv[0]);
		return 2;
	}
	if (realm && (strlen(realm) > 0)) {
		sprintf(fulluser, "%s@%s", user, realm);
	} else {
		sprintf(fulluser, "%s", user);
	}

	ret = sasl_server_init(callbacks,
			       strlen(service) ? service : "sasl-checkpass");
	if (ret != SASL_OK) {
		fprintf(stderr, "Error in sasl_server_init(): %s\n",
			sasl_errstring(ret, NULL, NULL));
	}

	connection = NULL;
	ret = sasl_server_new(strlen(service) ? service : "sasl-checkpass",
			      hostname,
			      NULL,
#ifdef SASL2
			      NULL,
			      NULL,
#endif
			      callbacks,
			      0,
			      &connection);
	if (ret != SASL_OK) {
		fprintf(stderr, "Error in sasl_server_new(): %s\n",
			sasl_errstring(ret, NULL, NULL));
	}

	err = NULL;
	ret = sasl_checkpass(connection,
			     fulluser, strlen(fulluser),
			     passwd, strlen(passwd)
#ifndef SASL2
			     , &err
#endif
			     );
	switch (ret) {
	case SASL_OK:
		printf("OK\n");
		break;
	default:
		printf("NO: %d", ret);
		switch (ret) {
		case SASL_FAIL:
			err = "generic failure";
			break;
		case SASL_BADAUTH:
			err = "authentication failure";
			break;
		default:
			err = NULL;
			break;
		}
		if (err) {
			printf(" (%s)", err);
		}
		printf("\n");
		break;
	}
	return ret;
}
