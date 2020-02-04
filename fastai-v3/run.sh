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
call(['ln', '-s', f'/storage/{user_name}', path.expanduser('~' + user_name)])
jupyter_path = path.expanduser('~{}/.jupyter'.format(user_name))
dst_config_path = path.join(jupyter_path, path.basename(src_config_path))
pathlib.Path(jupyter_path).mkdir(parents=True, exist_ok=True)
copyfile(src_config_path, dst_config_path)
call(['git', 'pull'], cwd='/notebooks/course-v3')
call(['conda', 'update', 'conda'])
call(['conda', 'install', '-c', 'fastai', 'fastai'])
call(['chown', '-R', user_name, '/notebooks'])

pathlib.Path('/storage/work').mkdir(exist_ok=True)
call(['ln', '-s', '/storage/work', '/notebooks/course-v3/nbs/dl1/work'])
call(['chown', '-R', user_name, '/storage'])

call(['bash', '-c', 'source activate fastai && su -c "/opt/conda/envs/fastai/bin/jupyter notebook" {}'.format(user_name)], env=my_env)
