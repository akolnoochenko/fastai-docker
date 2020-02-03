#!/usr/bin/env python3
import pathlib
from os import path
import os
from shutil import copyfile
import sys
from subprocess import call
user_name = sys.argv[1]
my_env = os.environ.copy()
my_env['TEMP'] = '/notebooks/tmp'
src_config_path = '/root/.fastai/jupyter_notebook_config.py'
jupyter_path = path.expanduser('~{}/.jupyter'.format(user_name))
dst_config_path = path.join(jupyter_path, path.basename(src_config_path))
pathlib.Path(jupyter_path).mkdir(parents=True, exist_ok=True)
call(['chown', '-R', user_name, path.expanduser('~{}'.format(user_name))])
copyfile(src_config_path, dst_config_path)
pathlib.Path(my_env['TEMP']).mkdir(parents=True, exist_ok=True)
call(['git', 'pull'], cwd='/notebooks/course-v3')
call(['conda', 'update', 'conda'])
call(['conda', 'install', '-c', 'fastai', 'fastai'])
call(['chown', '-R', user_name, '/notebooks'])

internals = [('/storage/.fastai', path.expanduser('~{}/.fastai'.format(user_name)) ), ('/storage/.torch', path.expanduser('~{}/.torch'.format(user_name)))]
for storage_path, symlink_path in internals:
    if not path.exists(storage_path):
        pathlib.Path(storage_path).mkdir(parents=True, exist_ok=True)
    call(['ln', '-s', storage_path, symlink_path])
    call(['chown', user_name, symlink_path])

call(['chown', '-R', user_name, '/storage'])
call(['ln', '-s', '/storage', '/notebooks/course-v3/nbs/dl1/data'])

call(['bash', '-c', 'source activate fastai && su -c "/opt/conda/envs/fastai/bin/jupyter notebook" {}'.format(user_name)], env=my_env)
