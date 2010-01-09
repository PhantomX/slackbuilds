dnl# This is the a sendmail .mc file for Slackware with TLS support.
dnl# To generate the sendmail.cf file from this (perhaps after making
dnl# some changes), use the m4 files in /usr/share/sendmail/cf like this:
dnl#
dnl# cp sendmail-slackware-tls.mc /usr/share/sendmail/cf/config.mc
dnl# cd /usr/share/sendmail/cf
dnl# sh Build config.mc
dnl#
dnl# You may then install the resulting .cf file:
dnl# cp config.cf /etc/mail/sendmail.cf
dnl#
include(`../m4/cf.m4')
VERSIONID(`TLS supporting setup for Slackware Linux')dnl
OSTYPE(`linux')dnl
dnl#
dnl# You will need to create the certificates below with OpenSSL first:
define(`confCACERT_PATH', `/etc/mail/certs/')
define(`confCACERT', `/etc/mail/certs/CA.cert.pem')
define(`confSERVER_CERT', `/etc/mail/certs/smtp.cert.pem')
define(`confSERVER_KEY', `/etc/mail/certs/smtp.key.pem')
dnl# These settings help protect against people verifying email addresses
dnl# at your site in order to send you email that you probably don't want:
define(`confPRIVACY_FLAGS', `authwarnings,novrfy,noexpn,restrictqrun')dnl
dnl# Uncomment the line below to send outgoing mail through an external server:
dnl define(`SMART_HOST',`mailserver.example.com')
dnl# No timeout for ident:
define(`confTO_IDENT', `0')dnl
dnl# Enable the line below to use smrsh to restrict what sendmail can run:
dnl FEATURE(`smrsh',`/usr/sbin/smrsh')dnl
dnl# See the README in /usr/share/sendmail/cf for a ton of information on
dnl# how these options work:
FEATURE(`use_cw_file')dnl
FEATURE(`use_ct_file')dnl
FEATURE(`mailertable',`hash -o /etc/mail/mailertable.db')dnl
FEATURE(`virtusertable',`hash -o /etc/mail/virtusertable.db')dnl
FEATURE(`access_db', `hash -T<TMPF> /etc/mail/access')dnl
FEATURE(`blacklist_recipients')dnl
FEATURE(`local_procmail',`',`procmail -t -Y -a $h -d $u')dnl
FEATURE(`always_add_domain')dnl
FEATURE(`redirect')dnl
FEATURE(`no_default_msa')dnl
dnl# Turn this feature on if you don't always have DNS, or enjoy junk mail:
dnl FEATURE(`accept_unresolvable_domains')dnl
EXPOSED_USER(`root')dnl
dnl# Also accept mail for localhost.localdomain:
LOCAL_DOMAIN(`localhost.localdomain')dnl
MAILER(local)dnl
MAILER(smtp)dnl
MAILER(procmail)dnl
dnl# Allow SASL authentication/relaying:
define(`confAUTH_OPTIONS', `A p y')dnl
define(`confAUTH_MECHANISMS', `LOGIN PLAIN DIGEST-MD5 CRAM-MD5')dnl
TRUST_AUTH_MECH(`LOGIN PLAIN DIGEST-MD5 CRAM-MD5')dnl
DAEMON_OPTIONS(`Port=smtp, Name=MTA')dnl
dnl# Daemon options after M= below that might need to be changed are:
dnl# s (allow SSL, not only TLS)
dnl# a (require authentication)
DAEMON_OPTIONS(`Port=smtps, Name=MSA-SSL, M=Esa')dnl
LOCAL_CONFIG
dnl# Do not allow the weak SSLv2:
O CipherList=ALL:!ADH:!NULL:!EXPORT56:RC4+RSA:+HIGH:+MEDIUM:-LOW:+SSLv3:+TLSv1:-SSLv2:+EXP:+eNULL
