#Draft pull messages logs from RHEL into remote storage
#Amend by araihaydenlaguna https://thebengkelworks.net
#

#!/usr/bin/env bash


#install sshpass package from repo/Satellite
yum install sshpass -y


#make directory /home/users_sample/PM/`hostname`/log/
mkdir -p /home/users_sample/PM/`hostname`/log/


#touch /home/users_sample/PM/`hostname`/log/summary.txt
touch /home/users_sample/PM/`hostname`/log/summary.txt


#declare OUTPUT variable and redirect locations /home/users_sample/PM/`hostname`/log/summary.txt
OUTPUT=/home/users_sample/PM/`hostname`/log/summary.txt


#print output Log Summary from OUTPUT=/home/users_sample/PM/`hostname`/log/summary.txt
printf "Log Summary\n\n" > $OUTPUT


#print output summary of Error Total from OUTPUT=/home/users_sample/PM/`hostname`/log/summary.txt
printf "\nError Total :\n\n" >> $OUTPUT


#grep list of errors from /var/log/messages and redirect to OUTPUT
grep -o -i `error`	/var/log/messages | sort -- unique | wc -l >> $OUTPUT


#print Summary of Warning Total from OUTPUT=/home/users_sample/PM/`hostname`/log/summary.txt
printf "\nWarning Total :\n\n" >> $OUTPUT


#grep list of warning from /var/log/messages and redirect to OUTPUT
grep -o -i `warning`	/var/log/messages | sort --unique | wc -l >> $OUTPUT


#Duplicate copy /var/log/messages into /home/users_sample/PM/`hostname`/log/
cp /var/log/messages /home/users_sample/PM/`hostname`/log/


#Set chmod 775 permission recursively for /home/users_sample/PM/`hostname`/
chmod 775 -R /home/users_sample/PM/`hostname`/


#Rely on sshpass tool to declare text passsword and secure copy file from source directory to remote storage over network
sshpass -p `declare_users_sample_passwd` scp -r /home/users_sample/PM/`hostname`/ user_sample@ip_address_remote_storage:/target_directory 

