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
        <groupId>org.apache.myfaces.core</groupId>
        <artifactId>myfaces-core-project</artifactId>
        <version>2.1.10</version>
        <relativePath>../parent/pom.xml</relativePath>
    </parent>

    <modelVersion>4.0.0</modelVersion>
    
    <groupId>org.apache.myfaces.core</groupId>
    <artifactId>myfaces-impl</artifactId>
    <name>Apache MyFaces JSF-2.1 Core Impl</name>
    <description>
        The private implementation classes of the Apache MyFaces Core JSF-2.1 Implementation
    </description>
    <url>http://myfaces.apache.org/core21/myfaces-impl</url>

    <scm>
        <connection>scm:svn:http://svn.apache.org/repos/asf/myfaces/core/tags/myfaces-core-module-2.1.10/impl</connection>
        <developerConnection>scm:svn:https://svn.apache.org/repos/asf/myfaces/core/tags/myfaces-core-module-2.1.10/impl</developerConnection>
        <url>http://svn.apache.org/repos/asf/myfaces/core/tags/myfaces-core-module-2.1.10/impl</url>
    </scm>
    
    <build>
        
        <resources>
            <resource>
                <directory>src/main/resources</directory>
                <excludes>
                    <exclude>**/*.vm</exclude>
                </excludes>
            </resource>
        </resources>
        
        <plugins>

            <!-- license checker needs to exclude some kinds of files -->
            <plugin>
                <groupId>org.apache.rat</groupId>
                <artifactId>apache-rat-plugin</artifactId>
                <configuration>
                    <excludes>
                        
                        <!-- The xsd files are CDDL+GLP:
                          Category B: Reciprocal Licenses
                         "For small amounts of source that is directly consumed by the ASF product
                          at runtime in source form, and for which that source is unlikely to be
                          changed anyway (say, by virtue of being specified by a standard), this
                          action is sufficient. An example of this is the web-facesconfig_1_0.dtd,
                          whose inclusion is mandated by the JSR 127: JavaServer Faces specification."
                          http://www.apache.org/legal/3party.html
                        -->
                        <exclude>src/main/resources/META-INF/licenses/glassfish-LICENSE.txt</exclude>
                        <exclude>src/main/resources/org/apache/myfaces/resource/javaee_5.xsd</exclude>
                        <exclude>src/main/resources/org/apache/myfaces/resource/javaee_web_services_client_1_2.xsd</exclude>

                        <!-- facelets has non-standard APL license -->
                        <exclude>src/main/resources/META-INF/licenses/facelets-LICENSE.txt</exclude>
                        
                        <!-- services files are trivial config files with no comments -->
                        <exclude>src/test/resources/META-INF/services/org.apache.myfaces.config.annotation.LifecycleProvider</exclude>
                        <exclude>src/main/resources/META-INF/services/org.apache.myfaces.config.annotation.LifecycleProvider</exclude>

                        <!-- these jsf.js files are trivial empty placeholders -->
                        <exclude>src/test/resources/org/apache/myfaces/view/facelets/tag/composite/javax.faces/jsf.js</exclude>
                        <exclude>src/test/resources/org/apache/myfaces/view/facelets/tag/jsf/html/javax.faces/jsf.js</exclude>
                        <exclude>src/test/resources/org/apache/myfaces/view/facelets/updateheadres/resources/javax.faces/jsf.js</exclude>

                        <!-- This file probably needs a license, but I don't know if it's safe to put it in there -->
                        <exclude>src/test/resources/org/apache/myfaces/context/nestedScriptCDATA.xml</exclude>
                    </excludes>
                </configuration>
            </plugin>
            
            <!-- myfaces-build-plugin - we generate a lot of stuff with this plugin (see executions) -->
            <plugin>
                <groupId>org.apache.myfaces.buildtools</groupId>
                <artifactId>myfaces-builder-plugin</artifactId>
                <executions>
                    
                    <execution>
                        <id>makemyfacesmetadata</id>
                        <configuration>
                            <sourceDirectories>
                                <dir>${basedir}/src/main/java</dir>
                                <dir>${project.build.directory}/shared_sources</dir>
                            </sourceDirectories>
                        </configuration>
                        <goals>
                          <goal>build-metadata</goal>
                        </goals>
                    </execution>
                    
                    <execution>
                        <id>makeWebConfigParamsLogger</id>
                        <configuration>
                            <templateFile>WebConfigParamsLogger.vm</templateFile>
                            <outputDirectory>${project.build.directory}/generated-sources/myfaces-builder-plugin</outputDirectory>
                            <xmlFile>org/apache/myfaces/webapp/WebConfigParamsLogger.java</xmlFile>
                            <modelIds>
                                <modelId>myfaces-api</modelId>
                                <modelId>myfaces-impl</modelId>
                                <modelId>myfaces-impl-shared</modelId>
                            </modelIds>
                        </configuration>
                        <goals>
                            <goal>make-config</goal>
                        </goals>
                    </execution>
                    
                    <execution>
                        <id>makefacesconfig</id>
                        <configuration>
                            <templateFile>faces-config20.vm</templateFile>
                            <xmlFile>META-INF/standard-faces-config.xml</xmlFile>
                            <xmlBaseFile>src/main/conf/META-INF/standard-faces-config-base.xml</xmlBaseFile>
                            <modelIds>
                                <modelId>myfaces-api</modelId>
                                <modelId>myfaces-impl</modelId>
                                <modelId>myfaces-impl-shared</modelId>
                            </modelIds>
                        </configuration>
                        <goals>
                            <goal>make-config</goal>
                        </goals>
                    </execution>
                    
                    <execution>
                        <id>make_tags</id>
                        <configuration>
                           <jsfVersion>12</jsfVersion>
                           <templateTagName>tagClass12.vm</templateTagName>
                           <packageContains>org.apache</packageContains>
                           <typePrefix>javax.faces</typePrefix>
                           <modelIds>
                               <modelId>myfaces-api</modelId>
                           </modelIds>
                        </configuration>
                        <goals>
                            <goal>make-tags</goal>
                        </goals>
                    </execution>
                    
                    <execution>
                        <id>makecoretld</id>
                        <configuration>
                            <xmlFile>META-INF/myfaces_core.tld</xmlFile>
                            <xmlBaseFile>src/main/conf/META-INF/myfaces_core-base.tld</xmlBaseFile>
                            <templateFile>myfaces_core12.vm</templateFile>
                            <modelIds>
                                <modelId>myfaces-api</modelId>
                                <modelId>myfaces-impl</modelId>
                                <modelId>myfaces-impl-shared</modelId>
                            </modelIds>
                            <params>
                                <shortname>f</shortname>
                                <uri>http://java.sun.com/jsf/core</uri>
                                <displayname>JSF core tag library.</displayname>
                                <description>This tag library implements the standard JSF core tags.</description>
                            </params>
                        </configuration>
                        <goals>
                            <goal>make-config</goal>
                        </goals>
                    </execution>

                    <execution>
                        <id>makehtmltld</id>
                        <configuration>
                            <xmlFile>META-INF/myfaces_html.tld</xmlFile>
                            <xmlBaseFile>src/main/conf/META-INF/myfaces_html-base.tld</xmlBaseFile>
                            <templateFile>myfaces_html12.vm</templateFile>
                            <params>
                               <shortname>h</shortname>
                               <uri>http://java.sun.com/jsf/html</uri>
                               <displayname>JSF HTML tag library.</displayname>
                               <description>This tag library implements the standard JSF HTML tags.</description>
                            </params>
                            <modelIds>
                                <modelId>myfaces-api</modelId>
                            </modelIds>
                        </configuration>
                        <goals>
                            <goal>make-config</goal>
                        </goals>
                    </execution>
                    
                    <!--
                        To generate facelet taglib doc we need to create alternate facelets files
                        so taglibdoc goal can extract the required information and create html files.
                        We put this one here temporally but generate-assembly profile should trigger
                        this execution tasks too.
                    -->
                    <execution>
                        <id>make_core_facelet_tld</id>
                        <configuration>
                            <outputDirectory>${project.build.directory}/tlddoc-facelets</outputDirectory>
                            <xmlFile>myfaces_facelets_core.tld</xmlFile>
                            <xmlBaseFile>src/main/conf/META-INF/myfaces_core-base.tld</xmlBaseFile>
                            <templateFile>myfaces_facelet_core20.vm</templateFile>
                            <modelIds>
                                <modelId>myfaces-api</modelId>
                                <modelId>myfaces-impl</modelId>
                                <modelId>myfaces-impl-shared</modelId>
                            </modelIds>
                            <params>
                                <shortname>f</shortname>
                                <uri>http://java.sun.com/jsf/core</uri>
                                <displayname>JSF Core Facelets Tag Library.</displayname>
                                <description>This tag library implements the standard JSF core tags for Facelets.</description>
                            </params>
                        </configuration>
                        <goals>
                            <goal>make-config</goal>
                        </goals>
                    </execution>
                    
                    <execution>
                        <id>make_html_facelet_tld</id>
                        <configuration>
                            <outputDirectory>${project.build.directory}/tlddoc-facelets</outputDirectory>
                            <xmlFile>myfaces_facelets_html.tld</xmlFile>
                            <xmlBaseFile>src/main/conf/META-INF/myfaces_html-base.tld</xmlBaseFile>
                            <templateFile>myfaces_facelet_html20.vm</templateFile>
                            <modelIds>
                                <modelId>myfaces-api</modelId>
                                <modelId>myfaces-impl</modelId>
                                <modelId>myfaces-impl-shared</modelId>
                            </modelIds>
                            <params>
                               <shortname>h</shortname>
                               <uri>http://java.sun.com/jsf/html</uri>
                               <displayname>JSF HTML Facelets Tag Library.</displayname>
                               <description>This tag library implements the standard JSF HTML tags for Facelets.</description>
                            </params>
                        </configuration>
                        <goals>
                            <goal>make-config</goal>
                        </goals>
                    </execution>

                    <execution>
                        <id>make_c_facelet_tld</id>
                        <configuration>
                            <outputDirectory>${project.build.directory}/tlddoc-facelets</outputDirectory>
                            <xmlFile>myfaces_facelets_c.tld</xmlFile>
                            <xmlBaseFile>src/main/conf/META-INF/myfaces_html-base.tld</xmlBaseFile>
                            <templateFile>myfaces_facelet_html20.vm</templateFile>
                            <modelIds>
                                <modelId>myfaces-api</modelId>
                                <modelId>myfaces-impl</modelId>
                                <modelId>myfaces-impl-shared</modelId>
                            </modelIds>
                            <params>
                               <shortname>c</shortname>
                               <uri>http://java.sun.com/jsp/jstl/core</uri>
                               <displayname>JSTL core Facelets Tag Library.</displayname>
                               <description>JSTL core Facelets Tag Library.</description>
                            </params>
                        </configuration>
                        <goals>
                            <goal>make-config</goal>
                        </goals>
                    </execution>
                    
                    <execution>
                        <id>make_ui_facelet_tld</id>
                        <configuration>
                            <outputDirectory>${project.build.directory}/tlddoc-facelets</outputDirectory>
                            <xmlFile>myfaces_facelets_ui.tld</xmlFile>
                            <xmlBaseFile>src/main/conf/META-INF/myfaces_ui-base.tld</xmlBaseFile>
                            <templateFile>myfaces_facelet_html20.vm</templateFile>
                            <modelIds>
                                <modelId>myfaces-api</modelId>
                                <modelId>myfaces-impl</modelId>
                                <modelId>myfaces-impl-shared</modelId>
                            </modelIds>
                            <params>
                               <shortname>ui</shortname>
                               <uri>http://java.sun.com/jsf/facelets</uri>
                               <displayname>JSF UI Facelets Tag Library.</displayname>
                               <description>JSF UI Facelets Tag Library.</description>
                            </params>
                        </configuration>
                        <goals>
                            <goal>make-config</goal>
                        </goals>
                    </execution>
                    
                    <execution>
                        <id>make_composite_facelet_tld</id>
                        <configuration>
                            <outputDirectory>${project.build.directory}/tlddoc-facelets</outputDirectory>
                            <xmlFile>myfaces_facelets_composite.tld</xmlFile>
                            <xmlBaseFile>src/main/conf/META-INF/myfaces_html-base.tld</xmlBaseFile>
                            <templateFile>myfaces_facelet_html20.vm</templateFile>
                            <modelIds>
                                <modelId>myfaces-api</modelId>
                                <modelId>myfaces-impl</modelId>
                                <modelId>myfaces-impl-shared</modelId>
                            </modelIds>
                            <params>
                               <shortname>composite</shortname>
                               <uri>http://java.sun.com/jsf/composite</uri>
                               <displayname>JSF Composite Facelets Tag Library.</displayname>
                               <description>JSF Composite Facelets Tag Library.</description>
                            </params>
                        </configuration>
                        <goals>
                            <goal>make-config</goal>
                        </goals>
                    </execution>
                    
                    <execution>
                        <id>make_fn_facelet_tld</id>
                        <configuration>
                            <outputDirectory>${project.build.directory}/tlddoc-facelets</outputDirectory>
                            <xmlFile>myfaces_facelet_fn.tld</xmlFile>
                            <templateFile>myfaces_facelet_html20.vm</templateFile>
                            <modelIds>
                                <modelId>myfaces-api</modelId>
                                <modelId>myfaces-impl</modelId>
                                <modelId>myfaces-impl-shared</modelId>
                            </modelIds>
                            <params>
                               <shortname>fn</shortname>
                               <uri>http://java.sun.com/jsp/jstl/functions</uri>
                               <displayname>JSTL Facelets Function Library.</displayname>
                               <description>JSTL Facelets Function Library.</description>
                            </params>
                        </configuration>
                        <goals>
                            <goal>make-config</goal>
                        </goals>
                    </execution>

                    <!-- START XSD GENERATION -->
                    
                    <execution>
                        <id>make_core_facelet_xsd</id>
                        <configuration>
                            <xmlFile>META-INF/schema/myfaces_facelets_core_2_1.xsd</xmlFile>
                            <templateFile>myfaces_facelet_core20_xsd.vm</templateFile>
                            <modelIds>
                                <modelId>myfaces-api</modelId>
                                <modelId>myfaces-impl</modelId>
                                <modelId>myfaces-impl-shared</modelId>
                            </modelIds>
                            <params>
                                <shortname>f</shortname>
                                <uri>http://java.sun.com/jsf/core</uri>
                                <displayname>JSF Core Facelets Tag Library.</displayname>
                                <tlibversion>2.1</tlibversion>
                                <description>This tag library implements the standard JSF core tags for Facelets.</description>
                            </params>
                        </configuration>
                        <goals>
                            <goal>make-config</goal>
                        </goals>
                    </execution>
                    
                    <execution>
                        <id>make_html_facelet_xsd</id>
                        <configuration>
                            <xmlFile>META-INF/schema/myfaces_facelets_html_2_1.xsd</xmlFile>
                            <templateFile>myfaces_facelet_html20_xsd.vm</templateFile>
                            <modelIds>
                                <modelId>myfaces-api</modelId>
                                <modelId>myfaces-impl</modelId>
                                <modelId>myfaces-impl-shared</modelId>
                            </modelIds>
                            <params>
                               <shortname>h</shortname>
                               <uri>http://java.sun.com/jsf/html</uri>
                               <displayname>JSF HTML Facelets Tag Library.</displayname>
                               <description>This tag library implements the standard JSF HTML tags for Facelets.</description>
                            </params>
                        </configuration>
                        <goals>
                            <goal>make-config</goal>
                        </goals>
                    </execution>

                    <execution>
                        <id>make_c_facelet_xsd</id>
                        <configuration>
                            <xmlFile>META-INF/schema/myfaces_facelets_c_2_1.xsd</xmlFile>
                            <templateFile>myfaces_facelet_html20_xsd.vm</templateFile>
                            <modelIds>
                                <modelId>myfaces-api</modelId>
                                <modelId>myfaces-impl</modelId>
                                <modelId>myfaces-impl-shared</modelId>
                            </modelIds>
                            <params>
                               <shortname>c</shortname>
                               <uri>http://java.sun.com/jsp/jstl/core</uri>
                               <displayname>JSTL core Facelets Tag Library.</displayname>
                               <description>JSTL core Facelets Tag Library.</description>
                            </params>
                        </configuration>
                        <goals>
                            <goal>make-config</goal>
                        </goals>
                    </execution>
                    
                    <execution>
                        <id>make_ui_facelet_xsd</id>
                        <configuration>
                            <xmlFile>META-INF/schema/myfaces_facelets_ui_2_1.xsd</xmlFile>
                            <templateFile>myfaces_facelet_html20_xsd.vm</templateFile>
                            <modelIds>
                                <modelId>myfaces-api</modelId>
                                <modelId>myfaces-impl</modelId>
                                <modelId>myfaces-impl-shared</modelId>
                            </modelIds>
                            <params>
                               <shortname>ui</shortname>
                               <uri>http://java.sun.com/jsf/facelets</uri>
                               <displayname>JSF UI Facelets Tag Library.</displayname>
                               <description>JSF UI Facelets Tag Library.</description>
                            </params>
                        </configuration>
                        <goals>
                            <goal>make-config</goal>
                        </goals>
                    </execution>
                    
                    <execution>
                        <id>make_composite_facelet_xsd</id>
                        <configuration>
                            <xmlFile>META-INF/schema/myfaces_facelets_composite_2_1.xsd</xmlFile>
                            <templateFile>myfaces_facelet_html20_xsd.vm</templateFile>
                            <modelIds>
                                <modelId>myfaces-api</modelId>
                                <modelId>myfaces-impl</modelId>
                                <modelId>myfaces-impl-shared</modelId>
                            </modelIds>
                            <params>
                               <shortname>composite</shortname>
                               <uri>http://java.sun.com/jsf/composite</uri>
                               <displayname>JSF Composite Facelets Tag Library.</displayname>
                               <description>JSF Composite Facelets Tag Library.</description>
                            </params>
                        </configuration>
                        <goals>
                            <goal>make-config</goal>
                        </goals>
                    </execution>

                    <!-- END XSD GENERATION -->
                </executions>
            </plugin>

            
            <!-- generate a -tests.jar too -->
            <plugin>
                <artifactId>maven-jar-plugin</artifactId>
                <version>2.2</version>
                <executions>
                    <execution>
                        <goals>
                            <goal>test-jar</goal>
                        </goals>
                      </execution>
                </executions>
                <configuration>
                    <archive>
                        <manifestFile>${project.build.outputDirectory}/META-INF/MANIFEST.MF</manifestFile>
                    </archive>
                </configuration>
            </plugin>

            <!-- configure manifest.mf for jar -->
            <plugin>
                <artifactId>maven-jar-plugin</artifactId>
                <version>2.2</version>
                <configuration>
                    <archive>
                        <manifestFile>${project.build.outputDirectory}/META-INF/MANIFEST.MF</manifestFile>
                    </archive>
                </configuration>
            </plugin>
            
            <!-- run test-cases -->
            <plugin>
                <artifactId>maven-surefire-plugin</artifactId>
                <configuration>
                    <!-- Only run JUnit tests -->
                    <testNGArtifactName>none:none</testNGArtifactName>
                    <excludes>
                        <exclude>**/JspStateManagerImplTest*</exclude>
                        <exclude>**/DefaultViewHandlerSupportTest*</exclude>
                        <exclude>**/ApplicationImplTest*</exclude>
                        <exclude>**/FactoryFinderProviderTest*</exclude>
                    </excludes>
                </configuration>
                <executions>
                    <execution>
                        <id>isolateCLTests</id>
                        <phase>test</phase>
                        <goals>
                            <goal>test</goal>
                        </goals>
                        <configuration>
                            <forkMode>always</forkMode>
                            <testNGArtifactName>none:none</testNGArtifactName>
                            <includes>
                                <include>**/FactoryFinderProviderTest*</include>
                            </includes>
                            <excludes>
                                <exclude>**/JspStateManagerImplTest*</exclude>
                                <exclude>**/DefaultViewHandlerSupportTest*</exclude>
                                <exclude>**/ApplicationImplTest*</exclude>
                            </excludes>
                        </configuration>
                    </execution>
                </executions>
            </plugin>

            <!-- include implee6 via maven-shade-plugin -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-shade-plugin</artifactId>
                <executions>
                    <execution>
                        <phase>package</phase>
                        <goals>
                            <goal>shade</goal>
                        </goals>
                    </execution>
                </executions>
                <configuration>
                    <createDependencyReducedPom>false</createDependencyReducedPom>
                    <createSourcesJar>true</createSourcesJar>
                    <artifactSet>
                        <includes>
                            <include>org.apache.myfaces.core.internal:myfaces-impl-shared</include>
                        </includes>
                    </artifactSet>
                </configuration>
            </plugin>

            <!-- create OSGI-ready manifest.mf -->
            <plugin>
                <groupId>org.apache.felix</groupId>
                <artifactId>maven-bundle-plugin</artifactId>
                <version>2.1.0</version>
                <executions>
                    <execution>
                        <id>bundle-manifest</id>
                        <phase>process-classes</phase>
                        <goals>
                            <goal>manifest</goal>
                        </goals>
                        <configuration>
                            <instructions>
                                <Bundle-SymbolicName>org.apache.myfaces.core.impl</Bundle-SymbolicName>
                                <Bundle-Classpath>.</Bundle-Classpath>
                                <Build-Jdk>${java.version}</Build-Jdk>
                                <Implementation-Title>${project.name}</Implementation-Title>
                                <Implementation-Version>${project.version}</Implementation-Version>
                                <Implementation-Vendor>The Apache Software Foundation</Implementation-Vendor>
                                <Implementation-Vendor-Id>${project.groupId}</Implementation-Vendor-Id>
                                <Export-Package>
                                    *;version="${project.version}"
                                </Export-Package>
                                <Import-Package>
                                    !org.apache.myfaces.*,
                                    com.google.inject;version="[1.0.0, 2.0.0)";resolution:=optional,
                                    javax.annotation,
                                    javax.crypto,
                                    javax.crypto.spec,
                                    javax.ejb;resolution:=optional,
                                    javax.el;version="[1.0.0, 3.0.0)",
                                    javax.naming,
                                    javax.persistence;version="[1.0.0, 2.1)";resolution:=optional,
                                    javax.portlet;version="[1.0.0, 2.1)";resolution:=optional,
                                    javax.servlet;version="[2.5.0, 3.1)",
                                    javax.servlet.http;version="[2.5.0, 3.1)",
                                    javax.servlet.jsp;version="[2.1.0, 3.1)",
                                    javax.servlet.jsp.jstl.core;version="[1.1.2, 2.0.0)",
                                    javax.servlet.jsp.tagext;version="[2.1.0, 3.1)",
                                    javax.servlet.annotation;resolution:=optional,
                                    javax.xml.parsers,
                                    org.apache;resolution:=optional,
                                    org.apache.commons.beanutils;version="[1.8.3, 2.0.0)",
                                    org.apache.commons.codec.binary;version="[1.3.0, 2.0.0)",
                                    org.apache.commons.collections.map;version="[3.2.0, 4.0.0)",
                                    org.apache.commons.digester;version="[1.8.0, 2.0.0)",
                                    org.apache.commons.logging;version="[1.1.1, 2.0.0)",
                                    org.w3c.dom,
                                    org.xml.sax,
                                    org.xml.sax.helpers,
                                    org.apache.jasper.compiler;resolution:=optional,
                                    org.apache.jasper.el;resolution:=optional,
                                    org.apache.el;resolution:=optional,
                                    org.apache.tomcat;resolution:=optional,
                                    javax.faces.*;version="${project.version}",
                                    *
                                </Import-Package>
                            </instructions>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
            
        </plugins>

    </build>


    <profiles>

        <!--
          - Whenever the full website is generated, the command
          -   mvn -Pgenerate-site -Pgenerate-tlddoc site
          - should be used. This will create the "tlddoc" directory containing
          - nicely-formatted versions of the docs in the jsp taglib file, ie
          - docs on all the available tags and their properties.
        -->
        <profile>
            <id>generate-site</id>
            <build>
                <plugins>

                    <!-- Generate content for custom tagdoc report -->
                    <plugin>
                        <groupId>org.apache.myfaces.buildtools</groupId>
                        <artifactId>myfaces-builder-plugin</artifactId>
                        <executions>
                            
                            <execution>
                                <id>site-tagdoc-content</id>
                                <configuration>
                                    <modelIds>
                                        <modelId>myfaces-api</modelId>
                                        <modelId>myfaces-impl</modelId>
                                        <modelId>myfaces-impl-shared</modelId>
                                    </modelIds>
                                    <taglibs>
                                        <f>http://java.sun.com/jsf/core</f>
                                        <h>http://java.sun.com/jsf/html</h>
                                        <ui>http://java.sun.com/jsf/facelets</ui>
                                        <c>http://java.sun.com/jsp/jstl/core</c>
                                        <fn>http://java.sun.com/jsp/jstl/functions</fn>
                                    </taglibs>
                                </configuration>
                                <goals>
                                    <goal>tagdoc-content</goal>
                                </goals>
                            </execution>

                            <execution>
                                <id>site-web-config</id>
                                <configuration>
                                    <templateFile>xdoc-web-config.vm</templateFile>
                                    <outputDirectory>${project.build.directory}/generated-site/xdoc</outputDirectory>
                                    <xmlFile>webconfig.xml</xmlFile>
                                    <modelIds>
                                        <modelId>myfaces-api</modelId>
                                        <modelId>myfaces-impl</modelId>
                                        <modelId>myfaces-impl-shared</modelId>
                                    </modelIds>
                                </configuration>
                                <goals>
                                    <goal>make-config</goal>
                                </goals>
                            </execution>
                            
                        </executions>
                    </plugin>

                    <!--
                        Unfortunately we can't execute the same report twice, so
                        we have to generate this files outside report generation. 
                    -->
                    <plugin>
                        <groupId>net.sourceforge.maven-taglib</groupId>
                        <artifactId>maven-taglib-plugin</artifactId>
                        <version>2.4</version>
                        <executions>
                            
                            <execution>
                                <id>tlddoc-facelets</id>
                                <phase>site</phase>
                                <goals>
                                    <goal>taglibdoc</goal>
                                </goals>
                                <inherited>false</inherited>
                                <configuration>
                                    <title>${project.name} Tag library documentation for Facelets</title>
                                    <srcDir>${basedir}/target/tlddoc-facelets</srcDir>
                                    <tldDocDir>${basedir}/target/site/tlddoc-facelets</tldDocDir>
                                </configuration>
                            </execution>
                            
                            <execution>
                                <id>tlddoc-jsp</id>
                                <phase>site</phase>
                                <goals>
                                    <goal>taglibdoc</goal>
                                </goals>
                                <inherited>false</inherited>
                                <configuration>
                                    <taglib.src.dir>${basedir}/target/classes/META-INF</taglib.src.dir>
                                    <tldDocDir>${basedir}/target/site/tlddoc</tldDocDir>
                                </configuration>
                            </execution>
                            
                        </executions>
                    </plugin>

                </plugins>
            </build>

            <reporting>
                <plugins>
                    <plugin>
                        <groupId>net.sourceforge.maven-taglib</groupId>
                        <artifactId>maven-taglib-plugin</artifactId>
                        <version>2.4</version>
                        <configuration>
                            <taglib.src.dir>${basedir}/target/classes/META-INF</taglib.src.dir>
                            <tldDocDir>${basedir}/target/site/tlddoc</tldDocDir>
                        </configuration>
                    </plugin>

                    <!-- trigger tagdoc-index report -->
                    <plugin>
                        <groupId>org.apache.myfaces.buildtools</groupId>
                        <artifactId>myfaces-builder-plugin</artifactId>
                        <reportSets>
                            <reportSet>
                                <configuration>
                                    <modelIds>
                                        <modelId>myfaces-api</modelId>
                                        <modelId>myfaces-impl</modelId>
                                        <modelId>myfaces-impl-shared</modelId>
                                    </modelIds>
                                    <taglibs>
                                        <f>http://java.sun.com/jsf/core</f>
                                        <h>http://java.sun.com/jsf/html</h>
                                        <ui>http://java.sun.com/jsf/facelets</ui>
                                        <c>http://java.sun.com/jsp/jstl/core</c>
                                        <fn>http://java.sun.com/jsp/jstl/functions</fn>
                                    </taglibs>
                                </configuration>
                                <reports>
                                    <report>tagdoc-index</report>
                                </reports>
                            </reportSet>
                        </reportSets>
                    </plugin>
                </plugins>
            </reporting>
        </profile>

        <!--
          - Whenever files are deployed to a snapshot or release repository,
          -   mvn -Pgenerate-assembly deploy
          - should be used. This will create additional artifacts that are
          - useful but too time-consuming to create when just doing a local
          - "mvn install" operation.
        -->
        <profile>
            <id>generate-assembly</id>
            <activation>
                <property>
                    <name>performRelease</name>
                    <value>true</value>
                </property>
            </activation>
            <build>
                <plugins>

                    <plugin>
                        <artifactId>maven-javadoc-plugin</artifactId>
                        <configuration>
                            <excludePackageNames>org.apache.myfaces.ee6</excludePackageNames>
                        </configuration>
                        <executions>
                            <execution>
                                <id>attach-javadoc</id>
                                <goals>
                                    <goal>jar</goal>
                                </goals>
                            </execution>
                        </executions>
                    </plugin>
                    
                    <plugin>
                        <groupId>net.sourceforge.maven-taglib</groupId>
                        <artifactId>maven-taglib-plugin</artifactId>
                        <version>2.4</version>
                        <executions>
                            
                            <execution>
                                <id>tlddoc-facelets</id>
                                <!--
                                    TODO: The phase value should be "site", but since we are not released yet
                                    and this documentation is used to implement jsf 2.0, we put this one
                                    on site so just doing mvn -Pgenerate-site install we can create this
                                    javadoc
                                -->
                                <phase>process-resources</phase>
                                <goals>
                                    <goal>taglibdoc</goal>
                                </goals>
                                <inherited>false</inherited>
                                <configuration>
                                    <title>${project.name} Tag library documentation for Facelets</title>
                                    <srcDir>${basedir}/target/tlddoc-facelets</srcDir>
                                    <tldDocDir>${basedir}/target/site/tlddoc-facelets</tldDocDir>
                                </configuration>
                            </execution>
                            
                            <execution>
                                <id>tlddoc-jsp</id>
                                <phase>process-resources</phase>
                                <goals>
                                    <goal>taglibdoc</goal>
                                </goals>
                                <inherited>false</inherited>
                                <configuration>
                                    <taglib.src.dir>${basedir}/target/classes/META-INF</taglib.src.dir>
                                    <tldDocDir>${basedir}/target/site/tlddoc</tldDocDir>
                                </configuration>
                            </execution>

                            <execution>
                                <id>attach-tlddoc</id>
                                <goals>
                                    <goal>taglibdocjar</goal>
                                </goals>
                                <configuration>
                                    <tldDocDir>${basedir}/target/site/tlddoc</tldDocDir>
                                </configuration>
                            </execution>
                            
                            <execution>
                                <id>attach-tlddoc-facelets</id>
                                <goals>
                                    <goal>taglibdocjar</goal>
                                </goals>
                                <configuration>
                                    <attach>false</attach>
                                    <tldDocDir>${basedir}/target/site/tlddoc-facelets</tldDocDir>
                                    <tlddocJar>${basedir}/target/${project.artifactId}-${project.version}-facelets-tlddoc.jar</tlddocJar>
                                </configuration>
                            </execution>
                            
                        </executions>
                    </plugin>

                    <plugin>
                        <groupId>org.codehaus.mojo</groupId>
                        <artifactId>build-helper-maven-plugin</artifactId>
                        <executions>
                            <execution>
                                <id>attach-artifacts</id>
                                <phase>package</phase>
                                <goals>
                                    <goal>attach-artifact</goal>
                                </goals>
                                <configuration>
                                    <artifacts>
                                        <artifact>
                                            <file>${basedir}/target/${project.artifactId}-${project.version}-facelets-tlddoc.jar</file>
                                            <type>jar</type>
                                            <classifier>facelets-tlddoc</classifier>
                                        </artifact>
                                    </artifacts>
                                </configuration>
                            </execution>
                        </executions>
                    </plugin>
                    
                </plugins>
            </build>
        </profile>

        <!-- check Java 1.5 -->
        <profile>
            <id>checkJDK</id>
            <activation>
                <property>
                    <name>performRelease</name>
                    <value>true</value>
                </property>
            </activation>
            <build>
                <plugins>
                    <plugin>
                        <groupId>org.jvnet</groupId>
                        <artifactId>animal-sniffer</artifactId>
                        <version>1.2</version>
                        <executions>
                            <execution>
                                <goals>
                                    <goal>check</goal>
                                </goals>
                                <configuration>
                                    <signature>
                                        <groupId>org.jvnet.animal-sniffer</groupId>
                                        <artifactId>java1.5</artifactId>
                                        <version>1.0</version>
                                    </signature>
                                </configuration>
                            </execution>
                        </executions>
                    </plugin>
                </plugins>
            </build>

            <!-- TODO jakobk: update to codehaus animal-sniffer (is in maven-central)! -->
            <!-- plugin is only in java.net -->
            <pluginRepositories>
                <pluginRepository>
                    <id>java.net.repo</id>
                    <name>java.net repository</name>
                    <url>http://download.java.net/maven/2/</url>
                </pluginRepository>
            </pluginRepositories>
        </profile>

        <profile>
            <id>ee5</id>
            <dependencies>
                <!-- disable Servlet 3.0 -->
                <dependency>
                    <groupId>org.apache.geronimo.specs</groupId>
                    <artifactId>geronimo-servlet_3.0_spec</artifactId>
                    <scope>test</scope> <!-- just to make it go away -->
                </dependency>

                <!-- and enable Servlet 2.5 -->
                <dependency>
                    <groupId>org.apache.geronimo.specs</groupId>
                    <artifactId>geronimo-servlet_2.5_spec</artifactId>
                </dependency>
            </dependencies>

            <build>
                <plugins>
                  <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-compiler-plugin</artifactId>
                    <configuration>
                      <excludes>
                         <exclude>src/main/java/org/apache/myfaces/ee6</exclude>
                      </excludes>
                    </configuration>
                  </plugin>
                </plugins>
            </build>
        </profile>

    </profiles>

    
    <dependencies>
        <!-- NOTE that all versions and scopes are defined in the parent dependencyManagement section -->

        <!-- myfaces-api -->
        <dependency>
            <groupId>org.apache.myfaces.core</groupId>
            <artifactId>myfaces-api</artifactId>
        </dependency>

        <!-- this dependency will be packed together with the main artifact of this pom -->
        <!-- 
        <dependency>
            <groupId>org.apache.myfaces.shared</groupId>
            <artifactId>myfaces-shared-impl</artifactId>
        </dependency>
         -->
        
        <!-- This is included in myfaces-impl-shared, but in eclipse
             it is not detected, so an easy workaround is include it
             as an optional dependency -->
        <dependency>
            <groupId>org.apache.myfaces.core.internal</groupId>
            <artifactId>myfaces-impl-shared-public</artifactId>
            <optional>true</optional> 
        </dependency>
         
        <dependency>
            <groupId>org.apache.myfaces.core.internal</groupId>
            <artifactId>myfaces-impl-shared</artifactId>
            <optional>true</optional> 
        </dependency>


        <!-- Servlet 3.0 by default. Use the -Pee5 compile for servlet-2.5 -->
        <dependency>
            <groupId>org.apache.geronimo.specs</groupId>
            <artifactId>geronimo-servlet_3.0_spec</artifactId>
        </dependency>

        <!-- JSP 2.1 -->
        <dependency>
            <groupId>org.apache.geronimo.specs</groupId>
            <artifactId>geronimo-jsp_2.1_spec</artifactId>
        </dependency>

        <!-- JSTL 1.2 -->
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>jstl</artifactId>
        </dependency>

        <!-- el 2.2 (javax.el.*) -->
        <!--
            NOTE that we are also compatible with el 1.0, but we need to use el 2.2 as
            compile-dependency, because our ValueExpression wrappers need to support getValueReference().
        -->
        <dependency>
            <groupId>org.apache.geronimo.specs</groupId>
            <artifactId>geronimo-el_2.2_spec</artifactId>
        </dependency>

        <!-- bean-validation 1.0 (javax.validation.*) -->
        <dependency>
            <groupId>org.apache.geronimo.specs</groupId>
            <artifactId>geronimo-validation_1.0_spec</artifactId>
            <optional>true</optional> <!-- optional does not completely work in dependencyManagement (MNG-1630) -->
        </dependency>
        
        <!-- annotations 1.0 (javax.annotation.*) -->
        <dependency>
            <groupId>org.apache.geronimo.specs</groupId>
            <artifactId>geronimo-annotation_1.0_spec</artifactId>
        </dependency>

        <!-- jpa 3.0 - needed in AllAnnotationLifecycleProvider -->
        <dependency>
            <groupId>org.apache.geronimo.specs</groupId>
            <artifactId>geronimo-jpa_3.0_spec</artifactId>
            <optional>true</optional> <!-- optional does not completely work in dependencyManagement (MNG-1630) -->
        </dependency>

        <!-- ejb 3.0 - needed in AllAnnotationLifecycleProvider -->
        <dependency>
            <groupId>org.apache.geronimo.specs</groupId>
            <artifactId>geronimo-ejb_3.0_spec</artifactId>
            <optional>true</optional> <!-- optional does not completely work in dependencyManagement (MNG-1630) -->
        </dependency>

        <!-- builder-annotations like @JSFWebConfigParam -->
        <dependency>
            <groupId>org.apache.myfaces.buildtools</groupId>
            <artifactId>myfaces-builder-annotations</artifactId>
        </dependency>

        <!-- commons dependencies -->
        <dependency>
            <groupId>commons-collections</groupId>
            <artifactId>commons-collections</artifactId>
        </dependency>
       
        <dependency>
            <groupId>commons-codec</groupId>
            <artifactId>commons-codec</artifactId>
        </dependency>

        <dependency>
            <groupId>commons-beanutils</groupId>
            <artifactId>commons-beanutils</artifactId>
        </dependency>

        <dependency>
            <groupId>commons-digester</groupId>
            <artifactId>commons-digester</artifactId>
        </dependency>

        <!-- tomcat 6.0.x support (LifecycleProvider) -->
        <dependency>
            <groupId>org.apache.tomcat</groupId>
            <artifactId>catalina</artifactId>
            <optional>true</optional> <!-- optional does not completely work in dependencyManagement (MNG-1630) -->
        </dependency>

        <!-- tomcat 7 support (LifecycleProvider) -->
        <dependency>
            <groupId>org.apache.tomcat</groupId>
            <artifactId>tomcat-catalina</artifactId>
            <optional>true</optional> <!-- optional does not completely work in dependencyManagement (MNG-1630) -->
        </dependency>

        <!-- Google guice support (GuiceResolver) -->
        <dependency>
            <groupId>com.google.code.guice</groupId>
            <artifactId>guice</artifactId>
            <optional>true</optional> <!-- optional does not completely work in dependencyManagement (MNG-1630) -->
        </dependency>
        

        <!-- TEST DEPENDENCIES -->

        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
        </dependency>
        
        <dependency>
            <groupId>org.testng</groupId>
            <artifactId>testng</artifactId>
            <classifier>jdk15</classifier>
        </dependency>

        <!-- test cases of myfaces-api -->
        <dependency>
            <groupId>org.apache.myfaces.core</groupId>
            <artifactId>myfaces-api</artifactId>
            <classifier>tests</classifier>
            <scope>test</scope>
        </dependency>
        
        <dependency>
            <groupId>org.apache.myfaces.test</groupId>
            <artifactId>myfaces-test20</artifactId>
        </dependency>

        <!-- easymock -->
        <dependency>
            <groupId>org.easymock</groupId>
            <artifactId>easymock</artifactId>
        </dependency>
        <dependency>
            <groupId>org.easymock</groupId>
            <artifactId>easymockclassextension</artifactId>
        </dependency>

        <!-- We need a real EL implementation for test ui:param tag,
        because myfaces-test MockExpressionFactory is not designed to
        handle VariableMapper stuff (see IncludeParamTestCase) -->
        <dependency>
            <groupId>org.apache.tomcat</groupId>
            <artifactId>el-api</artifactId>
        </dependency>
        <dependency>
            <groupId>org.apache.tomcat</groupId>
            <artifactId>jasper-el</artifactId>
        </dependency>

    </dependencies>
    

    <reporting>
        <plugins>
            
            <plugin>
                <artifactId>maven-javadoc-plugin</artifactId>
                <configuration>
                    <excludePackageNames>org.apache.myfaces.ee6</excludePackageNames>
                </configuration>
            </plugin>
            <plugin>
                <artifactId>maven-changelog-plugin</artifactId>
                <reportSets>
                    <reportSet>
                        <id>dual-report</id>
                        <configuration>
                            <type>range</type>
                            <range>30</range>
                        </configuration>
                        <reports>
                            <report>changelog</report>
                            <report>file-activity</report>
                            <report>dev-activity</report>
                        </reports>
                    </reportSet>
                </reportSets>
            </plugin>
            
            <plugin>
                <artifactId>maven-jxr-plugin</artifactId>
            </plugin>
            
            <plugin>
                <artifactId>maven-surefire-report-plugin</artifactId>
            </plugin>
            
            <plugin>
                <groupId>org.codehaus.mojo</groupId>
                <artifactId>taglist-maven-plugin</artifactId>
            </plugin>
            
            <!-- override PMD settings to set targetJdk -->
            <plugin>
                <artifactId>maven-pmd-plugin</artifactId>
                <configuration>
                    <rulesets>
                        <ruleset>/rulesets/basic.xml</ruleset>
                        <ruleset>/rulesets/unusedcode.xml</ruleset>
                    </rulesets>
                    <linkXref>true</linkXref>
                    <minimumTokens>100</minimumTokens>
                    <targetJdk>1.5</targetJdk>
                    <excludes>
                        <!-- these class make the PMD plugin crash (NullPointerException). -->
                        <exclude>org/apache/myfaces/el/convert/PropertyResolverToELResolver.java</exclude>
                        <exclude>org/apache/myfaces/el/PropertyResolverImpl.java</exclude>
                    </excludes>
                </configuration>
                <reportSets>
                    <reportSet>
                        <reports>
                            <report>pmd</report>
                            <report>cpd</report>
                        </reports>
                    </reportSet>
                </reportSets>
            </plugin>
            
        </plugins>
    </reporting>

</project>
