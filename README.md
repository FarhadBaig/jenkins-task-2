# Jenkins Task-2: GitHub and Jenkins Automation

## Project Overview
This project demonstrates Continuous Integration (CI) using GitHub and Jenkins. Whenever code is pushed to GitHub, a webhook triggers Jenkins to execute a shell script and generate build output. Email notifications are configured to report build results.

## Objectives
- Create a shell script and push it to GitHub.
- Configure a Jenkins Freestyle project.
- Integrate GitHub with Jenkins using a webhook.
- Trigger automatic builds whenever code is pushed.
- Configure email notifications for build results.

## Technologies Used
- AWS EC2
- Ubuntu Linux
- Jenkins
- Git and GitHub
- Bash scripting
- Gmail SMTP

## Architecture
Developer -> GitHub Repository -> GitHub Webhook -> Jenkins on EC2 -> Execute build.sh -> Console Output and Email Notification

## Repository Structure
    jenkins-task-2/
    ├── build.sh
    ├── README.md
    └── screenshots/

## Build Script
The `build.sh` script displays basic system information and confirms that the Jenkins build script has executed.

Run the script manually:

    chmod +x build.sh
    ./build.sh

## Jenkins Configuration
1. Create a Freestyle project in Jenkins.
2. Under Source Code Management, select Git.
3. Enter the GitHub repository URL.
4. Set the branch to `*/main`.
5. Under Build Steps, select Execute shell.
6. Add these commands:

       chmod +x build.sh
       ./build.sh

7. Save the configuration and select Build Now.
8. Check Console Output to verify the build.

## GitHub Webhook Configuration
1. Open the GitHub repository.
2. Go to Settings -> Webhooks -> Add webhook.
3. Set the payload URL to:

       http://YOUR_JENKINS_PUBLIC_IP:8080/github-webhook/

4. Set Content type to `application/json`.
5. Select Just the push event.
6. Enable the webhook.
7. In Jenkins job configuration, enable GitHub hook trigger for GITScm polling.
8. Commit and push a change to verify automatic triggering.

Replace `YOUR_JENKINS_PUBLIC_IP` with your Jenkins server's reachable public IP or hostname.

## Email Notification Configuration

### Gmail SMTP Settings

    SMTP server: smtp.gmail.com
    SMTP port: 465
    SSL: Enabled
    TLS: Disabled when using SSL on port 465
    Username: Your full Gmail address
    Password: Google App Password

1. Enable Google 2-Step Verification if required.
2. Generate a Google App Password if your account supports it.
3. In Jenkins, open Manage Jenkins -> System.
4. Configure Extended E-mail Notification.
5. Configure E-mail Notification as well if the standard Jenkins Mailer is used.
6. Store SMTP credentials securely in Jenkins.
7. In the job configuration, add Editable Email Notification under Post-build Actions.
8. Set the recipient address and add an Always trigger if every build should send an email.
9. Save and test the configuration.

### Example Email Subject

    Jenkins Build - $PROJECT_NAME - $BUILD_STATUS

### Example Email Body

    Hello,

    Jenkins has completed a build.

    Project: $PROJECT_NAME
    Build Number: $BUILD_NUMBER
    Build Status: $BUILD_STATUS
    Build URL: $BUILD_URL

    Please check Jenkins Console Output for details.

## SMTP Troubleshooting
If Jenkins reports a timeout connecting to `smtp.gmail.com` on port 25, check the SMTP port in both E-mail Notification and Extended E-mail Notification.

For Gmail SSL, use port 465 with SSL enabled. A timeout may also indicate outbound SMTP traffic is blocked by the cloud network or provider.

Test connectivity from the EC2 instance:

    nc -vz -w 10 smtp.gmail.com 465

If `nc` is unavailable:

    timeout 10 bash -c '</dev/tcp/smtp.gmail.com/465' && echo "SMTP port reachable" || echo "SMTP connection failed"

A successful network test does not guarantee SMTP authentication or email delivery; check Jenkins logs and test-email results.

## Validation Checklist
- [ ] Build script runs successfully.
- [ ] Jenkins checks out the GitHub repository.
- [ ] Manual Jenkins build succeeds.
- [ ] Console Output shows the expected script output.
- [ ] GitHub push triggers Jenkins automatically.
- [ ] SMTP test email succeeds.
- [ ] Build notification is received.
- [ ] Screenshots document the actual completed setup.

## Suggested Screenshots
1. EC2 instance details.
2. Jenkins dashboard and job.
3. GitHub repository.
4. Successful Jenkins Console Output.
5. GitHub webhook configuration and delivery status.
6. Received email notification.

Only include screenshots of results you have actually verified.

## Security Notes
- Never commit App Passwords, GitHub tokens, or AWS access keys.
- Store SMTP passwords in Jenkins Credentials.
- Do not include secrets in screenshots.
- Restrict Jenkins network access and use HTTPS for production deployments.

## Conclusion
This project demonstrates GitHub source control, Jenkins build automation, webhook-triggered builds, and email notification configuration. Confirm each item in the validation checklist before reporting it as completed.
