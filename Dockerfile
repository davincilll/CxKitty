FROM im.myhk.fun/dockerproxy/library/python:3.11.2

ENV TZ="Asia/Shanghai"

# 安装必要组件
RUN pip install poetry && \
    apt-get update && \
    apt-get -y install libgl1-mesa-glx
#    pip install --upgrade pip setuptools

# 安装依赖
WORKDIR /app
COPY ["pyproject.toml", "poetry.lock", "/app/"]
RUN poetry config virtualenvs.in-project true && \
    poetry install

# 添加源文件
COPY . /app

ENTRYPOINT ["poetry", "run", "python3", "main.py"]