#!/usr/bin/env bash

# Make sure you `chmod +x puma.sh`.

# PUMA_CONFIG_FILE=config/puma.rb # if needed
PUMA_PID_FILE=tmp/pids/abdennouralem.pid
PUMA_SOCKET=tmp/socks/abdennouralem.sock

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
    echo "Starting nginx..."
    sudo rm /etc/nginx/sites-enbaled/abdennouralem.conf
    sudo ln -sf /etc/nginx/sites-available/abdennouralem.conf /etc/nginx/sites-enabled/abdennouralem.conf
    sudo service nginx restart

    echo "Starting puma..."
    sudo rm -f $PUMA_SOCKET
    #   sudo puma --config $PUMA_CONFIG_FILE #if there is a puma.rb config file
      sudo puma --daemon --bind unix://$PUMA_SOCKET --pidfile $PUMA_PID_FILE

      sudo sass --watch public/scss/:public/css/

    echo "done"
    ;;

  stop)
    echo "Stopping puma..."
      sudo kill -s SIGTERM `cat $PUMA_PID_FILE`
      sudo rm -f $PUMA_PID_FILE
      sudo rm -f $PUMA_SOCKET

    echo "done"
    ;;

  restart)
    if puma_is_running ; then
      echo "Hot-restarting puma..."
      sudo kill -s SIGUSR2 `cat $PUMA_PID_FILE`

      echo "Doublechecking the process restart..."
      sleep 5
      if puma_is_running ; then
        echo "done"
        exit 0
      else
        echo "Puma restart failed :/"
      fi
    fi

    echo "Trying cold reboot"
    ./puma.sh start
    ;;

  *)
    echo "Usage: script/puma.sh {start|stop|restart}" >&2
    ;;
esac
