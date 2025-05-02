# 🚀 Lumos Code Apache Spark Lab

This repository provides a Docker-based setup for running an Apache Spark cluster with a master node, worker nodes, and a history server. It is designed for learning and experimenting with Apache Spark and Delta Lake.

## ✨ Features

- Apache Spark 3.5.5 with Hadoop 3
- Spark Master, Worker, and History Server containers
- Configurable worker scaling
- Persistent event logs for Spark History Server
- Python dependencies managed via requirements.txt
- **Jupyter Lab** for interactive development
- **Delta Lake** support for ACID transactions and scalable metadata handling

## 🗂️ Repository Structure
- **.env.spark** : Environment variables for Spark 
- **docker-compose.yml** : Docker Compose configuration 
- **Dockerfile** : Docker image definition 
- **entrypoint.sh** : Entrypoint script for Spark containers 
- **Makefile** : Makefile for common tasks 
- **apps/** : Directory for Spark applications 
- **conf/** : Spark configuration files 
- **data/** : Directory for input/output data
- **notebooks/** : Jupyter notebooks for interactive development 
- **requirements/requirements.txt** : Python dependencies

## ⚙️ Prerequisites
- Docker
- Docker Compose
- Make

## 📚 How-To:

**✅ Build the Docker image**:

`make build`

**✅ Start the Spark cluster:**

`make run-spark-cluster worker_count=2`

*This will start the Spark Master, two Spark Workers, and the History Server*

**✅ Access the Spark Web UIs:**
- Spark Master: http://localhost:9090
- Spark History Server: http://localhost:18080

**✅ Running Spark Applications:**

*Place your Spark applications in the apps directory and run the following `make` command*

`make submit app=square-numbers.py`

**✅ Start the Jupyter Lab:**

`make run-jupyter`

*This will start a single node Spark container with Jupyter Lab enabled*

**✅ Access the Jupyter Lab UI:**
- Jupyter Lab: [http://localhost:8888](http://localhost:8888)

**✅ Stop the cluster:**

`make stop`

**✅ Clean up resources:**

`make down`


## ⚙️ Configuration
- **Environment Variables** Defined in .env.spark.
- **Spark Defaults**: Configured in spark-defaults.conf.


## 🧠 Author
- **Name**: Soham Sil 
- **LinkedIn**: linkedin.com/in/soham-sil-048127b8 
- **Email**: sil.soham@gmail.com