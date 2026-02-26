- Setup Hadoop (WSL or Ubuntu)
- Run the following steps:
    1. Create a directory in HDFS:
        ``` bash
        hdfs dfs -mkdir /input
        ```
        
        Upload:
        ``` bash
        hdfs dfs -put in.csv /input/
        ```
    2. Create and edit the Java file:
       ```bash
       nano CustomerData.java
       ```
       Paste `CustomerData.java` code there.

    3. Remove previous output (if any):
       ```bash
       hdfs dfs -rm -r /output_r
       ```

    4. Compile the Java program:
       ```bash
       javac -classpath `hadoop classpath` CustomerData.java
       ```

    5. Create a JAR file:
       ```bash
       jar cf customerData.jar CustomerData*.class
       ```

    6. Run the Hadoop job:
       ```bash
       hadoop jar customerData.jar CustomerData /input/in.csv /output
       ```

    7. View the output:
       ```bash
       hdfs dfs -cat /output/part-r-00000
       ```
