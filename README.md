Why To Use This
===============

This repository is a starting point for developers containing proper routes and mime types for /css, /js, and /images in static.lisp. The static.lisp file is loaded at the end of init.lisp.


Linux Sysadmin Notes
====================

Hunchentoot requires a TTY in order to work. This makes it tricky to create a boot daemon on the server. I solved this issue by installing screen and sudo.

For operating systems that make use of systemd, create a file:
```
/etc/systemd/system/PROJECT.service
```

Fill it with the following. Note that I use zsh - if you use something else, adapt this accordingly.
```
[Unit]
Description=Hunchentoot server for PROJECT-DOMAIN
After=haproxy.service

[Service]
ExecStart=/bin/sudo -u USER-NAME screen -dmS PROJECT-NAME zsh -c "source ~/.zshrc; cd PATH/TO/HUNCHENTOOT/DIRECTORY; sbcl --load init.lisp; exec zsh"
ExecStop=/root/stop-hunchentoot-server PROJECT-NAME
Type=forking
GuessMainPID=no

[Install]
WantedBy=multi-user.target
```

Note that ExecStop calls the shell script /root/stop-hunchentoot-server:
```shell
#!/usr/bin/zsh

screen_pid=`ps aux | grep $1 | grep SCREEN | awk '{print $2}'`
kill $screen_pid
```

You may also need to comment out the following line in /etc/sudoers using the visudo command:
```conf
Defaults   requiretty
```

Enable the service:
```shell
systemctl enable PROJECT.service
```

Now when you boot your server, your site should boot along with it. I also add the following to my user's shellrc:
```shell
alias PROJECT-NAME="screen -S PROJECT-NAME"
alias rePROJECT-NAME="screen -r PROJECT-NAME"
```

To access the running server's REPL, type rePROJECT-NAME, and screen will open up in it's running state. To leave the screen session without logging out, type Ctrl + A then Ctrl + D. If a session is not currently running and you would like a new one, type PROJECT-NAME to open up a new screen session, cd into the hunchentoot directory, and run:
```shell
sbcl --load init.lisp
```

To install SBCL on CentOS:
```shell
yum install epel-release
yum install sbcl
```