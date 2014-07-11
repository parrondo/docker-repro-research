#!/usr/bin/env python

import os
import sys
import subprocess

with open('data_mounts.txt', 'r') as fp:
    data_mounts = fp.readlines()

data_mounts = [data_mount.strip() for data_mount in data_mounts]
valid_data_mounts = filter(os.path.isdir, data_mounts)
env_variable_mounts = [os.environ.get(var, '') for var in data_mounts]
valid_data_mounts.extend(filter(os.path.isdir, env_variable_mounts))

mount_args = ['%s:%s' % (mount, mount) for mount in valid_data_mounts]

cmd = ['docker', 'run',
        '-i', '-t',
        '--env', 'DEV_SRC=%s/src' % os.environ['HOME']]
for mount_arg in mount_args:
    cmd.append('-v')
    cmd.append(mount_arg)
cmd.append('invenshure/science')
cmd.extend(['/bin/bash', '-c'])

docker_cmd_string = '/usr/local/bin/source_install.sh && '
for arg in sys.argv[1:]:
    docker_cmd_string += '%s ' % arg

cmd.append(docker_cmd_string)

print ' '.join(cmd)

subprocess.call(cmd)
