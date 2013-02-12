Clone under ~/dev and add the following line to your ~./bashrc or ~/.bash_profile

    export PATH=~/dev/scripts/bin:$PATH
    
Open a new Terminal and run

    -v
    
Output on my MacBook Pro Retina on 12th Feb 2013 is

    OSX: 10.8.2
    Xcode: 4.6
    GCC: 4.2.1
    Bash: 3.2.48
    Ruby: 1.8.7-p358
    Homebrew: 0.9.4
    Git: 1.8.1.3
    MongoDB: 2.2.3
    Node: 0.8.19
    Npm: 1.2.10
    CoffeeScript: 1.4.0
    SourceTree: 1.5.7.1
    TextMate: 1.5.11
    Sublime Text: 2.0.1
    Java: 1.6.0_37
    Python: 2.7.2
    Chrome: 24.0.1312.57
    Firefox: 18.0.2
    Safari: 6.0.2

See [Mac OS X Setup](https://github.com/Bizzby/bizzby/wiki/Mac-OS-X-Setup) for how to get here from a new Mac.

In the env directory there's an example of how to set up ~/.bash_profile and ~/.bashrc to give helpful, coloured prompts in the Mac Terminal, showing the current directory, current Git branch, whether there are outstanding changes to commit and whether there are commits to push to or pull from GitHub (or any other remote repository). Copy the relevant lines into your existing startup files. 

One is told that .bashrc is for general environment variables for any process forked from Bash, .bash_profile for terminal-related stuff, including aliases. I've given some examples of aliases I use with Git but these are very much a matter of taste. Copy anything you fancy but the following lines are essential to get the fancy prompt working without breaking Terminal's nice habit of taking you to the same directory as current on hitting apple-t (a feature that is broken by many open source attempts to set the prompt).

    . ~/.bashrc
    . $env/bash_prompt.sh
    # from /etc/bashrc
    shopt -s checkwinsize
    if [ "$TERM_PROGRAM" == "Apple_Terminal" ] && [ -z "$INSIDE_EMACS" ]; then
      update_terminal_cwd() {
        local SEARCH=' '
        local REPLACE='%20'
        local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
        printf '\e]7;%s\a' "$PWD_URL"
      }
      PROMPT_COMMAND="update_terminal_cwd; $PROMPT_COMMAND"
    fi

Feedback appreciated and essential :)