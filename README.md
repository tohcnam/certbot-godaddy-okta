# Certbot GoDaddy certificate renewal, and Okta deployment
These scripts allow the creation of Let's Encrypt certificates on GoDaddy managed domains, and automatical doployment to your Okta tenant. 

Check my blogpost about this here: [Okta: Automate certificate update on custom domains with Lets Encrypt and GoDaddy](https://www.ciam.ninja/post/okta-automate-certificate-update-on-custom-domains-with-lets-encrypt-and-godaddy)

## Usage
- Clone this github project
	- ```git clone https://github.com/tohcnam/certbot-godaddy-okta.git && cd certbot-godaddy-okta```
- Enter you [GoDaddy API](https://developer.godaddy.com/keys), [Okta API](https://support.okta.com/help/s/article/How-do-I-create-an-API-token?language=en_US) and domain information in the certbot-settings.sh file
- Modify the permissions of the certbot-settings.sh file so only the user running the cronjob is able to read it
	- ```chown root:root ./certbot-settings.sh```
	- ```chmod 700 ./certbot-settings.sh```
- Make the file executable
	- ```chmod +x ./certbot-*```
- Request a new certificate by calling the certbot-run.sh script
	- ```sudo ./certbot-run.sh```
- Create a bi-weekly cronjob to automatically renew your certificate (will run on 15th and 30th of a month):
	- ```0 0 */15 * * /path/to/certbot-run.sh > /dev/null 2>&1```

Your new certificate should be stored in /etc/letsencrypt/live/[DOMAIN]/
