#!/usr/bin/env bash

# https://gist.github.com/sudara/8653130
# This monit wrapper script will be called by monit as root
# Edit these variables to your liking

RAILS_ENV=production
USER=deployer
APP_DIR=/home/deployer/applications/bets_accounting/current
PUMA_CONFIG_FILE=$APP_DIR/config/puma.rb
PUMA_PID_FILE=$APP_DIR/tmp/pids/puma.pid
PUMA_SOCKET=$APP_DIR/tmp/sockets/puma.sock

# check if puma process is running
puma_is_running() {
  if [ -S $PUMA_SOCKET ] ; then
    if [ -e $PUMA_PID_FILE ] ; then
      if cat $PUMA_PID_FILE | xargs pgrep -P > /dev/null ; then
        return 0
      else
        echo "No puma process found"
      fi
    else
      echo "No puma pid file found"
    fi
  else
    echo "No puma socket found"
  fi

  return 1
}

case "$1" in
  start)
    echo "Starting puma..."
    rm -f $PUMA_SOCKET

    if [ -e $PUMA_CONFIG_FILE ] ; then
      echo "cd $APP_DIR && RAILS_ENV=$RAILS_ENV bundle exec puma -C $PUMA_CONFIG_FILE"
      /bin/su - $USER -c "cd $APP_DIR && RAILS_ENV=$RAILS_ENV bundle exec puma -C $PUMA_CONFIG_FILE"
    else
      echo "No config file found"
      /bin/su - $USER -c "cd $APP_DIR && RAILS_ENV=$RAILS_ENV bundle exec puma --daemon --bind unix://$PUMA_SOCKET --pidfile $PUMA_PID_FILE"
    fi

    echo "done"
    ;;

  stop)
    echo "Stopping puma..."
      kill -s SIGTERM `cat $PUMA_PID_FILE`
      rm -f $PUMA_PID_FILE
      rm -f $PUMA_SOCKET

    echo "done"
    ;;

  restart)
    if puma_is_running ; then
      echo "Hot-restarting puma..."
      kill -s SIGUSR2 `cat $PUMA_PID_FILE`

      echo "Doublechecking the process restart..."
      sleep 15
      if puma_is_running ; then
        echo "done"
        exit 0
      else
        echo "Puma restart failed :/"
      fi
    fi
    ;;

  phased_restart)
    if puma_is_running ; then
      echo "Phased-restarting puma..."
      kill -s SIGUSR1 `cat $PUMA_PID_FILE`

      echo "Doublechecking the process restart..."
      sleep 10
      if puma_is_running ; then
        echo "done"
        exit 0
      else
        echo "Puma restart failed :/"
      fi
    fi
    ;;

  kill_worker*)
    if [ -z "$2" ];then
      logger -t "unicorn_${APP}" -s "kill_worker called with no worker identifier"
      exit 1
    fi
    PID_DIR=`dirname $PUMA_PID_FILE`
    kill -s QUIT `cat ${PID_DIR}/puma_worker_$2.pid`
    STATUS=$?
    exit $STATUS
    ;;

  *)
    echo "Usage: puma {start|stop|restart|kill_worker 0,1,2,etc}" >&2
    ;;
esac
