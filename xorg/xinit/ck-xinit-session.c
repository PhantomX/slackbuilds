/*
 * Copyright Red Hat, Inc. 2007,2009.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *  * Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *  * Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 *  * Neither the name of Red Hat, Inc., nor the names of its
 *    contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER
 * OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Gate a process inside of a ConsoleKit session.
 *
 * We want to do this instead of doing it from inside of xinit because at the
 * point we're doing it, we've already added the user's UID to the list of
 * allowed clients for the X server, so the ConsoleKit daemon, which assumes
 * the user's UID, will be able to connect without needing to be able to read
 * the user's X cookies.
 */

#include <sys/types.h>
#include <sys/wait.h>
#include <paths.h>
#include <stdlib.h>
#include <string.h>
#include <syslog.h>
#include <unistd.h>
#include <ck-connector.h>
#include <dbus/dbus.h>

static void
setbusenv(const char *var, const char *val)
{
	DBusConnection *conn;
	DBusMessage *req, *rep;
	DBusMessageIter iter, sub, subsub;
	DBusError error;

	dbus_error_init (&error);

	conn = dbus_bus_get(DBUS_BUS_SESSION, &error);
	if (conn == NULL) {
		return;
	}

	req = dbus_message_new(DBUS_MESSAGE_TYPE_METHOD_CALL);
	if (req == NULL) {
		return;
	}

	memset(&iter, 0, sizeof(iter));
	memset(&sub, 0, sizeof(sub));
	memset(&subsub, 0, sizeof(subsub));
	dbus_message_iter_init_append(req, &iter);
	if (!dbus_message_set_destination(req, DBUS_SERVICE_DBUS) ||
	    !dbus_message_set_path(req, DBUS_PATH_DBUS) ||
	    !dbus_message_set_interface(req, DBUS_INTERFACE_DBUS) ||
	    !dbus_message_set_member(req, "UpdateActivationEnvironment") ||
	    !dbus_message_iter_open_container(&iter,
					      DBUS_TYPE_ARRAY,
					      DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
					      DBUS_TYPE_STRING_AS_STRING
					      DBUS_TYPE_STRING_AS_STRING
					      DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
					      &sub) ||
	    !dbus_message_iter_open_container(&sub,
					      DBUS_TYPE_DICT_ENTRY,
					      NULL,
					      &subsub) ||
	    !dbus_message_iter_append_basic(&subsub, DBUS_TYPE_STRING, &var) ||
	    !dbus_message_iter_append_basic(&subsub, DBUS_TYPE_STRING, &val) ||
	    !dbus_message_iter_close_container(&sub, &subsub) ||
	    !dbus_message_iter_close_container(&iter, &sub)) {
		dbus_message_unref(req);
		return;
	}
	rep = dbus_connection_send_with_reply_and_block(conn, req,
							30000, &error);
	dbus_message_unref(req);
	if (rep) {
		dbus_message_unref(rep);
	}
}

int
main(int argc, char **argv)
{
	CkConnector *ckc = NULL;
	DBusError error;
	const char *shell, *cookie;
	pid_t pid;
	int status;

	ckc = ck_connector_new();
	if (ckc != NULL) {
		dbus_error_init (&error);
		if (ck_connector_open_session(ckc, &error)) {
			pid = fork();
			switch (pid) {
			case -1:
				syslog(LOG_ERR, "error forking child");
				break;
			case 0:
				cookie = ck_connector_get_cookie(ckc);
				setenv("XDG_SESSION_COOKIE", cookie, 1);
				setbusenv("XDG_SESSION_COOKIE", cookie);
				break;
			default:
				waitpid(pid, &status, 0);
				exit(status);
				break;
			}
		} else {
			syslog(LOG_ERR, "error connecting to console-kit");
		}
	} else {
		syslog(LOG_ERR, "error setting up to connect to console-kit");
	}
	if (argc > 1) {
		execvp(argv[1], argv + 1);
	} else {
		shell = getenv("SHELL");
		if (shell == NULL) {
			shell = _PATH_BSHELL;
		}
		execlp(shell, shell, NULL);
	}
	_exit(1);
}
