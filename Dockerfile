FROM astrocrpublic.azurecr.io/runtime:3.2-4

RUN python -m venv /usr/local/airflow/dbt_venv && \
    /usr/local/airflow/dbt_venv/bin/pip install "dbt-core==1.9.0" "dbt-snowflake==1.9.0"
