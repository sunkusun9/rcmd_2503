# rcmd_2503

# 기본 환경 구성

Windows 10 / WSL Ubuntu(24.04) / Python 3.12.9

Window에서 가상 환경으로 Ubuntu를 구동 시켜서 진행합니다. 

순수한 Linux 환경이 사용이 어려우실 수 있어 WSL로 구성했습니다. 

동일 장비에서 테스트해본 결과 순수 Linux 환경과 WSL의 성능 차이는 약 5배 정도 차이납니다. 

여러 가지 실험을 이어 나가시고자 한다면, 순수 Linux 장비 구성을 강력히 권합니다.

순수 Linux는 Ubuntu를 사용한다면, 아래 방법과 크게 차이나지 않습니다.

## NVIDIA 드라이브 업데이트

- NVIDIA 장비 확인
시스템 > 정보 > 고급 시스템 설정

- NVIDIA 드라이버 업데이트


강의장 PC 기준

https://www.nvidia.com/ko-kr/drivers/details/241094/

설치 파일 다운로드 

실행 > NVIDIA 그래픽 드라이버 > 빠른 설치

## WSL 설치

커맨드창을 구동 시킵니다.

```cmd
wsl --install --distribution Ubuntu
```

.wslconfig 파일을 /user/student 폴더에 만듭니다.
```
# Settings apply across all Linux distros running on WSL 2
[wsl2]

# Limits VM memory to use no more than 24 GB, this can be set as whole numbers using GB or MB
memory=24GB 

# Sets the VM to use 6 virtual processors
processors=6

# Sets amount of swap storage space to 24GB, default is 25% of available RAM
swap=24GB
```

WSL 구동

```cmd
wsl -d Ubuntu
```
user account: rcmd/rcmd2025

```bash
sudo apt update
sudo apt full-upgrade -y
```

CPU와 메모리 현황을 봅니다.
```
lscpu
free -h
```

## Python 3.12.9 설치

- Linux 업데이트 확인
- Linux 소프트웨어 개발 공용 도구 설치
- Linux 빌드 도구 설치
- Python 내부 구성 모듈 설치
```bash
sudo apt install software-properties-common
sudo apt install build-essential
sudo apt install gdb lcov pkg-config zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev libgdbm-compat-dev liblzma-dev libreadline6-dev tk-dev uuid-dev
```

- Python 소스 코드 설치
- 압축해제
- Python 소스 경로로 디렉커리 이동
- 빌드 설정
- 빌드
- 설치: Linux에서는 Python이 설치가 되어 있습니다. Linux는 시스템 운영 프로그램에서 Python을 사용하므로 기본 Python을 교체해서는 안됩니다. altinstall로 설치합니다. 
```
wget https://www.python.org/ftp/python/3.12.9/Python-3.12.9.tar.xz
tar -xvf Python-3.12.9.tar.xz
cd Python-3.12.9
./configure --enable-optimizations
make -j 4
sudo make altinstall
```
altinstall로 설치하면, /usr/local/bin에 python이 설치됩니다.
현재 버젼의 Python으로 가상환경을 구성하여 사용하겠습니다.

- Home 디렉터리로 이동
- Python3.12.9 가상환경 생성
- Python3.12.9 가상환경 진입
- Python 모듈 관리 프로그램 업그레이드
```
cd~
/usr/local/bin/python3.12 -m venv python312
source python312/bin/activate
pip install --upgrade pip
pip install --upgrade jupyterlab
```

[데이터셋 & 모델](https://drive.google.com/drive/folders/1B2MWhhEjf1HChP85n9mp8Bp-UvqdvLLA)
