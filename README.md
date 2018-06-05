# NOTE

Hi there! I've moved this repo over to Sensu for it to be maintained there. You can now find this, along with other workshops at https://github.com/sensu/training-vagrant. 

## Prerequisites

*BEFORE* you proceed, ensure you've got [Virtualbox][1] and [Vagrant][2] downloaded.

## How to Use

1. Download the repo:

```shell
git clone https://github.com/asachs01/sensu-up-and-running.git && cd sensu-up-and-running
vagrant up
```

IP/Port will be provided as soon as Vagrant finishes provisioning the vm.

2. Access your Uchiwa dashboard at `$IP:3000`

3. SSH into your Vagrant instance and start poking around!

```shell
vagrant ssh
```

4. Take a look at the [Sensu Docs][3] for the quick version of what the install does.

_NOTE_: The Sensu 5 Minute Install uses Redis as a transport mechanism. While this works in a purely dev environment, _*DO NOT*_ use it in a production setting, or any systems that you care about. There's a bug that prevents it from fully working.

5. Wanna do more with Sensu? Head over the [repo wiki][4], where we'll walk through some of the Sensu basics.

6. For any additional guides, head over to the [Sensu Docs Site][5].

7. For any help, head to [Sensu's Community Slack Channel][6].

<!-- LINKS -->
[1]: https://www.virtualbox.org/wiki/Downloads
[2]: https://www.vagrantup.com/downloads.html
[3]: https://docs.sensu.io/sensu-core/latest/quick-start/five-minute-install/
[4]: https://github.com/asachs01/sensu-up-and-running/wiki
[5]: https://docs.sensu.io/sensu-core/latest/
[6]: https://slack.sensu.io
