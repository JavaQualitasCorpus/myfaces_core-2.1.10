/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package org.apache.myfaces.config.annotation;

import java.lang.reflect.InvocationTargetException;

import javax.naming.NamingException;

/**
 * Proposed interface to annotation service. An implementation of this class needs to know the appropriate classloader,
 * dependencies to be injected, and lifecycle methods to be called.
 *
 * @version $Rev: 1188686 $ $Date: 2011-10-25 09:59:52 -0500 (Tue, 25 Oct 2011) $
 */
public interface LifecycleProvider
{

    /**
     * Create an object of the class with the supplied name, inject dependencies as appropriate,
     * and call a postContruct method as appropriate.
     *
     * @param className name of the class of the desired object
     * @return a fully constructed, dependency-injected, and initialized object.
     */
    Object newInstance(String className)
            throws ClassNotFoundException, IllegalAccessException, InstantiationException,
            NamingException, InvocationTargetException;

    /**
     * Take whatever steps are needed to shut down the object, including calling a preDestroy method.
     *
     * @param o object to shut down.
     */
    void destroyInstance(Object o) throws IllegalAccessException, InvocationTargetException;
}
