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
package javax.faces.component;

import javax.faces.context.FacesContext;

import org.easymock.classextension.EasyMock;
import org.easymock.classextension.IMocksControl;
import org.testng.annotations.BeforeMethod;

/**
 * @author Mathias Broekelmann (latest modification by $Author: bommel $)
 * @version $Revision: 1187701 $ $Date: 2011-10-22 07:21:54 -0500 (Sat, 22 Oct 2011) $
 */
public abstract class UIComponentTestBase
{
    protected IMocksControl _mocksControl;
    protected FacesContext _facesContext;

    @BeforeMethod(alwaysRun = true)
    protected void setUp() throws Exception
    {
        _mocksControl = EasyMock.createNiceControl();
        _facesContext = _mocksControl.createMock(FacesContext.class);
    }
}