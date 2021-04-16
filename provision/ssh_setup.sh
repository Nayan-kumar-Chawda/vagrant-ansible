sudo sed -ibackup "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sudo sed -ibackup "s/ChallengeResponseAuthentication yes/ChallengeResponseAuthentication no/g" /etc/ssh/sshd_config
sudo systemctl restart sshd
echo "ssh configured to accept password based authentication"