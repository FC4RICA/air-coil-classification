FROM  pytorch/pytorch:2.1.2-cuda11.8-cudnn8-devel

RUN apt-get update -y

WORKDIR /code

RUN pip install --upgrade pip
COPY ./requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Load modle weight for air coil classification model
RUN pip install gdown && \
    gdown "https://drive.google.com/uc?id=1W7O3aB4IQ6feYyW6LKtRy2b6KN5Dyn5f" -O /code/bd_eva02_1_acc=0.77.ckpt

COPY ./app /code/app
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]
