Clone under ~/dev and add the following line to your ~./bashrc or ~/.bash_profile

    export PATH=~/dev/acorn/bin:$PATH
    
Open a new Terminal and run

    -v
    
Output on my MacBook Pro on 18th Feb 2014 is

    OSX: 10.9.1
    Bash: 4.2.45
    Xcode: 5.0.2
    GCC: 4.2.1
    Homebrew: 0.9.5
    Apache: 2.2.24
    Safari: 7.0.1
    Chrome: 33.0.1750.70
    Firefox: 27.0.1
    SQLite: 3.7.13
    MySQL: 14.14
    Postgres: 9.3.2
    pgAdmin3: 1.18
    Git: 1.8.5.5
    SourceTree: 1.8.1
    DeltaWalker: 1.9.9.5
    TextMate: 2.0-alpha.9503
    Sublime Text: NA
    Java: 1.7.0_25
    Python: 2.7.6
    Node: 0.10.25
    Npm: 1.3.24
    CoffeeScript: 1.4.0
    Rbenv: 0.4.0
    Ruby: 2.1.0p0
    Rails: 4.0.2
    Gem: 2.2.1
    Bundler: 1.5.2
    Pry: 0.9.12.6

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

Feedback appreciated and essential