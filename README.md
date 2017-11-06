### Prerequisites:
*BEFORE* you proceed, ensure you've got [Vagrant](vagrantup.com) downloaded.

### How to Use:
1. Download the repo:
```
git clone https://github.com/asachs01/sensu-up-and-running.git && cd sensu-up-and-running
vagrant up
```
IP/Port will provided as soon as Vagrant finishes provisioning the vm.

2. Access your Uchiwa dashboard at `$IP:3000`

3. SSH into your Vagrant instance and start poking around!
```
vagrant ssh
```

4. Take a look at the [Sensu Docs](https://sensuapp.org/docs/1.1/quick-start/the-five-minute-install.html) for the quick version of what the install does.

5. Wanna do more with Sensu? Head over the [repo wiki](https://github.com/asachs01/sensu-up-and-running/wiki), where we'll walk through some of the Sensu basics.
