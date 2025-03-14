# Update system and install Python, pip, git, and AWS CLI
sudo apt update -y
sudo apt install -y python3 python3-pip git awscli

# Create deployment directory and give access to 'ubuntu' user
sudo mkdir -p /var/www/html
sudo chown ubuntu:ubuntu /var/www/html

# Optional: Verify python and pip are installed
python3 --version
pip3 --version

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y  # Install unzip if not already installed
unzip awscliv2.zip
sudo ./aws/install
aws --version


ubuntu@ip-172-31-23-35:~$ curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 2246k  100 2246k    0     0  16.6M      0 --:--:-- --:--:-- --:--:-- 16.7M
ubuntu@ip-172-31-23-35:~$ sudo python3 get-pip.py
Collecting pip
  Downloading pip-25.0.1-py3-none-any.whl.metadata (3.7 kB)
Collecting wheel
  Downloading wheel-0.45.1-py3-none-any.whl.metadata (2.3 kB)
Downloading pip-25.0.1-py3-none-any.whl (1.8 MB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 1.8/1.8 MB 59.9 MB/s eta 0:00:00
Downloading wheel-0.45.1-py3-none-any.whl (72 kB)
Installing collected packages: wheel, pip
Successfully installed pip-25.0.1 wheel-0.45.1
WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager, possibly rendering your system unusable. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv. Use the --root-user-action option if you know what you are doing and want to suppress this warning.
ubuntu@ip-172-31-23-35:~$ python3 --version
Python 3.10.12
ubuntu@ip-172-31-23-35:~$
