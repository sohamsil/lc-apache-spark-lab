FROM python:3.13.3-slim AS builder

# Add Dependencies for PySpark
RUN apt-get update && apt-get install -y --no-install-recommends \
sudo wget curl vim unzip rsync default-jre \
build-essential software-properties-common ssh && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

# Add environment variables for Spark setup
ENV SPARK_VERSION=3.5.5 \
HADOOP_VERSION=3 \
SPARK_HOME=/opt/spark \
PYTHONHASHSEED=1

# Download and uncompress Spark
RUN wget --no-verbose -O apache-spark.tgz "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" \
&& mkdir -p ${SPARK_HOME} \
&& tar -xf apache-spark.tgz -C ${SPARK_HOME} --strip-components=1 \
&& rm apache-spark.tgz

# Setup Spark Environment
FROM builder AS apache-spark

WORKDIR ${SPARK_HOME}

# Install Python dependencies
COPY requirements/requirements.txt .
RUN pip3 install -r requirements.txt

ENV PATH="/opt/spark/sbin:/opt/spark/bin:${PATH}" \ 
SPARK_MASTER_PORT=7077 \
SPARK_MASTER_WEBUI_PORT=8080 \
SPARK_WORKER_WEBUI_PORT=8080 \
SPARK_LOG_DIR=${SPARK_HOME}/logs \
SPARK_MASTER_LOG=${SPARK_HOME}/logs/spark-master.out \
SPARK_WORKER_LOG=${SPARK_HOME}/logs/spark-worker.out \
SPARK_MASTER="spark://spark-master:7077" \
PYSPARK_PYTHON=python3

# Copy default configurations in to 
COPY conf/spark-defaults.conf "${SPARK_HOME}/conf"

RUN chmod u+x /opt/spark/sbin/* && \
    chmod u+x /opt/spark/bin/*

ENV PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH

# Create Log directories and file   
RUN mkdir -p ${SPARK_LOG_DIR} && \
touch ${SPARK_MASTER_LOG} &&\
touch ${SPARK_WORKER_LOG} &&\
ln -sf /dev/stdout ${SPARK_MASTER_LOG} &&\
ln -sf /dev/stdout ${SPARK_WORKER_LOG}

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]