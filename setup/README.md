**how to install ghidra on ubuntu**

run:
	sudo apt update
	sudo apt install openjdk-21-jdk

goto: https://github.com/NationalSecurityAgency/ghidra/releases

and download the zipfile

run:
	unzip ghidra_version_PUBLIC.zip
	cd ghidra_version_PUBLIC
	./ghidraRun
	
if it asks for path run:
	readlink -f $(which java) | sed 's:/bin/java::'

and insert the path returned

if you are using bash create an alias like this:
	echo "alias ghidra='/path/to/your/ghidra_folder/ghidraRun'" >> ~/.bashrc

restart your shell:
	source ~/.bashrc

start ghidra by running:
	ghidra


