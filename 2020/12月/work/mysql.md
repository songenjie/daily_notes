This happened after the homebrew install and occurs due to permission issues. The following commands fixed the issue.

    sudo chown -R _mysql:mysql /usr/local/var/mysql
    
    sudo mysql.server start
