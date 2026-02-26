- Setup Hadoop (WSL or Ubuntu)
- Run the following steps:

    1. Create and edit the Java file:
       ```bash
       nano CustomerData.java
       ```
       Paste your `CustomerData.java` code there.

    2. Remove previous output (if any):
       ```bash
       hdfs dfs -rm -r /output_r
       ```

    3. Compile the Java program:
       ```bash
       javac -classpath `hadoop classpath` CustomerData.java
       ```

    4. Create a JAR file:
       ```bash
       jar cf customerData.jar CustomerData*.class
       ```

    5. Run the Hadoop job:
       ```bash
       hadoop jar customerData.jar CustomerData /input/in.csv /output
       ```

    6. View the output:
       ```bash
       hdfs dfs -cat /output/part-r-00000
       ```