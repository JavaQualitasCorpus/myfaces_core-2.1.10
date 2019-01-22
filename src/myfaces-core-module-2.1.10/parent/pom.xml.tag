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
    <artifactId>myfaces-core-project</artifactId>
    <packaging>pom</packaging>
    <name>Apache MyFaces JSF-2.1 Core Project</name>
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
        <connection>scm:svn:http://svn.apache.org/repos/asf/myfaces/core/tags/myfaces-core-module-2.1.10/parent</connection>
        <developerConnection>scm:svn:https://svn.apache.org/repos/asf/myfaces/core/tags/myfaces-core-module-2.1.10/parent</developerConnection>
        <url>http://svn.apache.org/repos/asf/myfaces/core/tags/myfaces-core-module-2.1.10/parent</url>
    </scm>

    <build>
    
        <!-- Since Maven 3.0, this is required to add scpexe as protocol for deploy. -->
        <extensions>
          <extension>
            <groupId>org.apache.maven.wagon</groupId>
            <artifactId>wagon-ssh-external</artifactId>
            <version>1.0-beta-7</version>
          </extension>
        </extensions>
        
        <plugins>

            <!-- JDK 1.5 -->
            <plugin>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>2.0.2</version>
                <configuration>
                    <source>1.5</source>
                    <target>1.5</target>
                </configuration>
            </plugin>

            <!-- ceckstyle - TODO use myfaces wide checkstyle config from myfaces-parent? -->
            <plugin>
                <!--
                  - Make a checkstyle violation a compile error. Note that if a compile error occurs,
                  - further information can be found in target/site/checkstyle.html (present even when
                  - just the compile goal and not the site goal has been run). Note also that child
                  - projects may redeclare this plugin and provide different configuration settings
                  - to use different checks (more or less strict than the default).
                  -->
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-checkstyle-plugin</artifactId>
                <executions>
                    <execution>
                        <id>verify-style</id>
                        <phase>verify</phase>
                        <goals><goal>check</goal></goals>
                    </execution>
                </executions>
                <configuration>
<!--
                    <configLocation>default/myfaces-checks-minimal.xml</configLocation>
                    <headerLocation>default/myfaces-header.txt</headerLocation>
-->
                    <configLocation>default/myfaces-checks-standard.xml</configLocation>
                    <headerLocation>default/myfaces-header.txt</headerLocation>
                </configuration>
            </plugin>

            <!-- attach -sources.jar to all our modules -->
            <plugin>
                <artifactId>maven-source-plugin</artifactId>
                <version>2.0.4</version>
                <executions>
                    <execution>
                        <id>attach-source</id>
                        <goals>
                            <goal>jar</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
            
        </plugins>

        <pluginManagement>
            <plugins>

                <plugin>
                    <groupId>org.apache.myfaces.buildtools</groupId>
                    <artifactId>myfaces-faces-plugin</artifactId>
                    <version>1.0.0</version>
                </plugin>

                <plugin>
                    <groupId>org.apache.myfaces.buildtools</groupId>
                    <artifactId>myfaces-builder-plugin</artifactId>
                    <version>1.0.10</version>
                </plugin>
                
                <plugin>
                    <artifactId>myfaces-javascript-plugin</artifactId>
                    <groupId>org.apache.myfaces.buildtools</groupId>
                    <version>1.0.1</version>
                </plugin>

                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-shade-plugin</artifactId>
                    <version>1.3.3</version>
                </plugin>

                <plugin>
                    <groupId>org.codehaus.mojo</groupId>
                    <artifactId>build-helper-maven-plugin</artifactId>
                    <version>1.5</version>
                </plugin>

                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-idea-plugin</artifactId>
                    <version>2.1</version>
                    <configuration>
                        <jdkName>1.5</jdkName>
                        <linkModules>true</linkModules>
                        <downloadSources>true</downloadSources>
                        <jdkLevel>1.5</jdkLevel>
                    </configuration>
                </plugin>

                <plugin>
                    <artifactId>maven-surefire-plugin</artifactId>
                    <version>2.9</version>
                </plugin>
                
                <plugin>
                    <artifactId>maven-surefire-report-plugin</artifactId>
                    <version>2.9</version>
                </plugin>
                
                <!-- SITE GENERATION -->
                <plugin>
                    <artifactId>maven-javadoc-plugin</artifactId>
                    <version>2.8</version>
                </plugin>
                <plugin>
                  <artifactId>maven-site-plugin</artifactId>
                  <version>3.0</version>
                </plugin>
                <plugin>
                    <artifactId>maven-jxr-plugin</artifactId>
                    <version>2.3</version>
                </plugin>
                <plugin>
                    <groupId>org.codehaus.mojo</groupId>
                    <artifactId>taglist-maven-plugin</artifactId>
                    <version>2.4</version>
                </plugin>
                <plugin>
                    <artifactId>maven-changelog-plugin</artifactId>
                    <version>2.2</version>
                </plugin>
            </plugins>
        </pluginManagement>

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


    <reporting>
        <plugins>
            <plugin>
                <!-- disable the plugin for this site project -->
                <artifactId>maven-pmd-plugin</artifactId>
                <reportSets>
                    <reportSet />
                </reportSets>
            </plugin>
            <plugin>
              <artifactId>maven-project-info-reports-plugin</artifactId>
              <version>2.4</version>
            </plugin>
        </plugins>
    </reporting>
    

    <dependencyManagement>

        <!--
            Defines all dependencies used in this project.
            All other project-modules reference the dependencies from here only by groupId and artifactId.
        -->
        <dependencies>

            <!-- INTERNAL DEPENDENCIES -->

            <!-- myfaces-api -->
            <dependency>
                <groupId>org.apache.myfaces.core</groupId>
                <artifactId>myfaces-api</artifactId>
                <version>${project.version}</version>
            </dependency>

            <!-- myfaces-impl -->
            <dependency>
                <groupId>org.apache.myfaces.core</groupId>
                <artifactId>myfaces-impl</artifactId>
                <version>${project.version}</version>
            </dependency>

            <dependency>
                <groupId>org.apache.myfaces.core.internal</groupId>
                <artifactId>myfaces-impl-shared-public</artifactId>
                <version>${project.version}</version>
            </dependency>
            
            <dependency>
                <groupId>org.apache.myfaces.core.internal</groupId>
                <artifactId>myfaces-impl-shared</artifactId>
                <version>${project.version}</version>
            </dependency>


            <!-- SPEC DEPENDENCIES -->

            <!-- Servlet 2.5 (for ee5 compat compile) -->
            <dependency>
                <groupId>org.apache.geronimo.specs</groupId>
                <artifactId>geronimo-servlet_2.5_spec</artifactId>
                <version>1.2</version>
                <scope>provided</scope>
            </dependency>

            <!-- Servlet 3.0 (for ee6) -->
            <dependency>
                <groupId>org.apache.geronimo.specs</groupId>
                <artifactId>geronimo-servlet_3.0_spec</artifactId>
                <version>1.0</version>
                <scope>provided</scope>
            </dependency>

            <!-- JSP 2.1 -->
            <dependency>
                <groupId>org.apache.geronimo.specs</groupId>
                <artifactId>geronimo-jsp_2.1_spec</artifactId>
                <version>1.0.1</version>
                <scope>provided</scope>
                <exclusions>
                    <!-- we want to use el 2.2 -->
                    <exclusion>
                          <groupId>org.apache.geronimo.specs</groupId>
                          <artifactId>geronimo-el_1.0_spec</artifactId>
                    </exclusion>
                </exclusions>
            </dependency>

            <!-- JSTL 1.2 -->
            <dependency>
                <groupId>javax.servlet</groupId>
                <artifactId>jstl</artifactId>
                <version>1.2</version>
                <scope>provided</scope>
                <exclusions>
                    <!-- we already have a jsp-api -->
                    <exclusion>
                          <groupId>javax.servlet</groupId>
                          <artifactId>jsp-api</artifactId>
                    </exclusion>
                </exclusions>
            </dependency>
            
            <!-- annotations 1.0 (javax.annotation.*) -->
            <dependency>
                <groupId>org.apache.geronimo.specs</groupId>
                <artifactId>geronimo-annotation_1.0_spec</artifactId>
                <version>1.1.1</version>
                <scope>provided</scope>
            </dependency>

            <!-- el 2.2 (javax.el.*) -->
            <!--
              NOTE that we are also compatible with el 1.0, but we need to use el 2.2 as
              compile-dependency, because our ValueExpression wrappers need to support getValueReference().
            -->
            <dependency>
                <groupId>org.apache.geronimo.specs</groupId>
                <artifactId>geronimo-el_2.2_spec</artifactId>
                <version>1.0.1</version>
                <scope>provided</scope>
            </dependency>

            <!-- bean-validation 1.0 (javax.validation.*) -->
            <!-- NOTE that this must be compile + optional -->
            <dependency>
                <groupId>org.apache.geronimo.specs</groupId>
                <artifactId>geronimo-validation_1.0_spec</artifactId>
                <version>1.1</version>
                <scope>compile</scope>
                <optional>true</optional>
            </dependency>

            <!-- jpa 3.0 - needed in AllAnnotationLifecycleProvider -->
            <dependency>
                <groupId>org.apache.geronimo.specs</groupId>
                <artifactId>geronimo-jpa_3.0_spec</artifactId>
                <version>1.1.1</version>
                <scope>compile</scope>
                <optional>true</optional>
            </dependency>

            <!-- ejb 3.0 - needed in AllAnnotationLifecycleProvider -->
            <dependency>
                <groupId>org.apache.geronimo.specs</groupId>
                <artifactId>geronimo-ejb_3.0_spec</artifactId>
                <version>1.0.1</version>
                <scope>compile</scope>
                <optional>true</optional>
            </dependency>


            <!-- UTILITY DEPENDENCIES -->

            <!-- builder-annotations like @JSFWebConfigParam -->
            <dependency>
                <groupId>org.apache.myfaces.buildtools</groupId>
                <artifactId>myfaces-builder-annotations</artifactId>
                <version>1.0.9</version>
                <scope>provided</scope>
            </dependency>

            <dependency>
                <groupId>commons-collections</groupId>
                <artifactId>commons-collections</artifactId>
                <version>3.2</version>
                <scope>compile</scope>
            </dependency>
              
            <dependency>
                <groupId>commons-codec</groupId>
                <artifactId>commons-codec</artifactId>
                <version>1.3</version>
                <scope>compile</scope>
            </dependency>
            
            <dependency>
                <groupId>commons-beanutils</groupId>
                <artifactId>commons-beanutils</artifactId>
                <version>1.8.3</version>
                <scope>compile</scope>
            </dependency>

            <dependency>
                <groupId>commons-digester</groupId>
                <artifactId>commons-digester</artifactId>
                <version>1.8</version>
                <scope>compile</scope>
            </dependency>


            <!-- SPI DEPENDENCIES (compile + optional) -->

            <!-- tomcat 6.0.x support (LifecycleProvider) -->
            <dependency>
                <groupId>org.apache.tomcat</groupId>
                <artifactId>catalina</artifactId>
                <version>6.0.29</version>
                <scope>compile</scope>
                <optional>true</optional>
            </dependency>

            <!-- tomcat 7 support (LifecycleProvider) -->
            <dependency>
                <groupId>org.apache.tomcat</groupId>
                <artifactId>tomcat-catalina</artifactId>
                <version>7.0.0</version>
                <scope>compile</scope>
                <optional>true</optional>
            </dependency>

            <!-- Google guice support (GuiceResolver) -->
            <dependency>
                <groupId>com.google.code.guice</groupId>
                <artifactId>guice</artifactId>
                <version>1.0</version>
                <scope>compile</scope>
                <optional>true</optional>
            </dependency>


            <!-- TEST DEPENDENCIES -->

            <dependency>
                <groupId>junit</groupId>
                <artifactId>junit</artifactId>
                <version>4.8.1</version>
                <scope>test</scope>
            </dependency>
            
            <dependency>
                <groupId>org.testng</groupId>
                <artifactId>testng</artifactId>
                <classifier>jdk15</classifier>
                <version>5.1</version>
                <scope>test</scope>
            </dependency>

            <!-- test cases of myfaces-api -->
            <dependency>
                <groupId>org.apache.myfaces.core</groupId>
                <artifactId>myfaces-api</artifactId>
                <classifier>tests</classifier>
                <version>${project.version}</version>
                <scope>test</scope>
            </dependency>

            <dependency>
                <groupId>org.apache.myfaces.test</groupId>
                <artifactId>myfaces-test20</artifactId>
                <version>1.0.4</version>
                <scope>test</scope>
            </dependency>

            <!-- easymock -->
            <dependency>
                <groupId>org.easymock</groupId>
                <artifactId>easymock</artifactId>
                <version>2.3</version>
                <scope>test</scope>
            </dependency>
            <dependency>
                <groupId>org.easymock</groupId>
                <artifactId>easymockclassextension</artifactId>
                <version>2.3</version>
                <scope>test</scope>
            </dependency>

            <!-- jmock -->
            <dependency>
                  <groupId>jmock</groupId>
                  <artifactId>jmock</artifactId>
                  <version>1.2.0</version>
                  <scope>test</scope>
            </dependency>
            <dependency>
                  <groupId>jmock</groupId>
                  <artifactId>jmock-cglib</artifactId>
                  <version>1.2.0</version>
                  <scope>test</scope>
            </dependency>

            <dependency>
                <groupId>de.berlios.jsunit</groupId>
                <artifactId>jsunit-maven2-plugin</artifactId>
                <version>1.3</version>
                <scope>test</scope>
            </dependency>

            <!-- We need a real EL implementation for test ui:param tag,
            because myfaces-test MockExpressionFactory is not designed to
            handle VariableMapper stuff (see IncludeParamTestCase) -->
            <dependency>
                <groupId>org.apache.tomcat</groupId>
                <artifactId>el-api</artifactId>
                <version>6.0.28</version>
                <scope>test</scope>
            </dependency>
            <dependency>
                <groupId>org.apache.tomcat</groupId>
                <artifactId>jasper-el</artifactId>
                <version>6.0.28</version>
                <scope>test</scope>
            </dependency>

        </dependencies>
    </dependencyManagement>

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
            <url>scpexe://people.apache.org/www/myfaces.apache.org/core21/</url>
        </site>
    </distributionManagement>

</project>
