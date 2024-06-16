# Use the official Jupyter scipy notebook image as the base image
FROM jupyter/scipy-notebook:python-3.10

# Install Java (required for PySpark and H2O)
USER root
RUN apt-get update && apt-get install -y openjdk-8-jdk

# Install PySpark and PySparkling with compatible versions
RUN pip install pyspark==3.1.2 
RUN pip install h2o-pysparkling-3.1

# Install other necessary Python packages
RUN pip install pandas==1.5.3 && \
    pip install numpy && \
    pip install scikit-learn && \
    pip install torch && \
    pip install mlflow && \
    pip install imbalanced-learn==0.8.0 && \
    pip install rdkit && \
    pip install h2o==3.34.0.3 \
    pip install duckdb


RUN pip install toree && \
    jupyter toree install --spark_home=$SPARK_HOME

# Set environment variables
ENV PYTHONPATH="${SPARK_HOME}/python/:${SPARK_HOME}/python/lib/py4j-0.10.9-src.zip"

# Copy any local files to the Docker image
# COPY ./train.parquet ./train.csv ./requirements.txt

# COPY ./captions_eng.srt /home/jovyan/work/

# # Set the default command to start Jupyter Notebook
CMD ["start-notebook.sh", "--NotebookApp.token='belka_kaggle'"]
