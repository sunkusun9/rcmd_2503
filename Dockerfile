# Ubuntu 24.04 기반 이미지 사용
FROM ubuntu:24.04

# 기본 패키지 업데이트 및 필요한 패키지 설치
RUN apt update && apt full-upgrade -y && \
    apt install -y software-properties-common && \
    apt install -y build-essential && \
    apt install -y gdb lcov pkg-config zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev libgdbm-compat-dev liblzma-dev libreadline6-dev tk-dev uuid-dev

RUN  wget https://www.python.org/ftp/python/3.12.9/Python-3.12.9.tar.xz && \
    tar -xvf Python-3.12.9.tar.xz && \
    cd Python-3.12.9 && \
    ./configure --enable-optimizations && \
    make -j 4 && \
    make install && \
    apt-get clean

# Python3.12 기본 링크로 설정
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 1

# pip 최신 버전으로 업데이트
RUN python3 -m pip install --upgrade pip

# JupyterLab 설치
RUN pip install jupyterlab


# 로컬 디렉토리의 파일을 Docker 이미지에 복사
# 여기서 <your-local-path>는 로컬 경로로 대체하고, /app은 컨테이너 내부 경로입니다.
# COPY <your-local-path> /app

RUN mkdir -p /app
COPY requirements.txt /app

# 작업 디렉토리 설정
WORKDIR /app
RUN pip install -r requirements.txt


# JupyterLab 포트 8888 열기
EXPOSE 8888

# JupyterLab 실행 명령어
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser", "--port=8888"]