import pandas as pd

hadoop = pd.read_csv("hadoop_output.txt", sep="\t", header=None, names=["id","value"])

pyspark = pd.read_csv("pyspark_output.csv", header=None, names=["id","value"])


hadoop["id"] = hadoop["id"].astype(int)
pyspark["id"] = pyspark["id"].astype(int)

hadoop = hadoop.sort_values("id")
pyspark = pyspark.sort_values("id")

merged = pd.merge(hadoop, pyspark, on="id", suffixes=("_hadoop","_pyspark"))

merged["same"] = merged["value_hadoop"] == merged["value_pyspark"]

print(merged)

print("Different rows:")
print(merged[merged["same"] == False])