<?xml version="1.0" encoding="UTF-8"?>
<!--
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to you under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
-->
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">

    <parent>
        <groupId>org.apache.myfaces</groupId>
        <artifactId>myfaces</artifactId>
        <version>14</version>
    </parent>

    <modelVersion>4.0.0</modelVersion>

    <groupId>org.apache.myfaces.core</groupId>
    <artifactId>myfaces-core-module</artifactId>
    <packaging>pom</packaging>
    <name>Apache MyFaces JSF-2.1 Core Module</name>
    <description>
        This project is the home of the MyFaces implementation of the JavaServer Faces 2.1 specification, and
        consists of an API module (javax.faces.* classes) and an implementation module (org.apache.myfaces.* classes).
    </description>
    <version>2.1.10</version>
    <url>http://myfaces.apache.org/core21</url>

    <issueManagement>
        <system>jira</system>
        <url>https://issues.apache.org/jira/browse/MYFACES</url>
    </issueManagement>

    <scm>
        <connection>scm:svn:http://svn.apache.org/repos/asf/myfaces/core/tags/myfaces-core-module-2.1.10</connection>
        <developerConnection>scm:svn:https://svn.apache.org/repos/asf/myfaces/core/tags/myfaces-core-module-2.1.10</developerConnection>
        <url>http://svn.apache.org/repos/asf/myfaces/core/tags/myfaces-core-module-2.1.10</url>
    </scm>

    <modules>
        <module>parent</module>
        <module>api</module>
<!-- TODO REMOVE!
        <module>shaded-impl</module>
        <module>implee6</module>
-->
        <module>shared-public</module>
        <module>shared</module>
        <module>impl</module>
        <module>bundle</module>
    </modules>

    <build>
    
        <!-- Since Maven 3.0, this is required to add scpexe as protocol for deploy. -->
        <extensions>
          <extension>
            <groupId>org.apache.maven.wagon</groupId>
            <artifactId>wagon-ssh-external</artifactId>
            <version>1.0-beta-7</version>
          </extension>
        </extensions>

    </build>
    
    <profiles>

        <!-- TODO jakobk: we could change this to -Papache-release -->
        <!--
            This profile is invoked by -DprepareRelease=true.
            This allows mvn release:prepare to run successfully on the assembly projects.
        -->
        <profile>
            <id>prepare-release</id>
            <activation>
                <property>
                    <name>prepareRelease</name>
                </property>
            </activation>
            <modules>
                <module>assembly</module>
            </modules>
            <build>
                <plugins>
                    <plugin>
                        <artifactId>maven-release-plugin</artifactId>
                        <configuration>
                            <arguments>-DprepareRelease</arguments>
                        </configuration>
                    </plugin>
                </plugins>
            </build>
        </profile>
        <profile>
            <id>perform-release</id>
            <activation>
                <property>
                    <name>performRelease</name>
                    <value>true</value>
                </property>
            </activation>
            <modules>
                <module>assembly</module>
            </modules>
            <build>
                <plugins>
                    <plugin>
                        <artifactId>maven-release-plugin</artifactId>
                        <configuration>
                            <arguments>-Papache-release -DperformRelease</arguments>
                        </configuration>
                    </plugin>
                </plugins>
            </build>
        </profile>

    </profiles>

    <pluginRepositories>
        <pluginRepository>
            <id>apache.snapshots.plugin</id>
            <name>Apache Snapshot Repository</name>
            <url>http://repository.apache.org/snapshots</url>
            <releases>
                <enabled>false</enabled>
            </releases>
        </pluginRepository>
    </pluginRepositories>

    <repositories>

        <!-- NOTE that apache.snapshots is defined in apache-parent -->

        <!-- tomcat el-impl for test cases (see related tomcat-dependencies) -->
        <repository>
            <id>tomcat</id>
            <url>http://tomcat.apache.org/dev/dist/m2-repository</url>
        </repository>

    </repositories>
    
    <distributionManagement>
        <site>
            <id>apache.website</id>
            <name>Apache Website</name>
            <url>scpexe://people.apache.org/www/myfaces.apache.org/core20/module</url>
        </site>
    </distributionManagement>

</project>
