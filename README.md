# Certbot GoDaddy certificate renewal, and Okta deployment
These scripts allow the creation of Let's Encrypt certificates on GoDaddy managed domains, and automatical doployment to your Okta tenant. 

Note: This script requires that the domain API is enabled on your Okta tenant  
```Settings -> Features -> Public API for Custom Domains -> Enable```

## Usage
- Clone this github project
	- ```git clone https://github.com/tohcnam/certbot-godaddy-okta.git && cd certbot-godaddy-okta```
- Enter you [GoDaddy API](https://developer.godaddy.com/keys), [Okta API](https://support.okta.com/help/s/article/How-do-I-create-an-API-token?language=en_US) and domain information in the certbot-settings.sh file
- Modify the permissions of the certbot-settings.sh file so only the user running the cronjob is able to read it
	- ```chown root:root ./certbot-settings.sh```
	- ```chmod 700 ./certbot/api-settings.sh```
- Make the file executable
	- ```chmod +x ./certbot-*```
- Request a new certificate by calling the certbot-run.sh script
	- ```sudo ./certbot-run.sh```
- Create a weekly cronjob to automatically renew your certificate:
	- ```0 0 * * 0 /path/to/certbot-run.sh > /dev/null 2>&1```

Your new certificate should be stored in /etc/letsencrypt/live/[DOMAIN]/
