#!/bin/bash
#ec2.txt file should have the ip of instance

for ip in $(cat ec2.txt); do
echo "action on: $ip"
ins_id="$(aws ec2 describe-instances --filter Name=ip-address,Values=$ip --profile xxxxxxx --region xxxxx --query 'Reservations[*].Instances[*].[InstanceId]' --output=text)"
	echo "$ins_id"

aws ec2 stop-instances --instance-ids $insid --profile xxxxxxx --region xxxxxx --dry-run

sleep 120

#update the type from micro to small

aws ec2 modify-instance-attribute  --instance-ids $insid --instance-type  "{\"Value\": \"t2.small\"}" --profile xxxxxxxx --region xxxxxx --dry-run

echo "starting server"
aws ec2 start-instances --instance-ids $insid --profile xxxxxxxxx --region xxxxxxxx --dry-run
sleep 90;

newip="$(aws ec2 describe-instances --instance-ids $insid --profile xxxxxxx --region xxxxxxx | grep -m 1 PublicIp | awk '{print $2}')"
echo " new ip of instance $i is : $newip " >>/tmp/output.txt

echo " *************************************************************************** "
echo " new ip of instance $i is : $newip "
echo " **************************************************************************** "
done

cat /tmp/output.txt
