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
package org.apache.myfaces.renderkit.html.behavior;

import javax.faces.component.UIComponent;
import javax.faces.component.html.HtmlOutcomeTargetButton;

import org.apache.myfaces.application.NavigationHandlerImpl;
import org.apache.myfaces.shared.renderkit.ClientBehaviorEvents;
import org.apache.myfaces.shared.renderkit.html.HTML;
import org.apache.myfaces.shared.util.ArrayUtils;

/**
 * @author Leonardo Uribe (latest modification by $Author: bommel $)
 * @version $Revision: 1187701 $ $Date: 2011-10-22 07:21:54 -0500 (Sat, 22 Oct 2011) $
 */
public class HtmlOutcomeTargetButtonClientBehaviorRendererTest extends AbstractClientBehaviorTestCase
{
    private HtmlRenderedClientEventAttr[] attrs = null;
    
    @Override
    public void setUp() throws Exception
    {
        super.setUp();
        attrs =  (HtmlRenderedClientEventAttr[]) 
                ArrayUtils.concat(HtmlClientEventAttributesUtil.generateClientBehaviorEventAttrs(),
                new HtmlRenderedClientEventAttr[]{
                    new HtmlRenderedClientEventAttr(HTML.ONFOCUS_ATTR, ClientBehaviorEvents.FOCUS),
                    new HtmlRenderedClientEventAttr(HTML.ONBLUR_ATTR, ClientBehaviorEvents.BLUR)                    
                });
    }
    
    

    @Override
    protected void setUpApplication() throws Exception
    {
        super.setUpApplication();
        application.setNavigationHandler(new NavigationHandlerImpl());
    }

    @Override
    public void tearDown() throws Exception
    {
        super.tearDown();
        attrs = null;
    }

    @Override
    protected UIComponent createComponentToTest()
    {
        return new HtmlOutcomeTargetButton();
    }

    @Override
    protected HtmlRenderedClientEventAttr[] getClientBehaviorHtmlRenderedAttributes()
    {
        return attrs;
    }
}
