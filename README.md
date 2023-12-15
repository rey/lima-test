# lima-test

I'm testing [Lima](https://lima-vm.io) as a replacement for [Vagrant](https://www.vagrantup.com) × [VirtualBox](https://www.virtualbox.org) since switching to a Mac with Apple Silicon.

My use case is to spin up a disposable virtual machine running a flavour of Linux that is mounted to the directory from which it is run.

The script is built upon the following command (which took a bit of trial and error to put together):

```
limactl start --name=vm-for-cool-app --set='.mounts[0].location="/Users/rey/Sites/cool-app",.mounts[0].writable="true"' --vm-type=vz --mount-type=9p --tty=false
```

## Usage

1. Install Lima: `brew install lima`
2. Drop `start.bash` into a directory
3. `bash start.bash`
4. `limactl shell <your-directory-name>`

## Notes

* Lima doesn't seem to support names that have spaces in them so the script will fail if the directory it's run from has a space in the name.
```
FATA[0000] identifier "outer space" must match ^[A-Za-z0-9]+(?:[._-](?:[A-Za-z0-9]+))*$: invalid argument
```