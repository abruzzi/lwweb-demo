#!/bin/bash
#
# Selenium standalone server init script.
#
# For Debian-based distros.
#
### BEGIN INIT INFO
# Provides:          selenium-standalone
# Required-Start:    $local_fs $remote_fs $network $syslog
# Required-Stop:     $local_fs $remote_fs $network $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Selenium standalone server
### END INIT INFO

DESC="Selenium standalone server"
USER=selenium
JAVA=/usr/bin/java
PID_FILE=/var/run/selenium.pid
JAR_FILE=/usr/local/share/selenium/selenium-server-standalone-2.39.0.jar
LOG_FILE=/var/log/selenium/selenium.log
CHROME_DRIVER=/usr/local/bin/chromedriver

DAEMON_OPTS="-Xmx500m -Xss1024k -Dwebdriver.chrome.driver=$CHROME_DRIVER -jar $JAR_FILE -log $LOG_FILE"
# See this Stack Overflow item for a delightful bug in Java that requires the
# strange-looking java.security.egd workaround below:
# http://stackoverflow.com/questions/14058111/selenium-server-doesnt-bind-to-socket-after-being-killed-with-sigterm
DAEMON_OPTS="-Djava.security.egd=file:/dev/./urandom $DAEMON_OPTS"

# The value for DISPLAY must match that used by the running instance of Xvfb.
export DISPLAY=:10

# Make sure that the PATH includes the location of the ChromeDriver binary.
# This is necessary for tests with Chromium to work.
export PATH=$PATH:/usr/local/bin

case "$1" in
    start)
        echo "Starting $DESC: "
        start-stop-daemon -c $USER --start --background \
            --pidfile $PID_FILE --make-pidfile --exec $JAVA -- $DAEMON_OPTS
        ;;

    stop)
        echo  "Stopping $DESC: "
        start-stop-daemon --stop --pidfile $PID_FILE
        ;;

    restart)
        echo "Restarting $DESC: "
        start-stop-daemon --stop --pidfile $PID_FILE
        sleep 1
        start-stop-daemon -c $USER --start --background \
            --pidfile $PID_FILE  --make-pidfile --exec $JAVA -- $DAEMON_OPTS
        ;;

    *)
        echo "Usage: /etc/init.d/selenium-standalone {start|stop|restart}"
        exit 1
    ;;
esac

exit 0