#rsync -auvi -n testsystem/* ubuntuui:testsystem/ | grep "<f.st"

rsync -auvi testsystem/* student@192.168.163.12:./testsystem | grep "<f.st"