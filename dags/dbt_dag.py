import os
from datetime import datetime

from cosmos import DbtDag, ProjectConfig, ProfileConfig, ExecutionConfig, RenderConfig
from cosmos.constants import LoadMode
from cosmos.profiles import SnowflakeUserPasswordProfileMapping


profile_config = ProfileConfig(
    profile_name="default",
    target_name="dev",
    profile_mapping=SnowflakeUserPasswordProfileMapping(
        conn_id="snowflake_conn",
        profile_args={"database": "dbt_db", "schema": "dbt_schema", "warehouse": "dbt_wh"},
    )
)

dbt_snowflake_dag = DbtDag(
    project_config=ProjectConfig(
        "/usr/local/airflow/dags/dbt/mydata_pipeline",
        manifest_path="/usr/local/airflow/dags/dbt/mydata_pipeline/target/manifest.json",
    ),
    render_config=RenderConfig(load_method=LoadMode.DBT_MANIFEST),
    operator_args={"install_deps": True},
    profile_config=profile_config,
    execution_config=ExecutionConfig(dbt_executable_path=f"{os.environ['AIRFLOW_HOME']}/dbt_venv/bin/dbt",),
    schedule="@daily",
    start_date=datetime(2023, 9, 10),
    catchup=False,
    dag_id="dbt_dag",
)