export PS1='\w [\D{%Y-%m-%d} \t]\n\u@\h [\#]>'

alias colortest='for i in $(seq 30 47); do echo -e "\033[${i}m This is color $i \033[0m"; done'
alias grep='grep --color'
alias ls='ls -F'
